gpu_push_state();
    surface_set_target(surf_ui);
    var _c = view_camera[0];
    camera_apply(cam_ui);
    draw_clear_alpha(c_black,0);

    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
    //gpu_set_colorwriteenable(true,true,true,false);

    //var _layers = layer_get_all();
    //for (var i = 0; i < array_length(_layers); i++) {
        //var _elements = layer_get_all_elements(_layers[i]);
        //for (var j = 0; j < array_length(_elements); j++) {
            //var _inst = layer_get_
            //if (layer_get_element_type(_inst) == layerelementtype_instance) {
                //if (instance_exists(_inst)) {
                    //if (object_get_parent(_inst) == GRP_UI) {
                        //print("GURT");
                        //with (_inst) {
                            //event_user(0);
                        //}
                    //}
                //}
//
            //}
        //}
    //}

    for (var i = 0; i < instance_number(GRP_UI); i++) {
        gpu_push_state();
        with (instance_find(GRP_UI,i)) {
            //print("GURT");
            
            //gpu_set_depth(layer_get_depth(layer));
            //gpu_set_ztestenable(true);
            //gpu_set_zwriteenable(true);
            //print($"{object_index}: {layer_get_depth(layer)}");


            shader_set(shd_ui);
            var _d = gpu_get_depth();
            gpu_set_depth(depth);
            event_user(0);
            gpu_set_depth(_d);
            shader_reset();
        }
        gpu_pop_state();
    }

    //with (GRP_UI) {
        ////shader_set(shd_ui);
//
        //event_user(0);
        //
        //
        ////shader_reset();
    //}
    camera_apply(_c);
    surface_reset_target();
gpu_pop_state();


gpu_push_state();
    surface_set_target(surf_view);
    var _c = view_camera[0];
    camera_apply(cam_ui);
    draw_clear_alpha(c_black,0);
    for (var i = 0; i < instance_number(obv_3dcam); i++) {
        with (instance_find(obv_3dcam,i)) {
            //print(gpu_get_depth());
            event_user(0);
        }
    }
    camera_apply(_c);
    surface_reset_target();
gpu_pop_state();

gpu_push_state();
surface_set_target(application_surface);
    draw_clear_alpha(c_black,0);
    gpu_set_blendenable(false);
    //gpu_set_depth(0);
    if (surface_exists(surf_view)) draw_surface_stretched(surf_view, 0,0,global.res_width,global.res_height); 
        gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true,true,true,false);
    if (surface_exists(surf_ui)) draw_surface_stretched(surf_ui, 0,0,global.res_width,global.res_height);
        surface_reset_target();
gpu_pop_state();
//



