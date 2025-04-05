//// Draw Sprite Nine Sliced
/// @arg {Asset.GMSprite} sprite
/// @arg {Real} subimg
/// @arg {Real} x
/// @arg {Real} y
/// @arg {Real} image_xscale
/// @arg {Real} image_yscale
/// @arg {Real} scale
/// @arg {Real} angle
/// @arg {Constant.Color} color
/// @arg {Real} alpha
function draw_nineslice()
{
	var _sprite			= argument0;
	var _subimg			= argument1;
	var _x				= argument2;
	var _y				= argument3;
	var _xscale			= argument4;
	var _yscale			= argument5;
	var _scale			= argument6;
	var _rot			= argument7;
	var _col			= argument8;
	var _alp			= argument9;
	
	var _x_off = sprite_get_xoffset(_sprite);
	var _y_off = sprite_get_yoffset(_sprite);
	
    var _m = matrix_get(matrix_world); // get current matrix
  
    var _new_m = matrix_build(_x,_y,0, 0,/*current_time/6*/0,0, 1/_scale, 1/_scale, 0);
	
	//var _new_m = matrix_build_projection_perspective_fov(60, -global.res_width/global.res_height, 3, 3000);
	//camera_set_proj_mat(camera_get_active(), _new_m);
	
    matrix_set(matrix_world, _new_m);
	
 // gpu_set_tex_filter(true);
	
    draw_sprite_ext(_sprite,_subimg,0,0,_xscale*_scale,_yscale*_scale,_rot,_col,_alp);
	
  //gpu_set_tex_filter(false);
    matrix_set(matrix_world, _m); // revert matrix

	
}