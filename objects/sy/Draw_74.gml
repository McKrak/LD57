    //for (var i = 0; i < instance_number(GRP_UI); i++) {
        //with (instance_find(GRP_UI,i)) {
            ////print("GURT");
            ////gpu_push_state();
            ////gpu_set_ztestenable(true);
            ////gpu_set_zwriteenable(true);
            ////gpu_set_depth(depth);
            //event_user(0);
            ////gpu_pop_state();
        //}
    //}

    surface_set_target(application_surface);
    draw_clear_alpha(c_black,0);
    gpu_push_state();
    //gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
    //gpu_set_colorwriteenable(true,true,true,false);
    var _c = view_camera[0];

    camera_apply(cam_ui);
    for (var i = 0; i < instance_number(GRP_UI); i++) {
        with (instance_find(GRP_UI,i)) {
            //print("GURT");
            //gpu_push_state();
            //gpu_set_ztestenable(true);
            //gpu_set_zwriteenable(true);
            //gpu_set_depth(depth);
            event_user(0);
            //gpu_pop_state();
        }
    }
    
    camera_apply(_c);
    gpu_pop_state();
    surface_reset_target();





