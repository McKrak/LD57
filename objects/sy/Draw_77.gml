gpu_push_state();
gpu_set_blendenable(false);
draw_surface_stretched(application_surface, 0,0,global.res_width,global.res_height);
gpu_pop_state();