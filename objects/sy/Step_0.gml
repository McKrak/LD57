/// @description Insert description here
// You can write your code in this editor

	t++;
dt = delta_time/(277 + 7/9)/60;

//if (conType = 0){
	//k_pause = keyboard_check_pressed(vk_escape);
//}
//if (conType = 1) {
	//k_pause = gamepad_button_check_pressed(0, gp_start);
//}

if (os_browser != browser_not_a_browser) || (os_type == os_gxgames) {
    global.win_width = browser_width;
    global.win_height = browser_height;
    window_set_size(global.win_width,global.win_height);
} else {
    global.win_width = window_get_width(); 
    global.win_height = window_get_height();
}



//if (global.aspect_ratio_mode == AR_DYNAMIC) {
    global.res_width = global.win_width;
    global.res_height = global.win_height;
//} else {
    //var _w_factor = global.win_width/NATIVE_W;
    //var _h_factor = global.win_height/NATIVE_H;
    //var _min = min(_w_factor, _h_factor);
    //var _w_ratio = max(_w_factor/_h_factor,1);
    //var _h_ratio = max(_h_factor/_w_factor,1);
    //global.res_width = global.win_width/_w_ratio;
    //global.res_height = global.win_height/_h_ratio;
//}
var _w_factor = global.res_width/NATIVE_W;
var _h_factor = global.res_height/NATIVE_H;
global.min_scale = min(_w_factor,_h_factor);
global.res_ratio_width = max(_w_factor/_h_factor,1);
global.res_ratio_height = max(_h_factor/_w_factor,1);

//camera_set_view_size(view_camera[0], global.res_width, global.res_height);

try {
	if (global.res_change)
    && ((global.res_width > 0) && (global.res_height > 0)) {
		surface_resize(application_surface, global.res_width, global.res_height);
	}
} catch(_) {
	
}

if (!surface_exists(surf_ui)) || (global.res_change) {
    if (global.res_width > 0) && (global.res_height > 0) {
        if (!surface_exists(surf_ui)) {
            surf_ui = surface_create(global.res_width,global.res_height);
        } else {
            surface_resize(surf_ui,global.res_width,global.res_height);
        }
    }
}

if (!surface_exists(surf_view)) || (global.res_change) {
    if (global.res_width > 0) && (global.res_height > 0) {
        if (!surface_exists(surf_view)) {
            surf_view = surface_create(global.res_width,global.res_height);
        } else {
            surface_resize(surf_view,global.res_width,global.res_height);
        }
    }
}

//camera_set_proj_mat(cam_ui, matrix_build_projection_ortho(NATIVE_W*global.res_ratio_width,NATIVE_H*global.res_ratio_height,0.3,32000));
//camera_set_view_mat(cam_ui,matrix_build_lookat(fc_x,fc_y,fc_z,fc_xto,fc_yto,fc_zto,0,0,1));



camera_set_view_size(cam_ui,NATIVE_W*global.res_ratio_width,NATIVE_H*global.res_ratio_height);
camera_set_view_pos(cam_ui, (NATIVE_W-(NATIVE_W*global.res_ratio_width))/2, (NATIVE_H-(NATIVE_H*global.res_ratio_height))/2);

var _ui_size = min(global.res_width/NATIVE_W,global.res_height/NATIVE_H);
display_set_gui_maximize(_ui_size,_ui_size,global.res_width/2-320*_ui_size,global.res_height/2-180*_ui_size);





#region FREECAM

if (true) && (global.config == "Debug") {	
    camera_set_proj_mat(cam_fc, matrix_build_projection_perspective_fov(60, global.res_width/global.res_height, 3, 32000));
    camera_set_view_mat(cam_fc,matrix_build_lookat(fc_x,fc_y,fc_z,fc_xto,fc_yto,fc_zto,0,0,1));
    if (keyboard_check(vk_shift) && (keyboard_check_pressed(ord("R")))) {
        fc_x = 0;
        fc_y = 0;
        fc_z = 0
        fc_xto = 0;
        fc_yto = 1;
        fc_zto = 1000;
        look_dir = 0;
        look_pitch = 0;
    }
    
    if (keyboard_check(vk_shift)) {
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
		var spd = 1;//(clamp(spd+(mouse_wheel_up()-mouse_wheel_down()),0,20));

		if (keyboard_check(ord("A"))) {
			fc_x -= dsin(look_dir)*spd*_dt;
			fc_y -= dcos(look_dir)*spd*_dt;
		}
		if (keyboard_check(ord("D"))) {
			fc_x += dsin(look_dir)*spd*_dt;
			fc_y += dcos(look_dir)*spd*_dt;
		}
		if (keyboard_check(ord("W"))) {
			fc_x += dcos(look_dir)*spd*_dt;
			fc_y -= dsin(look_dir)*spd*_dt;
		}
		if (keyboard_check(ord("S"))) {
			fc_x -= dcos(look_dir)*spd*_dt;
			fc_y += dsin(look_dir)*spd*_dt;
		}
		fc_z += (keyboard_check(ord("E")) - keyboard_check(ord("Q")))*spd*_dt;
        fc_xto = fc_x + dcos(look_dir);
    	fc_yto = fc_y - dsin(look_dir);
    	fc_zto = fc_z - dtan(look_pitch);    
        
    }

	//proj_mat = matrix_build_projection_perspective_fov(-60, -res_width/res_height, 3, draw_distance_far);
	//camera_set_proj_mat(camera, proj_mat);
	//view_mat = matrix_build_lookat(x,y,z,xto,yto,zto, 0,0,1);
	//camera_set_view_mat(camera, view_mat);
	}
		
#endregion


////DEBUG: Hide the GUI if needed.
//if (keyboard_check(ord("H"))) { 
	//display_set_gui_size(0,0);
//}

if (global.config == "Debug") {
    if (keyboard_check_pressed(vk_f10)) {
        texturegroup_set_mode(true,!texdebug,spi_missing);
        texdebug = !texdebug;
    }
    if (keyboard_check_pressed(vk_f12)) {
        room_restart();
    }
}

if (keyboard_check_pressed(vk_f11)) {
	if (window_get_fullscreen() = false) {
		window_set_fullscreen(true);
	}
	else {
		window_set_fullscreen(false);
	}
}

