function rpk(_path = "") : node() constructor {
    path = "%ROOT%";
	name = "%ROOT%";
	version = 0;
	type = NODE_RPK;
	
	
	content = [];
	
	ELEPHANT_SCHEMA {
		v1: {
            ELEPHANT_VERSION_VERBOSE : true,
			content: buffer_array
		}
	}
    
	static save = function(_compress = true) {
    var _name = name;
		try {
            var _file = get_save_filename("RoShamBoom Package|*.rpk", $"{name}");
            if _file != "" {
                rpk_rename_node(self, "%ROOT%");
    			//Part 1: Encoding all assets to readable files
    			//var _data = ElephantDuplicate(self);
    			
    			//Part 2: Create the header, RPK, version, compression
    			var _hBuff = buffer_create(0,buffer_grow,1);
    			buffer_write(_hBuff,buffer_u8,ord("R"));
    			buffer_write(_hBuff,buffer_u8,ord("P"));
    			buffer_write(_hBuff,buffer_u8,ord("K"));
    			buffer_write(_hBuff,buffer_u8,version);
    			buffer_write(_hBuff,buffer_u8,_compress);
    			
    			var _rpkMap = {}
    			
    			var _cBuff = buffer_create(0,buffer_grow,1);
    			var _offset = 0;
    			
    			//Part 3: Compress each RPK node into serializable data
    			for (var i = 0; i < array_length(content); i++) {
    				var _content  = ElephantWrite(content[i]);
    				//var _contentBuff = buffer_create(0,buffer_grow,1);
    				//buffer_write(_contentBuff,buffer_string,_content);
    				
    				var _contentBuffCom = buffer_compress(_content,0,buffer_get_size(_content));
    				buffer_delete(_content);
    				buffer_copy(_contentBuffCom,0,buffer_get_size(_contentBuffCom),_cBuff,_offset);
    				
    				var _csize = buffer_get_size(_contentBuffCom);
    				var _cname = content[i].name;
    				var _ctype = content[i].type;
    				
    				struct_set(_rpkMap,_cname,[_ctype,_offset,_csize]);
    				_offset += _csize;
    				buffer_delete(_contentBuffCom);
    			}
    			
    			var _mBuffTemp = buffer_create(0,buffer_grow,1);
    			buffer_write(_mBuffTemp,buffer_string,json_stringify(_rpkMap));
    			var _mBuff = buffer_compress(_mBuffTemp,0,buffer_get_size(_mBuffTemp));
    			buffer_delete(_mBuffTemp);
    			
    			var _oBuff = buffer_create(0,buffer_grow,1);
    			buffer_copy(_hBuff,0,5,_oBuff,0);
    			buffer_seek(_oBuff,buffer_seek_relative,5);
    			buffer_write(_oBuff,buffer_u32,buffer_get_size(_mBuff));
    			buffer_copy(_mBuff,0,buffer_get_size(_mBuff),_oBuff,buffer_tell(_oBuff));
    			buffer_seek(_oBuff,buffer_seek_relative,buffer_get_size(_mBuff));
    			buffer_copy(_cBuff,0,buffer_get_size(_cBuff),_oBuff,buffer_tell(_oBuff));
    			
    			buffer_delete(_hBuff);
    			buffer_delete(_mBuff);
    			buffer_delete(_cBuff);
    			
    		
                buffer_save(_oBuff,_file);
                print("Saved file successfully!");
                buffer_delete(_oBuff);
                rpk_rename_node(self, _name);
                return true;
			} else {
				return false;
			}
		} catch (_err) {
            //try {
                //rpk_rename_node(self, _name);
            //} catch (_err) {
                //print(_err);
            //}
			print(_err);
			return false;
		}
	}
	
	static save_json = function() {
		try {
			var _buff = buffer_create(0,buffer_grow,1);


			var _json = json_stringify(ElephantToJSON(self));
			buffer_write(_buff,buffer_string,_json);
		
			var _file = get_save_filename("JSON File|*.json", $"{name}.json");
		
			if _file != "" {
				buffer_save(_buff,_file);
				show_debug_message("Saved file successfully!");
				buffer_delete(_buff);
				return true;
			} else {
				buffer_delete(_buff);
				return false;
			}
		} catch (_err) {
			print(_err);
			return false;
		}
	}
	
	static remove = function() { 
        for (var i = array_length(content) - 1; i >= 0; i--) {
            content[i].remove();
        }
        
        var _host = rpk_get_node(path, 1);
        search_and_remove(_host,self);
        return true;
	}
	//static free = function() {
	//	instance_destroy(mesh);
	//}
	//d_sy.terrain_model.Build("Kahuna/ModelData/cube6s.rvx",x*48,y*48,z*48);
	static populate_nodetree = function(_index = 0) {
		if (instance_exists(d_sy)) {
			var _treenode_flags_sel = 
			ImGuiTreeNodeFlags.OpenOnArrow|
			ImGuiTreeNodeFlags.SpanAvailWidth|
			ImGuiTreeNodeFlags.FramePadding;
			if (sel) _treenode_flags_sel |= ImGuiTreeNodeFlags.Selected;
			
			var _node = imgui_tree_node_ex($"{path} ({_index})###nodelist_rpk_{path}",_treenode_flags_sel);
			if (imgui_is_item_clicked() && !imgui_is_item_toggled_open()) {
				d_sy.__selection_handler(self);
			}
				
			if (imgui_begin_popup_context_item($"nodelist_rpk_{_index}_context")) {
				if (imgui_begin_menu($"Add###nodelist_rpk_{_index}_context_add")) {
					if (imgui_menu_item($"Board Node###nodelist_rpk_{_index}_context_add_board")) {
						var _board = new board();
						array_push(_content.content,_board);
						//room_assign(_board.scn,d_scn_bdedit);
						room_goto(d_scn_bdedit);
					}
					if (imgui_menu_item($"Party Project Board###nodelist_rpk_{_index}_context_add_pj_board")) {
						rpk_add_node(self,pjboard);
						room_goto(d_scn_bdedit);
					}
					if (imgui_menu_item($"Texture Node###nodelist_rpk_{_index}_context_add_texture")) {
						var _tex = rpk_add_node(self,texnode);
						//_tex.prompt_image();

					}
					if (imgui_menu_item($"Model Node###nodelist_rpk_{_index}_context_add_model")) {
						var _mdl = rpk_add_node(self,mdlnode);
						//_mdl.prompt();
						//_mdl.refresh();
					}
                    if (imgui_menu_item($"Light Node###nodelist_rpk_{_index}_context_add_light")) {
                        var _light = rpk_add_node(self,lightnode);
                        _light.add_instance();
                    }
					imgui_end_menu();
				}
				if (imgui_begin_menu($"Import###nodelist_rpk_{_index}_context_import")) {
					if (imgui_menu_item($"Texture Node###nodelist_rpk_{_index}_context_import_texture")) {
						var _tex = rpk_add_node(self,texnode);
						_tex.prompt_image();
					}
					if (imgui_menu_item($"Model Node###nodelist_rpk_{_index}_context_import_model")) {
						var _mdl = rpk_add_node(self,mdlnode);
						_mdl.prompt();
						_mdl.refresh();
					}
                    if (imgui_menu_item($"Skeletal Animation Node###nodelist_rpk_{_index}_context_import_skeanim")) {
                        var _ske = rpk_add_node(self,skenode);
                        _ske.prompt();
                    }
                    imgui_end_menu();
				}
				imgui_separator();
				if (imgui_menu_item($"Save As...###nodelist_rpk_{_index}_context_saveas")) {
					save(true);
				}
				if (imgui_menu_item($"Save As... (Don't Compress)###nodelist_rpk_{_index}_context_saveas_nocom")) {
					save_old(false);
				}
				if (imgui_menu_item($"Export to JSON...###nodelist_rpk_{_index}_context_saveas_json")) {
					save_json();
				}
				imgui_end_popup();
			}
				
			imgui_sameline(); imgui_image(d_spu_node,0,,,32,32);
				
			if (_node) {
				for (var i = 0; i < array_length(content); i++) {
					content[i].populate_nodetree(++_index);
				}
				//populate_rpk_nodetree(_content.content);
				imgui_tree_pop();
			}
		}
	}
}

