

light_near = 32;
light_far = 4096;
light_shadow_direct_threshold = 0.001;
light_shadow_spot_threshold = 0.0001;


position	= new Vec3(0, 0, 0);
direct		= new Vec3(0, 0, 1);
up			= new Vec3(0, 1, 0);

color		= new Vec3(1, 1, 1);
mask		= sp_MaskDefaultl;
lpower		= 1;
ortho		= false;
size		= 0;
threshold	= 0;
quality		= 1;
shadowMap	= -1;
vievMat		= matrix_build_identity();
projMat		= matrix_build_identity();

u_dmap_LightSpaceMatrix		= shader_get_uniform(
	shm_shadowmap, "u_LightSpaceMatrix");

u_ligh_ShadowMap			= shader_get_sampler_index(
	shm_lighting, "u_ShadowMap");
u_ligh_LightMask			= shader_get_sampler_index(
	shm_lighting, "u_LightMask");
u_ligh_LightColor			= shader_get_uniform(
	shm_lighting, "u_LightColor");
u_ligh_Power				= shader_get_uniform(
	shm_lighting, "u_Power");
u_ligh_UseOrtho				= shader_get_uniform(
	shm_lighting, "u_UseOrtho");
u_ligh_ShadowThreshold		= shader_get_uniform(
	shm_lighting, "u_ShadowThreshold");
u_ligh_LightWorldViewMatrix	= shader_get_uniform(
	shm_lighting, "u_LightWorldViewMatrix");
u_ligh_LightProjMatrix		= shader_get_uniform(
	shm_lighting, "u_LightProjMatrix");

function SetAsDirectional(_size, _quality, _power) {
	ortho		= true;
	threshold	= light_shadow_direct_threshold;
	quality		= round(_quality);
	lpower		= _power;
	size		= round(_size);
	
	projMat		= matrix_build_projection_ortho(
		size*quality, size*quality, light_near, light_far);
		
	if (surface_exists(shadowMap)) surface_free(shadowMap);
	
	//if instance_exists(si_luma) && (si_luma.debug_lighting) updateDebugMesh();
}
function SetAsSpot(_size, _quality, _power) {
	ortho		= false;
	threshold	= light_shadow_spot_threshold;
	quality		= _quality;
	lpower		= _power;
	size		= round(_size);
	
	projMat		= matrix_build_projection_perspective(
		size*quality, size*quality, light_near, light_far);
		
	if (surface_exists(shadowMap)) surface_free(shadowMap);
	
	//if instance_exists(si_luma) && (si_luma.debug_lighting) updateDebugMesh();
}
function SetColor(_color, _mask) {
	color.SetColor(_color);
	mask	= _mask;
	
	//if instance_exists(si_luma) && (si_luma.debug_lighting) updateDebugMesh();
}
function SetPosition(_from, _to, _up) {
	static _origin = new Vec3(0, 0, 0);
	
	position.Copy(_from);
	up.Copy(_up);
	direct.FromTo(_from, _to);
	direct.Normalize();
	
	_origin.Copy(direct);
	_origin.Multiply(light_near);
	_origin.Subtract(position);
	_origin.Flip();
	
	vievMat = matrix_build_lookat(
		_origin.X,	_origin.Y,	_origin.Z,
		_to.X,		_to.Y,		_to.Z,
		_up.X,		_up.Y,		_up.Z);
	
	//if instance_exists(si_luma) && (si_luma.debug_lighting) updateDebugMesh();
}
function SetMatrix(_matrix) {
	vievMat = _matrix;
	
	//if instance_exists(si_luma) && (si_luma.debug_lighting) updateDebugMesh();
}
function Mapping() {
	var _lightVP = matrix_multiply(vievMat, projMat);
	//var _yflip = matrix_build(0,0,0,0,0,0,1,-1,1);
	if (!surface_exists(shadowMap))
		shadowMap = surface_create(
			min(max(size,1),16384),
			min(max(size,1),16384));
	surface_set_target(shadowMap);
	
		shader_set(shm_shadowmap);
		
		draw_clear(c_white);
		with (PARENT_DRAWABLE) {
			if (cast_shadow) {
				var _lightWVP = matrix_multiply(mat, _lightVP);
				//var _final = matrix_multiply(_lightWVP,_yflip);
				shader_set_uniform_matrix_array(
					other.u_dmap_LightSpaceMatrix, _lightWVP);
				Draw();
			}
		}
		
		shader_reset(); //additional
	
	surface_reset_target();
}
function Draw() {
	shader_set(shm_lighting);
	
	var _texShadowMap	= surface_get_texture(shadowMap),
		_teLightMask	= sprite_get_texture(mask, 0);
	texture_set_stage(		u_ligh_ShadowMap,		_texShadowMap);
	texture_set_stage(		u_ligh_LightMask,		_teLightMask);
	shader_set_uniform_f(	u_ligh_LightColor,		color.X, color.Y, color.Z);
	shader_set_uniform_f(	u_ligh_Power,			lpower);
	shader_set_uniform_i(	u_ligh_UseOrtho,		ortho);
	shader_set_uniform_f(	u_ligh_ShadowThreshold,	threshold);
	shader_set_uniform_matrix_array(
							u_ligh_LightProjMatrix,	projMat);
	
	with (PARENT_DRAWABLE) {
		var _lightWV = matrix_multiply(mat, other.vievMat);
		shader_set_uniform_matrix_array(
			other.u_ligh_LightWorldViewMatrix, _lightWV);
		Draw();
	}
	
	shader_reset(); //addtnl
}

debugMesh = noone;

//if instance_exists(si_luma) {
    //if (si_luma.debug_lighting) {
    	//debugMesh = Create_WireMesh(-1);
    	//
    	//function updateDebugMesh() {
    		//static _right	= new Vec3(0, 0, 0);
    		//static _up		= new Vec3(0, 0, 0);
    		//static _corners = [
    			//new Vec3(0, 0, 0),
    			//new Vec3(0, 0, 0),
    			//new Vec3(0, 0, 0),
    			//new Vec3(0, 0, 0)];
    		//
    		//debugMesh.Reset();
    		//
    		//_right.Cross(direct, up);
    		//_right.Normalize();
    		//_up.Cross(direct, _right);
    	//
    		//_right.Multiply(size*0.5);
    		//_up.Multiply(size*0.5);
    	//
    		//for (var i = 0; i < 4; ++i) {
    			//_corners[@i].Copy(position);
    			//if (i < 2)			_corners[@i].Add(_right);
    			//else				_corners[@i].Subtract(_right);
    			//if (i > 0 && i < 3)	_corners[@i].Add(_up);
    			//else				_corners[@i].Subtract(_up);
    		//}
    //
    		//var _col = color.GetColor(),
    			//_uvs = new Vec2(0, 0),
    			//_from, _to, _arrow;
    		//for (var i = 0; i < 4; ++i) {
    			//_from	= new Vec3(
    				//_corners[@i].X,
    				//_corners[@i].Y,
    				//_corners[@i].Z);
    			//_to		= new Vec3(
    				//_corners[@(i+1)mod 4].X,
    				//_corners[@(i+1)mod 4].Y,
    				//_corners[@(i+1)mod 4].Z);
    			//if (ortho) {
    				//_arrow = new Vec3(
    					//_corners[@i].X + direct.X*light_near,
    					//_corners[@i].Y + direct.Y*light_near,
    					//_corners[@i].Z + direct.Z*light_near);
    			//} else {
    				//_arrow = new Vec3(
    					//_corners[@i].X*2 + direct.X*light_near - position.X,
    					//_corners[@i].Y*2 + direct.Y*light_near - position.Y,
    					//_corners[@i].Z*2 + direct.Z*light_near - position.Z);
    			//}
    			//debugMesh.AddLine(
    				//new Vertex(_from, _uvs, _col, 1),
    				//new Vertex(_to,	  _uvs, _col, 1));
    			//debugMesh.AddLine(
    				//new Vertex(_from,  _uvs, _col, 1),
    				//new Vertex(_arrow, _uvs, _col, 1));
    		//}
    	//}
    //}
//}