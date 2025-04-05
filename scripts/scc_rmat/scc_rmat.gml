function matnode(_path = "") : node() constructor {
    path = _path;
	type = NODE_MATERIAL;
	
	ref_texture0 = "";
	culling = cull_counterclockwise;
	tex_repeat = true;
    tex_filter = false;
    depth_test = true;
    depth_write = true;


	ELEPHANT_SCHEMA {
		v1: {
            ELEPHANT_VERSION_VERBOSE : true,
            name: buffer_string,
			culling: buffer_u8,
			tex_repeat: buffer_u8,
            tex_filter: buffer_bool,
            ref_texture0: buffer_string,
            depth_test: buffer_bool,
            depth_write: buffer_bool
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
                    
                imgui_sameline(); imgui_image(d_spu_node,7,#A0FF48,,32/global.dpi_scale,32/global.dpi_scale);
                imgui_sameline(); imgui_text($"{path}");
                    

                imgui_tree_pop();
            }
        }
    
    static populate_nodeprop = function() {
        var _refresh_mesh = function() { 
            if (imgui_is_item_deactivated_after_edit()) {
                var _host = rpk_get_node(path,1);
                if (_host != undefined) {
                    _host.refresh();    
                }
            }
        }
        ref_texture0 = imgui_input_text($"Texture 0###nodeprop_mat_texture0", ref_texture0); _refresh_mesh();
        var _cnames = ["No Culling", "Cull Counter-Clockwise", "Cull Clockwise"];
        if imgui_begin_combo("###nodeprop_cullmode",$"{_cnames[culling]}",ImGuiComboFlags.None) {
            for (var i = 0; i < 3; i++) {
                if (imgui_selectable($"{_cnames[i]}###nodeprop_cullmode_combo_{i}", culling == i)) {
                    culling = i;
                }
            }
            imgui_end_combo();
        }
        _refresh_mesh();
        
        tex_repeat = imgui_checkbox("Repeat Texture", tex_repeat); _refresh_mesh();
        tex_filter = imgui_checkbox("Anti-Aliasing", tex_filter); _refresh_mesh();
        
        
    }
}

