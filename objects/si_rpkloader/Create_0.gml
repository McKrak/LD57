//rpk_file = noone;
//index = undefined;
//result = undefined;

//function __load_rpk(_rpk,_index) {
//	global.rpk_is_loading = true;
//	rpk_file = _rpk;
//	index = _index;
	
//	var _map = {};
//	var _headerlen = 0;
//	var _comp = 0;
	
//	try {	
//		if (_rpk == "") {
//			_rpk = get_open_filename("RoShamBoom Package|*.rpk", "");
//		}
//		if (_rpk != "") {
//			var _buff = buffer_create(0,buffer_grow,1);
//			global.load_id = buffer_load_async(_buff,_rpk,9,0);
//			if (buffer_read(_buff,buffer_u8) == ord("R"))
//			&& (buffer_read(_buff,buffer_u8) == ord("P"))
//			&& (buffer_read(_buff,buffer_u8) == ord("K")) {
//				if (buffer_read(_buff,buffer_u8) == 0) {
//					_comp = buffer_read(_buff,buffer_u8);
//					_headerlen = buffer_read(_buff,buffer_u32);
					
//					buffer_load_partial(_buff,_rpk,9,_headerlen,0);
//					var _dbuff = buffer_decompress(_buff);
//					buffer_delete(_buff);

//					_map = json_parse(buffer_read(_dbuff,buffer_string));
//					buffer_delete(_dbuff);	
//				} else {
//					print("Invalid RPK version!");
//					return undefined;
//				}
				
//			} else {
//				print ("Not an RPK file!");
//				return undefined;
//			}
//		} else return undefined;
//	} catch (_err) {
//		print(_err);
//		return undefined;
//	}
	
//	_headerlen+=9;
	
//	try {
//			if (is_array(_index)) {
//				var _ret = [];
//				for (var i = 0; i < array_length(_index); i++) {
//					if (struct_exists(_map,_index[i])) {
//						var _entry = struct_get(_map,_index[i]);
//						var _cBuffTemp = buffer_create(0, buffer_grow, 1);
//						buffer_load_partial(_cBuffTemp,_rpk,_entry[1]+_headerlen,_entry[2],0);
//						var _cBuff = buffer_decompress(_cBuffTemp);
//						buffer_delete(_cBuffTemp);
//						_ret[i] = ElephantRead(_cBuff);
//					}
//				}
//				return _ret;
//			} else if (is_string(_index)) {
//				var _ret = undefined;
//				if (struct_exists(_map,_index)) {
//					var _entry = struct_get(_map,_index);
//					var _cBuffTemp = buffer_create(0, buffer_grow, 1);
//					buffer_load_partial(_cBuffTemp,_rpk,_entry[1]+_headerlen,_entry[2],0);
//					var _cBuff = buffer_decompress(_cBuffTemp);
//					buffer_delete(_cBuffTemp);
//					_ret = ElephantRead(_cBuff);
//				}
//				return _ret;
//			} else if (_index = undefined) {
//				var _ret = [];
//				var _names = struct_get_names(_map);
//				for (var i = 0; i < array_length(_names); i++) {
//					if (struct_exists(_map,_names[i])) {
//						var _entry = struct_get(_map,_names[i]);
//						var _cBuffTemp = buffer_create(0, buffer_grow, 1);
//						buffer_load_partial(_cBuffTemp,_rpk,_entry[1]+_headerlen,_entry[2],0);
//						var _cBuff = buffer_decompress(_cBuffTemp);
//						buffer_delete(_cBuffTemp);
//						array_push(_ret,ElephantRead(_cBuff));
//					}
//				}
//				return _ret;
//			} else if (is_numeric(_index)) {
//				var _ret = [];
//				var _names = struct_get_names(_map);
//				for (var i = 0; i < array_length(_names); i++) {
//					if (struct_exists(_map,_names[i])) {
//						var _entry = struct_get(_map,_names[i]);
//						if (_entry[0] == _index) {
//							var _cBuffTemp = buffer_create(0, buffer_grow, 1);
//							buffer_load_partial(_cBuffTemp,_rpk,_entry[1]+_headerlen,_entry[2],0);
//							var _cBuff = buffer_decompress(_cBuffTemp);
//							buffer_delete(_cBuffTemp);
//							array_push(_ret,ElephantRead(_cBuff));
//						}
//					}
//				}
//				return _ret;
//			} else return undefined;
//	} catch (_err) {
//		print(_err);
//		return undefined;
//	}
//}
