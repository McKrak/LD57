function Draw(_use_shader = false) {
	if (buff) {
		gpu_push_state();
        if culling == 1 gpu_set_cullmode(2);
            else if culling == 2 gpu_set_cullmode(1);
                else gpu_set_cullmode(0);
		gpu_set_texrepeat(tex_repeat);
		gpu_set_ztestenable(depth_test);
		gpu_set_zwriteenable(depth_write);
	
		if (_use_shader) {
			if (shader!= -4) shader_push(shader);
			switch(shader) {
				case shm_model:
					u_AmbientColor	= shader_get_uniform(shader, "u_AmbientColor");
					if (use_global_ambience) && instance_exists(si_luma) {
						shader_set_uniform_f(u_AmbientColor,color_get_red(si_luma.amb)/255,color_get_green(si_luma.amb)/255,color_get_blue(si_luma.amb)/255);
					} else {
						shader_set_uniform_f(u_AmbientColor,color_get_red(amb_color)/255,color_get_green(amb_color)/255,color_get_blue(amb_color)/255);
					}
				break;
			}
		}
		u_rigged_transforms = shader_get_uniform(shader_current(), "u_bonematrices"); // Get uniform handle for transform array in shd_tutorial4_rigged
		shader_set_uniform_matrix_array(u_rigged_transforms, bone_mat);	// Send final pose to shader
		
	
	
		matrix_set(matrix_world,mat);
		VBM_Model_Submit(buff,tex);
		//buff.Submit(pr_trianglelist,tex);
		matrix_set(matrix_world,matrix_build_identity());
		if _use_shader shader_pop();
	
		gpu_pop_state();
	}
	//matrix_set(matrix_world,matrix_build_identity());
}

//function LightMap() {
//	gpu_push_state();
//	gpu_set_cullmode(culling);
//	gpu_set_texrepeat(tex_repeat);
//	gpu_set_ztestenable(true);

//	shader_push(shm_lighting);
//	shader
//	u_bonetransforms = shader_get_uniform(shm_lighting, "u_bonetransforms");	// Find uniform handle to set bone transforms
//	shader_set_uniform_matrix_array(u_bonetransforms, anim.OutputPose());	// Sets uniform for shader
	
	
//	matrix_set(matrix_world,mat);
//	buff.SubmitIndex(0,pr_trianglelist,spr0);
//	buff.SubmitIndex(1,pr_trianglelist,spr1);
//	matrix_set(matrix_world,matrix_build_identity());
//	if _use_shader shader_pop();
	
//	gpu_pop_state();
	
//	//matrix_set(matrix_world,matrix_build_identity());
//}

function Update() {
	if (buff) {
		//if (collidable) {
		//	btCollisionObject_getWorldTransformMatrix(col_body, mat);
		//} else mat = matrix_build(x, y, z, xrot, yrot, zrot, xscale, yscale, zscale);
		mat = matrix_build(x, y, z, xrot, yrot, zrot, -xscale, yscale, zscale);
		anim_frame += .5*sy.dt;
		VBM_Model_SampleAnimationIndex_Mat4(buff, 0, anim_frame, bone_mat);
		//if (collidable) {
			//cm_dynamic_set_matrix(col_mesh, mat, false);
			//cm_dynamic_update_container(col_mesh,global.col_mesh);
		//}
		
		//buff.Update(.44*sy.dt);
		tex = sprite_get_texture(texture,pattern);
	}
}

function Build(_model) {
	vertex_begin(buff,form);

	var _x = _tile.x*48;
	var _y = _tile.y*48;
	var _z = _tile.z*48;
					
	var _buff = model_load(_model,form,false);
	var _raw_buff = buffer_create_from_vertex_buffer(_buff,buffer_fixed,1);
	// CODE HERE WILL MOVE THE CONTENTS OF THE BUFFER
	// ------------
	for (var l = 0; l < buffer_get_size(_raw_buff); l+=36) {
		var _xx = buffer_peek(_raw_buff, l+0,buffer_f32);
		var _yy = buffer_peek(_raw_buff, l+4,buffer_f32);
		var _zz = buffer_peek(_raw_buff, l+8,buffer_f32);
		var _nx = buffer_peek(_raw_buff, l+12,buffer_f32);
		var _ny = buffer_peek(_raw_buff, l+16,buffer_f32);
		var _nz = buffer_peek(_raw_buff, l+20,buffer_f32);
		var _cr = buffer_peek(_raw_buff, l+24,buffer_u8);
		var _cg = buffer_peek(_raw_buff, l+25,buffer_u8);
		var _cb = buffer_peek(_raw_buff, l+26,buffer_u8);
		var _ca = buffer_peek(_raw_buff, l+27,buffer_u8);
		var _tx = buffer_peek(_raw_buff, l+28,buffer_f32);
		var _ty = buffer_peek(_raw_buff, l+32,buffer_f32);

						
		var _matrix = matrix_build(_x,_y,_z,0,0,0,1,1,1);
						
		var _tf_pos = matrix_transform_vertex(_matrix,_xx,_yy,_zz);
						
		vertex_position_3d(buff,_tf_pos[0],_tf_pos[1],_tf_pos[2]);
		vertex_normal(buff,_nx,_ny,_nz);
		vertex_color(buff,make_color_rgb(_cr,_cg,_cb),_ca/255);
		vertex_texcoord(buff,_tx,_ty);
	}
	vertex_delete_buffer(_buff);
	buffer_delete(_raw_buff);
	vertex_end(buff);
}

function LoadAnimation(_ani_file) {
	VBM_OpenVBM(_ani_file,buff);
}


//function Freeze() {
//	if (!frozen) {
//		vertex_freeze(buff);
//		frozen = true;
//	} else {
//		print($"NOTICE: Buffer in {mesh} ({id}) already frozen!");
//	}
//}

//if (frozen) vertex_freeze(buff);



function __colmesh_handler() {
	if (collidable) {
		if (col_mesh == noone) && (buff) {
			col_octree = cm_octree(100); //Creates the collision mesh
			for (var i = 0; i < array_length(buff.meshes); i++) {
				cm_add_buffer(col_octree,buff.meshes[i].rawbuffer,68,,,,CM_GROUP_TRIGGER); //adds rvx to colmesh
			}
			col_mesh = cm_dynamic(col_octree,mat); //Creates a dynamic colmesh?
			//Adds the custom property, where col_func is the function that occurs whenever a ray intersects
			//the colmesh
			if (col_group == CM_GROUP_TRIGGER) && (host != noone) {
				cm_custom_parameter_set(col_mesh, host);
			}
			cm_add(global.col_mesh,col_mesh); //Adds dynamic mesh to global col_mesh
		}
	} else {
		if (col_mesh != noone) {
			//cm_remove(col_container,col_mesh);
			cm_remove(global.col_mesh,col_mesh);
			col_octree = noone;
			col_mesh = noone;
		}
	}
}


//form = vertex_format_create_simple(has_normal,has_color,has_texture);
//if (load_ext_model) {
//	raw_buff = buffer_load($"{path}{model}.rvx");
//	//buff = model_load($"{path}{model}.rvx",form,frozen);
//	buff = vertex_create_buffer_from_buffer(raw_buff,form);
//} else {
//	buff = vertex_create_buffer();
//}
mat = matrix_build(x, y, z, xrot, yrot, zrot, -xscale, yscale, zscale);
bone_mat = VBM_CreateMatrixArrayFlat(VBM_BONECAPACITY);

col = false;
col_mesh = noone;
col_container = noone;

anim = noone;
anim_frame = 0;

tex = sprite_get_texture(texture,pattern);



if from_file {
    buff = VBM_Model_Create();
    VBM_OpenVBM($"{ROOT_DIR}/{filename}.vbm",buff);
}






//if buff != noone anim = buff.CreateAnimator();



col_octree = noone;
col_mesh = noone;


//Update();