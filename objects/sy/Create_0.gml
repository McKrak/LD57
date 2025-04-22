/// @description The main broode of the game

//First before anything, we randomize everything!
randomize();
dbg_data = {};
mem_data = {};
memory = [];
//dt = delta_time/(277 + 7/9)/60;

dt = delta_time/1000000;

//show_debug_log(true);





gpu_set_zwriteenable(true);//Enables writing to the z-buffer

//gpu_set_ztestenable(true);//Enables depth testing, so far away things are drawn beind closer things


	//view_set_wport(0,1280);
	//view_set_hport(0,180);
	
//application_surface_draw_enable(false);



function fetch_debug_info() {
    if (os_browser == browser_not_a_browser) {
        var _meminfo = debug_event("DumpMemory", true);
        global.mem_used = _meminfo.totalUsed / 1048576;
        global.mem_free = _meminfo.free / 1048576;
        delete _meminfo;
    }
    //var _osinfo = os_get_info(); 
    //global.gpuname = _osinfo[? "video_adapter_description"];
    //ds_map_destroy(_osinfo);
}
//window_enable_borderless_fullscreen(true);

gp = [];

gu_width = display_get_gui_width();
gu_height = display_get_gui_height();

cam_ui = camera_create_view(0,0,NATIVE_W,NATIVE_H);


conType = 0;

cur_string = "";
scary_fade = 0;

pause = 0;
canPause = true;

loading = 0;
loading_fade_exit = 0;
loading_fade = 0;
target_room = noone;
transition = noone;

t = 0;
snd_loading = -1;
hover_index = 0;

paused = false;
paused_surf = -1;

p1in = false;
p2in = false;
p3in = false;
p4in = false;

uiScale = 1;

texdebug = false;


//show_debug_overlay(true);
fetch_debug_info();
alarm[0] = 1;

room_goto_next();