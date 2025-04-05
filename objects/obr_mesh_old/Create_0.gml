form = vertex_format_create_simple(has_normal,has_color,has_texture);
if (load_ext_model) {
	raw_buff = buffer_load($"{path}{model}.rvx");
	//buff = model_load($"{path}{model}.rvx",form,frozen);
	buff = vertex_create_buffer_from_buffer(raw_buff,form);
} else {
	buff = vertex_create_buffer();
}
mat = matrix_build(x, y, z, xrot, yrot, zrot, xscale, yscale, zscale);

col = false;
col_mesh = noone;
col_container = noone;

function Draw(_use_shader = false) {
	gpu_set_cullmode(culling);
	gpu_set_texrepeat(tex_repeat);
	gpu_set_ztestenable(true);
	
	if (_use_shader) {
		if (shader!= -4) shader_set(shader);
		switch(shader) {
			case shm_ambient:
				u_AmbientColor	= shader_get_uniform(shm_ambient, "u_AmbientColor");
				if (use_global_ambience) {
					shader_set_uniform_f(u_AmbientColor,color_get_red(si_luma.amb)/255,color_get_green(si_luma.amb)/255,color_get_blue(si_luma.amb)/255);
				} else {
					shader_set_uniform_f(u_AmbientColor,color_get_red(amb_color)/255,color_get_green(amb_color)/255,color_get_blue(amb_color)/255);
				}
			break;
		}
	}

	if (sprite_exists(texture)) {
		tex = sprite_get_texture(texture,pattern);
	} else tex = -1;
	
	matrix_set(matrix_world, mat);
	vertex_submit(buff, pr_trianglelist, tex);
	
	if (_use_shader) shader_reset();
	
	gpu_set_cullmode(cull_noculling);
	gpu_set_texrepeat(false);
	gpu_set_ztestenable(true);
	
	matrix_set(matrix_world,matrix_build_identity());
}

function Update() {
	mat = matrix_build(x, y, z, xrot, yrot, zrot, xscale, yscale, zscale);
	if (collidable) {
		cm_dynamic_set_matrix(col_container, mat, false);
		cm_dynamic_update_container(col_container,global.col_mesh);
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


function Freeze() {
	if (!frozen) {
		vertex_freeze(buff);
		frozen = true;
	} else {
		print($"NOTICE: Buffer in {mesh} ({id}) already frozen!");
	}
}

if (frozen) vertex_freeze(buff);



function __colmesh_handler() {
	if (collidable) {
		if (col_mesh == noone) {
			print("NEW COLMESH");
			col_mesh = cm_octree(100); //Creates the collision mesh
			cm_add_buffer(col_mesh,buffer_load($"{path}{model}.rvx"),,,,,CM_GROUP_TRIGGER); //adds rvx to colmesh
			col_container = cm_dynamic(col_mesh,mat); //Creates a dynamic colmesh?
			//Adds the custom property, where col_func is the function that occurs whenever a ray intersects
			//the colmesh
			if (col_group == CM_GROUP_TRIGGER) && (host != noone) {
				cm_custom_parameter_set(col_container, host);
			}
			cm_add(global.col_mesh,col_container); //Adds dynamic mesh to global col_mesh
		}
	} else {
		if (col_mesh != noone) {
			print("DEL COLMESH");
			//cm_remove(col_container,col_mesh);
			cm_remove(global.col_mesh,col_container);
			col_container = noone;
			col_mesh = noone;
		}
	}
}

__colmesh_handler();


//Update();