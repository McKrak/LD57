function meshnode(_path = "") : node() constructor {
    path = _path;
	type = NODE_MESH;
	
	ref_material = "";


	ELEPHANT_SCHEMA {
		v1: {
            ELEPHANT_VERSION_VERBOSE : true,
            name: buffer_string,
			ref_material: buffer_string,
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
                    
                imgui_sameline(); imgui_image(d_spu_node,8,#2060FF,,32/global.dpi_scale,32/global.dpi_scale);
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
        ref_material = imgui_input_text($"Material###nodeprop_obj_material", ref_material); _refresh_mesh();
    }
}

