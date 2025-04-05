function node() constructor {
    type = NODE_NONE;
	sel = false;
	host = noone;
    path = "";
	name = "";
    use_extension = true;
    mem_cur = 0;
    
    doc_savepath = "";
    doc_issaved = false;
    //if (instance_exists(d_sy)) {
        //uid = generate_uid(d_sy.map);
    //} else if (instance_exists(sy)) {
        //
    //}
    
	static remove = function() {
        toggle(false);
        var _host = rpk_get_node(path, 1);
        search_and_remove(_host,self);
        return true;
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
                
            imgui_sameline(); imgui_image(d_spu_node,4,#D0D0D0,,32/global.dpi_scale,32/global.dpi_scale);
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
    
    static populate_nodeprop = function() {
        imgui_text("GUH");
    }
	
	static set_name = function(_name) {
        try {
            var _host = rpk_get_node(path, 1);
            var _discrim = 0;
            if (is_struct(_host)) {
                if (_host[$ "content"] != undefined) {
                    if (is_array(_host[$ "content"])) {
                        for (var i = 0; i < array_length(_host.content); i++) {
                            if (_name == _host.content[i].name) {
                                print($"RPK Node \"{_name}\" already exists! This should NOT happen in production!");
                                _name = _name + string(++_discrim);
                                i = 0;
                            }
                        }
                        name = _name;
                        path[array_length(path) - 1] = name;
                    }
                }
            } else if (is_array(_host)) {
                for (var i = 0; i < array_length(_host); i++) {
                    if (_name == _host[i].name) {
                        print($"RPK Node \"{_name}\" already exists! This should NOT happen in production!");
                        _name = _name + string(++_discrim);
                        i = 0;
                    }
                }
                name = _name;
                path[array_length(path) - 1] = name;
            }
        } catch (_err) {
            print(_err);
        }
	}
    
    static export = function(_filenametypename = "Node", _compress = true) {
        try {
            var _name = name;
            var _file = get_save_filename($"{_filenametypename}|{type}", $"{name}");
            if _file != "" {
                rpk_rename_node(self, "%ROOT%");
                var _buff = buffer_create(0,buffer_grow,1);
                ElephantWrite(self,_buff);
        
                if (_compress) {
                    var _cbuff = buffer_compress(_buff,0,buffer_get_size(_buff));
                    buffer_save(_cbuff,_file);
                    show_debug_message("Saved file successfully!");
                    buffer_delete(_buff);
                    buffer_delete(_cbuff);
                } else {
                    buffer_save(_buff,_file);
                    show_debug_message("Saved file successfully!");
                    buffer_delete(_buff);
                }
                rpk_rename_node(self, _name);
                return true;
            } else {
                return false;
            }
        } catch (_err) {
            print(_err);
            return false;
        }
    }
    
    static swap = function(_payload) {
        var _host = rpk_get_node(path,1);
        if (_host != undefined) {
            if (_host[$ "content"] != undefined) {
                var _fromi = 0;
                for (var i = 0; i < array_length(_host.content); i++) {
                    var _inst = _host.content[i];
                    if (_inst = _payload) {
                        array_delete(_host.content,i,1);
                        _fromi = i;
                        break;
                    }
                }
                for (var i = 0; i < array_length(_host.content); i++) {
                    var _inst = _host.content[i];
                    if (_inst = self) {
                        if (i < _fromi) array_insert(_host.content, i, _payload) else array_insert(_host.content, i+1, _payload)
                        break;
                    }
                }
            }
        }
    }
    
    ELEPHANT_POST_READ_METHOD {
        rpk_link_hosts(self);
    }
}

