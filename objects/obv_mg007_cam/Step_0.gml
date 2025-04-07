
if (use_global_resolution) {
    if (aspect_ratio == AR_DYNAMIC) {
        res_width = global.res_width;
        res_height = global.res_height;
        res_ratio_width = global.res_ratio_width;
        res_ratio_height = global.res_ratio_height;
    } else {
        res_width = global.res_width/global.res_ratio_width;
        res_height = global.res_height/global.res_ratio_height;
        res_ratio_width = global.res_ratio_width;
        res_ratio_height = global.res_ratio_height;
    }
} else {
	res_ratio_width = res_width/res_height;
	res_ratio_height = res_height/res_width;
}

if (surface_exists(output)) {
    view_visible[view] = true;
    room_set_view_enabled(room,view);
    view_surface_id[view] = output;

	if (surface_get_width(output) != res_width*output_xscale) 
	|| (surface_get_height(output) != res_height*output_yscale) {
		if (res_width*output_xscale > 0) && (res_height*output_yscale > 0) {
			surface_resize(output, res_width*output_xscale, res_height*output_yscale);
		}
	}
}


if (is_3d) {
	if (free_look) {	
		var _cx = window_get_width()/2;
		var _cy = window_get_height()/2;
		var _mx = window_mouse_get_x();
		var _my = window_mouse_get_y();

		if (mouse_check_button(mb_right)) {
			look_dir -= (_mx - _cx)/10;
			look_pitch += (_my - _cy)/10;
			look_pitch = clamp(look_pitch,-90,90);
			window_mouse_set(_cx,_cy);
		}
		var _dt = delta_time/(277 + 7/9)/60;
		spd = (clamp(spd+(mouse_wheel_up()-mouse_wheel_down()),0,20));

		if (keyboard_check(ord("A"))) {
			x -= dsin(look_dir)*spd*_dt;
			y -= dcos(look_dir)*spd*_dt;
		}
		if (keyboard_check(ord("D"))) {
			x += dsin(look_dir)*spd*_dt;
			y += dcos(look_dir)*spd*_dt;
		}
		if (keyboard_check(ord("W"))) {
			x += dcos(look_dir)*spd*_dt;
			y -= dsin(look_dir)*spd*_dt;
		}
		if (keyboard_check(ord("S"))) {
			x -= dcos(look_dir)*spd*_dt;
			y += dsin(look_dir)*spd*_dt;
		}
		z += (keyboard_check(ord("E")) - keyboard_check(ord("Q")))*spd*_dt;
	}
	xto = x + dcos(look_dir);
	yto = y - dsin(look_dir);
	zto = z - dtan(look_pitch);
		
	proj_mat = matrix_build_projection_perspective_fov(-60, -res_width/res_height, 3, draw_distance_far);
	camera_set_proj_mat(camera, proj_mat);
	view_mat = matrix_build_lookat(x,y,z,xto,yto,zto, 0,0,1);
	camera_set_view_mat(camera, view_mat);
} else {
	if (free_look) {	
		if (keyboard_check(ord("A"))) {
			x -= spd*sy.dt;
		}
		if (keyboard_check(ord("D"))) {
			x += spd*sy.dt;
		}
		if (keyboard_check(ord("W"))) {
			y -= spd*sy.dt;
		}
		if (keyboard_check(ord("S"))) {
			y += spd*sy.dt;
		}
        if (keyboard_check(ord("E"))) {
            ortho_zoom += .1*sy.dt;
        }
        if (keyboard_check(ord("Q"))) {
            ortho_zoom -= .1*sy.dt;
        }
	}
	
    camera_set_view_size(camera, res_width/ortho_zoom/global.min_scale , res_height/ortho_zoom/global.min_scale);
    camera_set_view_pos(camera, x - align_x * (res_width/ortho_zoom/2/global.min_scale) ,y - align_y * (res_height/ortho_zoom/2/+global.min_scale));
    if (instance_exists(obu_cursor)) {
        var _x = max(obu_cursor.x, 0);
        var _y = max(obu_cursor.y,0);
        cursor_x = _x/ortho_zoom + x - align_x * (res_width/ortho_zoom/2/global.min_scale);
        cursor_y = _y/ortho_zoom + y - align_y * (res_height/ortho_zoom/2/+global.min_scale);
    }
    //proj_mat = matrix_build_projection_ortho(res_width*ortho_zoom, res_height*ortho_zoom, 1, draw_distance_far);
    //camera_set_proj_mat(camera, proj_mat);
    //view_mat = matrix_build_lookat(x,y,z+1000,x,y,z, 0,0,1);
    //camera_set_view_mat(camera, view_mat);
}
