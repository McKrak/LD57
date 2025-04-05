function skenode(_path = "") : node() constructor {
    path = _path;
	type = NODE_ANIM;

	buff = noone;
    buff_ske = "";
    
    speed = 1;


	ELEPHANT_SCHEMA {
		v1: {
            ELEPHANT_VERSION_VERBOSE : true,
			name: buffer_string,
			buff_ske: buffer_string
		}
	}
    

    

	ELEPHANT_PRE_WRITE_METHOD {
		buff_ske = buffer_base64_encode(buff,0,buffer_get_size(buff));
	}
    
    ELEPHANT_POST_READ_METHOD {
        buff = buffer_base64_decode(buff_ske);
    }

    static toggle = function(_sel = undefined) {
        if _sel == undefined sel = !sel else sel = _sel;
        
        if (instance_exists(d_sy)) {
            if (sel) {
                if (!array_contains(d_sy.selected,self)) {
                    array_push(d_sy.selected,self);
                    push_anim();
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
    
    static push_anim = function() {
        if (d_sy.context != noone) {
            if (d_sy.context.type == NODE_MODEL) {
                if (is_struct(d_sy.context.vbm)) {
                    VBM_OpenVBM(buff, d_sy.context.vbm, VBM_OPENFLAGS.FROM_BUFFER);
                }
            }
        }
    }
    
	static prompt = function() {
		try {
			var _file = get_open_filename("DMR-VBM Model File (.vbm)|*.vbm", "");
			if (_file != "") {
				buff = buffer_load(_file);
                rpk_rename_node(self, filename_remove_extension(_file) + type);
				
                print(buff);
			}
		} catch (_err) {
			//buff = noone;
			print(_err);
		}
	}
    
    static populate_nodetree = function(_index = 0) {
        if (instance_exists(d_sy)) {
            var _treenode_flags_sel = 
            ImGuiTreeNodeFlags.OpenOnArrow|
            ImGuiTreeNodeFlags.SpanAvailWidth|
            ImGuiTreeNodeFlags.FramePadding|
            ImGuiTreeNodeFlags.Leaf;
            if (sel) _treenode_flags_sel |= ImGuiTreeNodeFlags.Selected;
            
            var _node = imgui_tree_node_ex($"###nodelist_rpk_{path}",_treenode_flags_sel);
            if (imgui_is_item_clicked() && !imgui_is_item_toggled_open()) {
                d_sy.__selection_handler(self);
            }
                
            if (imgui_begin_popup_context_item($"nodelist_rpk_{path}_context")) {
                imgui_end_popup();
            }
                
            imgui_sameline(); imgui_image(d_spu_node,4,#64F4BE,,32/global.dpi_scale,32/global.dpi_scale);
            imgui_sameline(); imgui_text($"{path} ({_index})");
                
            imgui_tree_pop();
        }
    }
	
	static remove = function() {
		if (buffer_exists(buff)) buffer_delete(buff);
		toggle(false);
        var _host = rpk_get_node(path, 1);
        search_and_remove(_host,self);
        return true;
	}
}

