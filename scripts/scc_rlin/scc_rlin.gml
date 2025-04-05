function lightnode() : node() constructor {
    name = "";
    type = ".rlin";
    
    color_r = 255;
    color_g = 255;
    color_b = 255;
    from_x = 0;
    from_y = 0;
    from_z = 0;
    to_x = 1;
    to_y = 0;
    to_z = 0;
    up_x = 0;
    up_y = 0;
    up_z = -1;
    light_type = 0;
    shadowmap = true;
    size = 64;
    strength = 1.0;
    quality = 1;
    clip_near = 32;
    clip_far = 4096;
    threshold_direct = 0.001;
    threshold_spot = 0.0001;
    
    inst = noone;
    
    static add_instance = function() {
        if (!instance_exists(inst)) {
            inst = Create_LightDirectional(size, quality, strength, 
            make_color_rgb(color_r, color_g, color_b), sp_MaskDefaultl, 
            new Vec3(from_x, from_y, from_z),
            new Vec3(to_x, to_y, to_z),
            new Vec3(up_x, up_y, up_z));
            
        }
    }
    
    static refresh = function(_pos = true, _col = true, _pow = true) {
        if (instance_exists(inst)) {
            //inst.SetAsDirectional(size, quality, strength);
            //inst.SetColor(make_color_rgb(color_r, color_g, color_b), sp_MaskDefaultl);
            if (_pow) {
                            inst.SetAsDirectional(size, quality, -strength);
                        }
            if (_pos) {
                inst.SetPosition(
                    new Vec3(from_x, from_y, from_z),
                    new Vec3(to_x, to_y, to_z),
                    new Vec3(up_x, up_y, up_z)
                );
            }
            if (_col) {
                inst.SetColor(make_color_rgb(color_r, color_g, color_b), sp_MaskDefaultl);
            }
            
            
        }
    }
    
    static toggle = function(_sel = undefined) {
        if _sel == undefined sel = !sel else sel = _sel;
        
        if (instance_exists(d_sy)) {
            if (sel) {
                if (!array_contains(d_sy.selected,self)) {
                    array_push(d_sy.selected,self);
                }
            } else {
                if (array_contains(d_sy.selected,self)) {
                    for (var i = 0; i < array_length(d_sy.selected); i++) {
                        if (d_sy.selected[i] == self) {
                            array_delete(d_sy.selected,i,1);
                        }
                    }
                }
            }
        }
    }
    
    static populate_nodetree = function(_index = 0) {
        if (instance_exists(d_sy)) {
            var _treenode_flags_sel = 
            ImGuiTreeNodeFlags.OpenOnArrow|
            ImGuiTreeNodeFlags.SpanAvailWidth|
            ImGuiTreeNodeFlags.Leaf|
            ImGuiTreeNodeFlags.FramePadding;
            if (sel) _treenode_flags_sel |= ImGuiTreeNodeFlags.Selected;
            
            var _node = imgui_tree_node_ex($"###nodelist_rpk_{path}",_treenode_flags_sel);
            if (imgui_is_item_clicked(ImGuiMouseButton.Left) && !imgui_is_item_toggled_open()) {
                d_sy.__selection_handler(self);
            }
                
            if (imgui_begin_popup_context_item($"nodelist_rpk_{path}_context")) {
                
                imgui_end_popup();
            }
                
            imgui_sameline(); imgui_image(d_spu_node,0,#FFEF40,,32/global.dpi_scale,32/global.dpi_scale);
            imgui_sameline(); imgui_text($"{path}");
                
            //if (_node) {
                //for (var i = 0; i < array_length(content); i++) {
                    //content[i].populate_nodetree(++_index);
                //}
                ////populate_rpk_nodetree(_content.content);
                //imgui_tree_pop();
            //}
            imgui_tree_pop();
        }
    }
    static __change_handler = function(_liveupdate = false, _pow = false) {
        var _dorefresh = false;
        if _liveupdate _dorefresh = imgui_is_item_edited();
        else _dorefresh = imgui_is_item_deactivated_after_edit();    
        if (_dorefresh) {
            refresh(true, false, _pow); 
        }
    }
    
    static __thres_change_handler = function() {
        if imgui_is_item_edited() && (instance_exists(inst)) {
            inst.light_shadow_direct_threshold = threshold_direct;
            inst.light_shadow_spot_threshold = threshold_spot;
            inst.light_near = clip_near;
            inst.light_far = clip_far;
            refresh(true,false,true);
        }
    }
    
    static populate_nodeprop = function() {
        if (instance_exists(inst)) {
            if (surface_exists(inst.shadowMap)) {
                var _w = imgui_get_content_region_avail_x();
                imgui_surface(inst.shadowMap, c_white, 1, _w, _w);
                imgui_text_disabled($"{surface_get_width(inst.shadowMap)}x{surface_get_height(inst.shadowMap)}");
            }
        }
        
        imgui_separator_text("POSITION");
        imgui_text_disabled("From Position");
        from_x = imgui_drag_float($"###nodeprop_from_x",from_x); __change_handler(true);
        from_y = imgui_drag_float($"###nodeprop_from_y",from_y); __change_handler(true);
        from_z = imgui_drag_float($"###nodeprop_from_z",from_z); __change_handler(true);
        imgui_text_disabled("To Position");
        to_x = imgui_drag_float($"###nodeprop_to_x",to_x); __change_handler(true);
        to_y = imgui_drag_float($"###nodeprop_to_y",to_y); __change_handler(true);
        to_z = imgui_drag_float($"###nodeprop_to_z",to_z); __change_handler(true);
        imgui_text_disabled("Up");
        up_x = imgui_input_int($"###nodeprop_up_x", up_x); __change_handler(true);
        up_y = imgui_input_int($"###nodeprop_up_y", up_y); __change_handler(true);
        up_z = imgui_input_int($"###nodeprop_up_z", up_z); __change_handler(true);
        
        imgui_separator_text("COLOR");
        var _col = imgui_color_edit3($"###nodeprop_light_color", make_color_rgb(color_r,color_g,color_b));
        if (imgui_is_item_edited()) {
            color_r = color_get_red(_col);
            color_g = color_get_green(_col);
            color_b = color_get_blue(_col);
            refresh(false, true, false);
        }
        
        imgui_separator_text("QUALITY");
        imgui_text_disabled("Size");
        size = imgui_drag_int($"###nodeprop_size",size,1,1,64); __change_handler(true, true);
        imgui_text_disabled("Quality");
        quality = imgui_drag_float($"###nodeprop_quality",quality, 1,1,8); __change_handler(true, true);
        imgui_text_disabled("Strength");
        strength = imgui_drag_float($"###nodeprop_strength",strength); __change_handler(true, true);
        
        imgui_separator_text("CLIPPING");
        threshold_direct = imgui_drag_float($"###nodeprop_tdirect", threshold_direct, 0.001, 0.0000001, 1); __thres_change_handler();
        threshold_spot = imgui_drag_float($"###nodeprop_tspot", threshold_spot, 0.001, 0.0000001, 1); __thres_change_handler();
        clip_near = imgui_drag_float($"###nodeprop_clip_near", clip_near, 1, 0.001, 8192); __thres_change_handler();
        clip_far = imgui_drag_float($"###nodeprop_clip_far", clip_far, 1, 0.001, 8192); __thres_change_handler();
    }
    
    ELEPHANT_SCHEMA {
        v1: {
            ELEPHANT_VERSION_VERBOSE : true,
            name: buffer_string,
            color_r: buffer_u8,
            color_g: buffer_u8,
            color_b: buffer_u8,
            from_x: buffer_f16,
            from_y: buffer_f16,
            from_z: buffer_f16,
            to_x: buffer_f16,
            to_x: buffer_f16,
            to_x: buffer_f16,
            up_x: buffer_s8,
            up_y: buffer_s8,
            up_z: buffer_s8,
            light_type: buffer_u8,
            shadowmap: buffer_bool,
            size: buffer_u16,
            strength: buffer_f16,
            quality: buffer_f16,
            clip_near: buffer_f16,
            clip_far: buffer_f16,
            threshold_direct: buffer_f16,
            threshold_spot: buffer_f16
        }
    }
}


