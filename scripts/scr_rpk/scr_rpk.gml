#macro NODE_NONE		".none"
#macro NODE_RPK			".rpk"
#macro NODE_BOARD		".rsbd"
#macro NODE_SPACE		".rspc"
#macro NODE_MODEL		".rmdl"
#macro NODE_TEXTURE		".rtex"
#macro NODE_LIGHT		".rlin"
#macro NODE_CHARA		".rchr"
#macro NODE_ANIM		".rske"
#macro NODE_BOARDMAP	".rmap"
#macro NODE_SCENE		".rscn"
#macro NODE_MESH		".robj"
#macro NODE_MATERIAL    ".rmat"

function rpk_load_json(_parent, _file = "") {
	try {
        if (_file == "") {
            _file = get_open_filename("Any File|*", "");
        }
        if (file_exists(_file)) {
            //var _buff = buffer_load(_file);
            //var _node = ElephantRead(_buff);
            //buffer_delete(_buff);
            var _text = file_read_all_text(_file);
            var _json = json_parse(_text);
            var _node = ElephantFromJSON(_json);
            _text = "";
            _json = {};
            gc_collect();
            
            //Check if Node is Valid
            if (_node[$ "type"] != undefined) && (_node[$ "name"] != undefined) {
                if (is_array(_parent)) {
                    array_push(_parent, _node);
                } else if (is_struct(_parent)) {
                    array_push(_parent.content, _node);
                }
                _node.host = _parent;
                rpk_rename_node(_node, filename_remove_extension(_file));
                rpk_set_paths(_node);
                
                return _node;
            } else {
                return undefined;
            }
            
            
            //var _buff;
            //if (_decompress) {
                //var _cbuff = buffer_load(_file);
                //_buff = buffer_decompress(_cbuff);
                //buffer_delete(_cbuff);
            //} else {
                //_buff = buffer_load(_file);
            //}
            //
            //var _data = ElephantRead(_buff);
            //buffer_delete(_buff);
            

        } else return undefined;

		
	} catch (_err) {
		print(_err);
		return undefined;
	}
}

function rpk_load_node(_decompress = true) {
    try {
        var _file = get_open_filename("Any File|*", "");
        
        if (file_exists(_file)) {
            var _buff;
            if (_decompress) {
                var _cbuff = buffer_load(_file);
                _buff = buffer_decompress(_cbuff);
                buffer_delete(_cbuff);
            } else {
                _buff = buffer_load(_file);
            }
            
            var _data = ElephantRead(_buff);
            buffer_delete(_buff);
            
            rpk_rename_node(_data, filename_remove_extension(_file));
            rpk_set_paths(_data);
            
            print("Loaded board successfully!");
            return _data;
        } else return undefined;
    } catch (_err) {
        print(_err);
        return undefined;
    }
}

function rpk_load(_inrpk = "",_index = undefined) {
	var _map = {};
	var _headerlen = 0;
	var _comp = 0;
	
	try {	
		if (_inrpk == "") {
			_inrpk = get_open_filename("RoShamBoom Package|*.rpk", "");
		}
		if (file_exists(_inrpk)) {
			var _buff = buffer_create(0,buffer_grow,1);
			buffer_load_partial(_buff,_inrpk,0,9,0);
			if (buffer_read(_buff,buffer_u8) == ord("R"))
			&& (buffer_read(_buff,buffer_u8) == ord("P"))
			&& (buffer_read(_buff,buffer_u8) == ord("K")) {
				if (buffer_read(_buff,buffer_u8) == 0) {
					_comp = buffer_read(_buff,buffer_u8);
					_headerlen = buffer_read(_buff,buffer_u32);
					
					buffer_load_partial(_buff,_inrpk,9,_headerlen,0);
					var _dbuff = buffer_decompress(_buff);
					buffer_delete(_buff);

					_map = json_parse(buffer_read(_dbuff,buffer_string));
					buffer_delete(_dbuff);	
				} else {
					print("Invalid RPK version!");
					return undefined;
				}
				
			} else {
				print ("Not an RPK file!");
				return undefined;
			}
		} else return undefined;
	} catch (_err) {
		print(_err);
		return undefined;
	}
	
	_headerlen+=9;
	
	try {
		var _load = [];
			if (is_array(_index)) {
				for (var i = 0; i < array_length(_index); i++) {
					if (struct_exists(_map,_index[i])) {
						var _entry = struct_get(_map,_index[i]);
						var _cBuffTemp = buffer_create(0, buffer_grow, 1);
						buffer_load_partial(_cBuffTemp,_inrpk,_entry[1]+_headerlen,_entry[2],0);
						var _cBuff = buffer_decompress(_cBuffTemp);
						buffer_delete(_cBuffTemp);
						_load[i] = ElephantRead(_cBuff);
                        buffer_delete(_cBuff);
					}
				}
			} else if (is_string(_index)) {
				if (struct_exists(_map,_index)) {
					var _entry = struct_get(_map,_index);
					var _cBuffTemp = buffer_create(0, buffer_grow, 1);
					buffer_load_partial(_cBuffTemp,_inrpk,_entry[1]+_headerlen,_entry[2],0);
					var _cBuff = buffer_decompress(_cBuffTemp);
					buffer_delete(_cBuffTemp);
					_load[0] = ElephantRead(_cBuff);
                    buffer_delete(_cBuff);
					//rpk_link_hosts(_load[0]);
				} else return undefined
			} else if (_index = undefined) {
				var _names = struct_get_names(_map);
				for (var i = 0; i < array_length(_names); i++) {
					if (struct_exists(_map,_names[i])) {
						var _entry = struct_get(_map,_names[i]);
						var _cBuffTemp = buffer_create(0, buffer_grow, 1);
						buffer_load_partial(_cBuffTemp,_inrpk,_entry[1]+_headerlen,_entry[2],0);
						var _cBuff = buffer_decompress(_cBuffTemp);
						buffer_delete(_cBuffTemp);
						_load[i] = ElephantRead(_cBuff);
                        buffer_delete(_cBuff);
						//rpk_link_hosts(_load[i]);
					}
				}
			} else if (is_numeric(_index)) {
				var _names = struct_get_names(_map);
				for (var i = 0; i < array_length(_names); i++) {
					if (struct_exists(_map,_names[i])) {
						var _entry = struct_get(_map,_names[i]);
						if (_entry[0] == _index) {
							var _cBuffTemp = buffer_create(0, buffer_grow, 1);
							buffer_load_partial(_cBuffTemp,_inrpk,_entry[1]+_headerlen,_entry[2],0);
							var _cBuff = buffer_decompress(_cBuffTemp);
							buffer_delete(_cBuffTemp);
							_load[i] = ElephantRead(_cBuff);
                            buffer_delete(_cBuff);
							//rpk_link_hosts(_load[i]);
						}
					}
				}
			} else return undefined;
			
			var _rpk = new rpk();
            _rpk.content = _load;
            rpk_set_paths(_rpk);
            rpk_rename_node(_rpk, filename_remove_extension(_inrpk));
			
			
			return _rpk;
	} catch (_err) {
		print(_err);
		return undefined;
	}
}

function search_and_remove(_content,_target) {
	if (is_array(_content)) {
		for (var i = 0; i < array_length(_content); i++) {
			if (_content[i] == _target) {
				array_delete(_content,i,1);
                delete _target;
				return true;
			}
			if search_and_remove(_content[i],_target) return true;
		}
	} else if (is_struct(_content)) {
		var _sd_names = variable_instance_get_names(_content);
		for (var i = 0; i <  array_length(_sd_names); i++) {
			var _name = _sd_names[i];
            if (_name != "host") {
                var _val = variable_instance_get(_content,_name);
                search_and_remove(_val,_target);
            }
		}
	}
}

function rpk_remove_node(_content,_target) {

	if (is_struct(_content)) {
		var _names = struct_get_names(_content);
		for (var i = 0; i < array_length(_names); i++) {
			if (_content[$ _names[i]] == _target) {
				struct_remove(_content, _names[i]);
			}
		}
	} else if (is_array(_content)) {
		for (var i = 0; i < array_length(_content); i++) {
			if (_content[i] == _target) {
				array_delete(_content,i,1);
				break;
			}
		}
	}

	
	if (is_array(_content)) {
		for (var i = 0; i < array_length(_content); i++) {
			if (_content[i] == _target) {
				array_delete(_content,i,1);
				i--;
			} else {
				if (is_struct(_content[i])) {
					if (_content[i].type == NODE_PJ_SPACE) {
						for (var k = 0; k < array_length(_content[i].path); k++) {
							if _content[i].path[k] == _target {
								_content[i].path[k] = -1;
							}
						}
					}
				}
			}
		}
	}
	delete _target;
}

function rpk_link_hosts(_struct_or_array, _previous = noone) {
	if (is_struct(_struct_or_array)) {
		var _names = struct_get_names(_struct_or_array);
		
		for (var i = 0; i < array_length(_names); i++) {
			var _item = _struct_or_array[$ _names[i]];
			if (_names[i] == "host") {
				if (_item == noone) {
					_struct_or_array[$ _names[i]] = _previous;
				}
			} else if (is_array(_item)) && (_names[i] == "content") {
				for (var j = 0; j < array_length(_item); j++) {
					rpk_link_hosts(_struct_or_array[$ _names[i]][@ j],_struct_or_array);
				}
			}
		}
	}
}

function rpk_set_paths(_inrpk, _path = "") {
    try {
        _path += _inrpk.name;
        _inrpk.path = _path;
        if (_inrpk[$ "content"] != undefined) {
            for (var i = 0; i < array_length(_inrpk.content); i++) {
                rpk_set_paths(_inrpk.content[i], _path + "/");
            }
        }
    } catch (_err) {
        print(_err);
    }
}

function load_image(_file = "") {
	try {
        if (_file == "") _file = get_open_filename("Image Files (.png, .jpg, .jpeg, .gif)|*.png;*.jpeg;*.jpg;*.gif", "");
		if (file_exists(_file)) {
			var _sprite = sprite_add(_file,1,0,0,0,0)
			var _fname = filename_name(_file);
			return [_sprite,_fname];
		} else return [noone];
	} catch (_err) {
		print(_err);
		return [noone];
	}
}

function rpk_add_node(_parent, _type, _name = "Unnamed") {
    var _ret = undefined;
    if (is_struct(_parent)) {
        _ret = new _type();
        _name = _name + _ret.type;
        //_ret.name = _name;
        //_ret.path = _parent.path + "/" + _name;
        array_push(_parent.content,_ret);
        _ret.path = _parent.path + "/" + _ret.name;
        //_ret.name = _name;
        var _newname = rpk_rename_node(_ret,_name);
        _ret.path = _parent.path + "/" + _newname;
        return _ret;
    }  else if (is_array(_parent)) {
        _ret = new _type(); 
        _name = _name + _ret.type;
        //_ret.name = _name;
        //_ret.path = _name;
        array_push(_parent, _ret);
        _ret.path = _ret.name;
        var _newname = rpk_rename_node(_ret,_name);
        _ret.path = _newname;
        return _ret;
    }
    return _ret;
}

function rpk_push_node(_parent, _node) {
    if (is_struct(_parent)) {
        array_push(_parent.content,_node);
    }  else if (is_array(_parent)) {
        array_push(_parent, _node);
    }
    rpk_rename_node(_node,_node.name);
}

function rpk_get_node(_path, _back = 0) {
    try {
        var _patharray = string_split(_path,"/");
        var _src = global.mem[global.cur_mem];
            
        if (array_length(_patharray) - _back > -1) {
            
            for (var i = 0; i < array_length(_patharray) - _back; i++) {
                if (is_struct(_src)) _src = _src.content;
                _src = rpk_content_search(_src, _patharray[i]);
            }
            return _src;
        }
        return undefined;
    } catch (_err) {
        print(_err);
        return undefined;
    }
}

function rpk_rename_node(_node, _newname, _ext = true) {
    try {
        
            if (_newname != "%ROOT%") {
                if (!string_ends_with(_newname,_node.type)) && (_ext) _newname += _node.type;
                if (_node.name != _newname) {    
                    var _discrim = 0;
                    var _content = rpk_get_node(_node.path, 1);
                    if (_content != undefined) {
                        if (is_struct(_content)) {
                            _content = _content.content;
                        }
                        for (var i = 0; i < array_length(_content); i++) { 
                            if (_content[i].name == _newname) && (_content[i] != _node) {
                                //var _split = string_split(_newname, ".");
                                //array_delete(_split,array_length(_split) - 1,1);
                                //if (array_last(_split) =)
                                if (_ext) {
                                    var _newnamenoext = string_split(_newname, ".")[0];
                                    _newname = _newnamenoext + "." + string(_discrim++) + _node.type;
                                } else {
                                    _newname = _newname + "." + string(_discrim++);
                                }
                                i = -1;
                            }
                        }
                    } else {
                        print("Idk what now");
                    }
                } else return _node.name;
            }
            
            var _patharray = string_split(_node.path, "/", false); 
            var _scope = rpk_get_node(_patharray[0]);
            var _newpath = "";
            if (_scope == undefined) {
                _scope = _node;
                _newpath = _newname; 
            } else {
                _patharray[array_length(_patharray) - 1] = _newname;
                for (var i = 0; i < array_length(_patharray); i++) {
                    if (i != 0) _newpath += "/";
                    _newpath += _patharray[i];
                }
            }
            __rpk_rename_node_inner(_scope, _node.path, _newpath);
            
            _node.path = _newpath;
            _node.name = _newname;

    } catch (_err) {
        print(_err);
    }
    return _newname;
}
            //
//
function __rpk_rename_node_inner(_scope, _path, _newpath) {
    var _names = struct_get_names(_scope);
    for (var i = 0; i < array_length(_names); i++) {
        var _name = _names[i];
        if (string_starts_with(_name, "ref") || _name == "path") {
            var _repl = string_split(_scope[$ _name], "/");
            var _src = string_split(_path, "/");
            var _repl_len = array_length(_repl);
            var _src_len = array_length(_src);
            var _issame = true;
            
            if (_repl_len < _src_len) {
                _issame = false;
            } else {
                for (var j = 0; j < _src_len; j++) {
                    if _repl[j] != _src[j] {
                        _issame = false;
                        break;
                    }
                }
            }
            if (_issame) {
                _scope[$ _name] = string_replace(_scope[$ _name], _path, _newpath);
            }

            //if string_starts_with(_scope[$ _name], _path) 
                //&& (string_char_at(_scope[$ _name], string_length(_path)) == "/"
                //|| string_char_at(_scope[$ _name], string_length(_path)) == "") {
                //_scope[$ _name] = string_replace(_scope[$ _name], _path, _newpath);
            //}
        } 
    }
    //struct_foreach(_scope,function(_name, _val, _path, _newpath) {
        //if (string_starts_with(_name,"ref") || _name == "path") {
            //if (_val == _path) {
                //_val = string_replace(_val, _path, _newpath);
            //}
        //}    
    //});
    if (_scope[$ "content"] != undefined) {
        for (var i = 0; i < array_length(_scope.content); i++) {
            __rpk_rename_node_inner(_scope.content[i], _path, _newpath);    
        }
    }    
}
//
//function rpk_(_

function rpk_content_search(_content, _target, _from = "name") {
	for (var i = 0; i < array_length(_content); i++) {
		if (_content[i][$ _from] == _target) {
			return _content[i];
		}
	}
	return undefined;
}

function filename_remove_extension(_path) {
    var _split = string_split(filename_name(_path), ".");
    while (array_length(_split) > 2) {
        _split[0] += _split[1];
        array_delete(_split,1,1);
    }
    return _split[0];
}
function generate_uid(_map) {
    var _uid = -1;
    do {
        _uid = irandom_range(0, 4294967295);
    } until (_map[$ string(_uid)] == undefined) //There's literally a 1 in 4 billion chance this happens but we account for it regardless :3
    _map[$ string(_uid)] = self;
    return _uid;
}

function rpk_get_node_type(_node) {
    if (is_struct(_node)) {
        return _node[$ "type"];
    }
}

