if (instance_exists(obv_3dcam)) {
    if (surface_exists(obv_3dcam.output)) {
        if !surface_exists(surf) surf = surface_create(obv_3dcam.res_width,obv_3dcam.res_height);
        surface_copy(surf,0,0,obv_3dcam.output);
        
        gpu_push_state();
        gpu_set_depth(10);
        draw_surface_stretched(surf,x,y,obv_3dcam.res_width,obv_3dcam.res_height);
        gpu_pop_state();
    }
}



    //if (!surface_exists(surf)) {
  
            //surface_copy(surf,0,0,obv_3dcam.output);
        
    //} 


