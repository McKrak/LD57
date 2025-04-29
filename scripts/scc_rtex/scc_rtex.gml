function texnode(_path = "") : node() constructor {
    path = _path;
	name = "Texture";
	type = NODE_TEXTURE;
	
    buf_texture = -1;
	spr_texture = -1;
	frames = 1;
	
	ELEPHANT_SCHEMA {
		v1: {
            ELEPHANT_VERSION_VERBOSE : true,
			name: buffer_string,
            buf_texture: buffer_string,
			frames: buffer_u32
		}
	}
	
	//ELEPHANT_PRE_WRITE_METHOD {
		//if (sprite_exists(spr_texture)) {
			//spr_texture = sprite_to_base64(spr_texture);
		//}
	//}
	//
	//ELEPHANT_POST_WRITE_METHOD {
		//if (is_string(spr_texture)) {
			//spr_texture = base64_to_sprite(spr_texture);
		//}
	//}
	
	ELEPHANT_POST_READ_METHOD {
		if (is_string(buf_texture)) {
			spr_texture = sprite_add(buf_texture,0,0,0,0,0);
		}
	}

	function prompt_image() {
		//var _sprite = load_image();
		//if (_sprite[0] != noone) {
			//if sprite_exists(spr_texture) sprite_delete(spr_texture);
			//spr_texture = _sprite[0];
			//rpk_rename_node(self, filename_remove_extension(_sprite[1]));
		//}	
	}
    
    function set_texture(_spr) {
        if (file_exists(_spr)) {
            buf_texture = $"data:image/png;base64,";
            var _data = buffer_load(_spr);
            var _b64 = buffer_base64_encode(_data,0,buffer_get_size(_data));
            buffer_delete(_data);
            buf_texture += _b64;
            if (sprite_exists(spr_texture)) {
                sprite_delete(spr_texture);
            }
            spr_texture = sprite_add(buf_texture,0,0,0,0,0);
        }
        //if (sprite_exists(_spr)) {
            //spr_texture = _spr;
        //}
    }
	
	function remove() {
		if (sprite_exists(spr_texture)) sprite_delete(spr_texture);
        toggle(false);
        var _host = rpk_get_node(path, 1);
        search_and_remove(_host,self);
        return true;
	}
	
	static populate_nodetree = function() {
		if (instance_exists(d_sy)) {
			var _treenode_flags_sel = 
			ImGuiTreeNodeFlags.OpenOnArrow|
			ImGuiTreeNodeFlags.SpanAvailWidth|
			ImGuiTreeNodeFlags.FramePadding|
			ImGuiTreeNodeFlags.Leaf;
			if (sel) _treenode_flags_sel |= ImGuiTreeNodeFlags.Selected;
			var _node = imgui_tree_node_ex($"###nodelist_tex_{path}",_treenode_flags_sel);
			if (imgui_is_item_clicked() && !imgui_is_item_toggled_open()) {
				d_sy.__selection_handler(self);
			}
			if (imgui_begin_drag_drop_source(ImGuiDragDropFlags.None)) {
				imgui_set_drag_drop_payload("NODE",self);
				if (sprite_exists(spr_texture)) {
					imgui_sameline(); imgui_image(spr_texture,0,,,16,16);
				}
				imgui_sameline(); imgui_text($"{name}");
				imgui_end_drag_drop_source();
			}
			
			if (imgui_begin_popup_context_item($"nodelist_tex{name}_{self}_context")) {
				if (imgui_menu_item($"Replace Image...###nodelist_tex{name}_{self}_context_replace")) {
					prompt_image();
				}
				if (imgui_menu_item($"Rename###nodelist_tex{name}_{self}_context_rename")) {
					d_sy.rename_string = "";
					d_sy.modal_rename = true;
						
				}
				imgui_separator();
				if (imgui_menu_item($"Delete###nodelist_tex{name}{self}_context_delete")) {
					remove();
				}
				imgui_end_popup();
			}
			//imgui_sameline(); imgui_image(d_spu_node,_content.type,,,16,16);
			if (sprite_exists(spr_texture)) {
				imgui_sameline(); imgui_image(spr_texture,0,,,28/global.dpi_scale,28/global.dpi_scale);
			}
			imgui_sameline(); imgui_text($"{path}");
					
			//if (_node) {
			//	populate_rpk_nodetree(_content.spaces);
			//}
			imgui_tree_pop();
		}
	}
}

