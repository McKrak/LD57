    gpu_push_state();
    gpu_set_blendenable(false)
    draw_surface_stretched(application_surface, 0,0,global.res_width,global.res_height);
    gpu_pop_state();

//if (surface_exists(surf_ui)) {
    //gpu_push_state();
    //gpu_set_blendenable(false)
    //draw_surface_stretched(surf_ui, 0,0,global.res_width,global.res_height);
    //gpu_pop_state();
//}