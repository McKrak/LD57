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
global.res_change = false;
try {
	if ((surface_get_width(application_surface) != global.res_width
	|| surface_get_height(application_surface) != global.res_height))
    && ((global.res_width > 0) && (global.res_height > 0)) {
		global.res_change = true;
		surface_resize(application_surface, global.res_width, global.res_height);
	}
} catch(_) {
	
}

var _ui_size = min(global.res_width/NATIVE_W,global.res_height/NATIVE_H);
//if (global.aspect_ratio_mode == AR_DYNAMIC) { 
    display_set_gui_maximize(_ui_size,_ui_size,global.res_width/2-320*_ui_size,global.res_height/2-180*_ui_size);
//} else {
    //display_set_gui_maximize(_ui_size, _ui_size, 0,0)
//}

////DEBUG: Hide the GUI if needed.
//if (keyboard_check(ord("H"))) { 
	//display_set_gui_size(0,0);
//}

if (keyboard_check_pressed(vk_f10)) {
    texturegroup_set_mode(true,!texdebug,spi_missing);
    texdebug = !texdebug;
}
if (keyboard_check_pressed(vk_f11)) {
	if (window_get_fullscreen() = false) {
		window_set_fullscreen(true);
	}
	else {
		window_set_fullscreen(false);
	}
}
if (keyboard_check_pressed(vk_f12)) {
    room_restart();
}

