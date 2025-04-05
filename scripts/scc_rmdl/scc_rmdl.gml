function mdlnode(_path = "") : node() constructor {
    path = _path;
	type = NODE_MODEL;
	
	mdl_buff = "";
    buff = noone;
	mdl = noone;
    vbm = noone;
    
	
	content = [];
	



	ELEPHANT_SCHEMA {
		v1: {
            ELEPHANT_VERSION_VERBOSE : true,
			name: buffer_string,
			mdl_buff: buffer_string,
            content: buffer_array
		}
	}
    
    static toggle = function(_sel = undefined) {
        if (instance_exists(d_sy)) {
            if _sel == undefined sel = !sel else sel = _sel;
            
            if (instance_exists(d_sy)) {
                if (sel) {
                    if (!array_contains(d_sy.selected,self)) {
                        array_push(d_sy.selected,self);
                        set_context(true);
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
    }
    
    static set_context = function(_sel = true) {
        if (instance_exists(d_sy)) {
            if (_sel) {
                if (d_sy.context != noone) && (d_sy.context != self) {
                    if (is_struct(d_sy.context)) {
                        if (d_sy.context[$ "set_context"] != undefined) {
                            d_sy.context.set_context(false);
                        }
                    }
                }
                d_sy.context = self;
                refresh();
            } else {
                d_sy.context = noone;
                refresh(); 
            }
        }
    }

	static refresh = function() {
        if (instance_exists(d_sy)) {
            if (d_sy.context == self) {
                if (!instance_exists(mdl)) {
                    room_goto(d_scn_mdlviewer);
                } else {
                    mdl.Update();
                }
            } else {
                if (mdl != noone) {
                    instance_destroy(mdl);
                }
                //if (vbm != noone) {
                    //VBM_Model_Clear(vbm);
                    //delete vbm;
                    //vbm = noone;
                //}
                room_goto(d_scn_main);
            }
        }
	}
    
    static add_instance = function() {
        if (vbm != noone) {
            mdl = instance_create_depth(0,0,0,obr_rmdl,{
                buff: vbm,
                xscale: 100,
                yscale: 100,
                zscale: 100,
                host: other,
                self_update: false
            });
            
        }
    }
	
	ELEPHANT_PRE_WRITE_METHOD {
		mdl_buff = buffer_base64_encode(buff,0,buffer_get_size(buff));
	}
    
    ELEPHANT_POST_WRITE_METHOD {
        buff = buffer_base64_decode(mdl_buff);
        refresh();
    }
	
	ELEPHANT_POST_READ_METHOD {
		buff = buffer_base64_decode(mdl_buff);
        vbm = VBM_Model_Create();
        VBM_OpenVBM(buff,vbm,VBM_OPENFLAGS.FROM_BUFFER);
	}

	static prompt = function() {
        var _spr = undefined;
		try {
            var _host = rpk_get_node(path, 1);
			var _file = get_open_filename("DMR-VBM Model File (.vbm)|*.vbm", "");
			if (file_exists(_file)) {
				buff = buffer_load(_file);
                rpk_rename_node(self, filename_remove_extension(_file));
				
				//Open file to serialize data from VBM into nodes
				vbm = VBM_Model_Create();
                VBM_OpenVBM(buff,vbm,VBM_OPENFLAGS.FROM_BUFFER);

				
                //print(json_stringify(vbm));
                var _foundmatindexes = [];
                var _foundmat = [];
				for (var i = 0; i < vbm.mesh_count; i++) {
					var _mesh = vbm.meshes[i];
					var _meshnode = rpk_add_node(self,meshnode,_mesh.name);
                    if (!array_contains(_foundmatindexes, _mesh.material_index)) {
                        var _matnode = rpk_add_node(self,matnode,$"Material_{_mesh.material_index}");
                        array_push(_foundmatindexes, _mesh.material_index)
                        _meshnode.ref_material = _matnode.path;
                        _foundmat[_mesh.material_index] = _matnode.path;
                    } else {
                        _meshnode.ref_material = _foundmat[_mesh.material_index];
                    }
                    
                    var _matnode = rpk_get_node(_meshnode.ref_material);
					if (_mesh.texture_sprite != -1) && (_mesh.texture_sprite != noone) && (rpk_get_node_type(_matnode) == NODE_MATERIAL) {
                        _matnode.ref_texture0 = _host.path + "/" + filename_remove_extension(_mesh.texture_sprite) + NODE_TEXTURE;
					}
                    //_meshnode.name = _mesh.name;
				}
                var _dir = "";
                    var _dir_split = string_split_ext(_file,["/","\\"]);
                    for (var i = 0; i < array_length(_dir_split) - 1; i++) {
                        _dir += _dir_split[i] + "/";
                    }
                    _dir += "textures/";
                    if (directory_exists(_dir)) {
                        for (var i = 0; i < array_length(vbm.texture_sprites); i++) {
                            if (file_exists(_dir + vbm.texture_sprites[i])) {
                                _spr = sprite_add(_dir + vbm.texture_sprites[i],0,0,0,0,0);
                                var _rtex = rpk_add_node(_host, texnode, filename_remove_extension(vbm.texture_sprites[i]));
                                _rtex.set_texture(_spr);
                                rpk_rename_node(_rtex, filename_remove_extension(vbm.texture_sprites[i]));
                            }
                        }
                        
                }
				
				//VBM_Model_Clear(vbm);
			}
		} catch (_err) {
			buff = noone;
            if (sprite_exists(_spr)) {
                sprite_delete(_spr);
            }
			print(_err);
		}
	}
    
    static populate_nodetree = function(_index = 0) {
        if (instance_exists(d_sy)) {
            var _treenode_flags_sel = 
            ImGuiTreeNodeFlags.OpenOnArrow|
            ImGuiTreeNodeFlags.SpanAvailWidth|
            ImGuiTreeNodeFlags.FramePadding;
            if (sel) _treenode_flags_sel |= ImGuiTreeNodeFlags.Selected;
            
            var _node = imgui_tree_node_ex($"###nodelist_rpk_{path}",_treenode_flags_sel);
            if (imgui_is_item_clicked() && !imgui_is_item_toggled_open()) {
                d_sy.__selection_handler(self);
            }
                
            if (imgui_begin_popup_context_item($"nodelist_rpk_{_index}_context")) {

                imgui_end_popup();
            }
                
            imgui_sameline(); imgui_image(d_spu_node,2,#64E4FE,,32/global.dpi_scale,32/global.dpi_scale);
            imgui_sameline(); imgui_text($"{path} ({_index})");
                
            if (_node) {
                for (var i = 0; i < array_length(content); i++) {
                    content[i].populate_nodetree(++_index);
                }
                //populate_rpk_nodetree(_content.content);
                imgui_tree_pop();
            }
        }
    }
	
    
	
	
	//static set_texture = function(_texnode) {
        //if (_texnode != undefined) {
    		//ref_texture = _texnode.path;
    		//if (instance_exists(mdl)) {
    			//mdl.texture = _texnode.spr_texture;	
                //mdl.Update();
    		//}
        //}
	//}
	
	static remove = function() {
        set_context(false);
		if (instance_exists(mdl)) instance_destroy(mdl);
        if (vbm != noone) VBM_Model_Clear(vbm);            
		if (buffer_exists(buff)) buffer_delete(buff);
		toggle(false);
        
        var _host = rpk_get_node(path, 1);
        search_and_remove(_host,self);
        return true;
	}
}

