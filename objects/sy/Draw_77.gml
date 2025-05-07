if (surface_exists(surf_ui)) {
    gpu_push_state();
    surface_set_target(surf_ui);
    var _c = view_camera[0];
    camera_apply(cam_ui);
    draw_clear_alpha(c_black,0);

    
    gpu_set_blendenable(true);
    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
    //layer_force_draw_depth(true,0);
    //gpu_set_colorwriteenable(true,true,true,false);
    //gpu_set_alphatestenable(true);

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

    //for (var i = 0; i < instance_number(GRP_UI); i++) {
        //gpu_push_state();
        //with (instance_find(GRP_UI,i)) {
            ////print("GURT");
            //
            ////gpu_set_depth(layer_get_depth(layer));
            ////gpu_set_ztestenable(true);
            ////gpu_set_zwriteenable(true);
            ////print($"{object_index}: {layer_get_depth(layer)}");
//
//
            //shader_push(shd_ui);
            //var _d = gpu_get_depth();
            //gpu_set_depth(depth);
            //event_user(0);
            //gpu_set_depth(_d);
            //shader_pop();
        //}
        //gpu_pop_state();
    //}

    //with (GRP_UI) {
        ////print(object_get_name(object_index));
        //gpu_push_state();
        //shader_push(shd_ui);
        //var _d = gpu_get_depth();
        //gpu_set_depth(depth);
        //event_user(0);
        //gpu_set_depth(_d);
        //shader_pop();
        //gpu_pop_state();
    //}

    var _uidraws = [];
    for (var i = 0; i < instance_number(GRP_UI); i++) {
        array_push(_uidraws,instance_find(GRP_UI,i));
    }
    
    array_sort(_uidraws,function(_x, _y) {
       var _dx = _x.depth;
        var _dy = _y.depth;
        if (_dx == _dy) return 1 else
        return _dy - _dx;
    });

    for (var i = 0; i < array_length(_uidraws); i++) {
        gpu_push_state();
        with (_uidraws[i]) {
            shader_push(shd_ui);
            var _d = gpu_get_depth();
            gpu_set_depth(depth/10);
            event_user(0);
            gpu_set_depth(_d);
            shader_pop();
        }
        gpu_pop_state();
    }
    camera_apply(_c);
    //layer_force_draw_depth(false,0);
    surface_reset_target();
    gpu_pop_state();
}

shader_push();

if (surface_exists(surf_view)) {
    gpu_push_state();
    surface_set_target(surf_view);
    var _c = view_camera[0];
    camera_apply(cam_ui);
    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
    draw_clear_alpha(c_black,0);
    //shader_push(shd_default);
    for (var i = 0; i < instance_number(obv_3dcam); i++) {
        with (instance_find(obv_3dcam,i)) {
            //print(gpu_get_depth());
            event_user(0);
        }
    }
    //shader_pop();
    camera_apply(_c);
    surface_reset_target();
    gpu_pop_state();
}


gpu_push_state();
surface_set_target(application_surface);
    draw_clear_alpha(c_black,0);
    gpu_set_blendenable(true);
    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
    //shader_push(shd_default);
    //gpu_set_depth(0);
    if (surface_exists(surf_view)) draw_surface_stretched(surf_view, 0,0,global.res_width,global.res_height); 
        //gpu_set_blendenable(true);
    
    //gpu_set_colorwriteenable(true,true,true,false);
    if (surface_exists(surf_ui)) draw_surface_stretched(surf_ui, 0,0,global.res_width,global.res_height);
        //shader_pop();
        surface_reset_target();

gpu_pop_state();
//





gpu_push_state();
draw_clear_alpha(c_black,1);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
//shader_push(shd_default);
draw_surface_stretched(application_surface, 0,0,global.res_width,global.res_height);
//shader_pop();
gpu_pop_state();

shader_pop();