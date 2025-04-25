#macro ROOT_DIR "LD57"
#macro ROOT_DIR_BSIDE "Editor"
#macro VERSION "v0.0"
#macro VERSION_R [0, 0, 0, 0]

#macro c_rsblack $231f20
#macro c_pjyellow #eda52b

#macro NATIVE_W 640
#macro NATIVE_H 360
#macro UI_SCALE 4

#macro AR_169 0
#macro AR_DYNAMIC 1


#macro TEX_FILTER false

global.config = "Debug";
global.lang = { };
lang_set("enUS");

global.ref_rate = 60;
if (os_browser == browser_not_a_browser) {
    global.ref_rate = display_get_frequency();
}
global.win_width = NATIVE_W;
global.win_height = NATIVE_H;
global.res_width = NATIVE_W;
global.res_height = NATIVE_H;
var _w_factor = global.res_width/NATIVE_W;
var _h_factor = global.res_height/NATIVE_H;
global.min_scale = min(_w_factor,_h_factor);
global.res_ratio_width = max(_w_factor/_h_factor,1);
global.res_ratio_height = max(_h_factor/_w_factor,1);
global.aspect_ratio_mode = AR_169;
global.dpi_scale = display_get_dpi_y()/96;

global.surf_ui = -1;

global.res_change = false;

global.mem = [[],[]];
global.cur_mem = 1;

global.loading = false;
global.seq_loading = -1;



randomize();

//Print some debug stuff
show_debug_message( 
"\n" +
$"-----------------------------\n"+
"PROJECT LD57\n" +
"Game Jam\n" +
$"LD57 {VERSION}\n" +
$"Working Dir: {working_directory}\n" +
$"Save Dir: {game_save_id}\n" + 
$"Build Type: {global.config}\n" +
"-----------------------------\n"
);

texturegroup_set_mode(true,false,spi_missing);
texturegroup_load("ui_global",true);
//texturegroup_load("font_res",true);
game_set_speed(60, gamespeed_fps);
//gpu_set_zwriteenable(true);//Enables writing to the z-buffer
//gpu_set_ztestenable(true);//Enables depth testing, so far away things are drawn beind closer things
//layer_force_draw_depth(true, 0);
gpu_set_blendmode_ext(bm_one,bm_inv_src_alpha);
//gpu_set_blendenable(true);
//shader_set(shd_ui);
application_surface_enable(true);
application_surface_draw_enable(false);
window_set_cursor(cr_none);

scribble_font_set_default("fnt_main");




