#macro UNDO_ADD 0
#macro UNDO_DEL 1
#macro UNDO_RENAME 2
#macro UNDO_PROP 3

function find_next_vacant_id(_content,_filter) {
	var _ret = 0;
	
	var _idlist = [];
	for (var i = 0; i < array_length(_content); i++) {
		var _space = _content[i];
		if (_space.type == _filter) {
			array_push(_idlist,_space.index);
		}
	}
	
	array_sort(_idlist,true);
	for (var i = 0; i < array_length(_idlist); i++) {
		if ((floor(_idlist[i]) == _idlist[i]) && (_idlist[i] == _ret)) {
			_ret++;
		} else if ((floor(_idlist[i]) == _idlist[i]) && (_idlist[i] > _ret)) {
			break;
		}
	}
	return _ret;
}

function ppj_find_next_vacant_id(_content) {
    var _ret = 0;
    
    var _idlist = [];
    for (var i = 0; i < array_length(_content); i++) {
        var _space = _content[i];
        if (_space.type == NODE_PJ_SPACE) || (_space.type == NODE_PJ_OBJECT) {
            try {
                var _id = int64(filename_remove_extension(_space.name));
                if (_id != undefined) {
                    array_push(_idlist,_id);
                }
            } catch (_err) {
                print(_err);
            }

            
        }
    }
    
    array_sort(_idlist,true);
    for (var i = 0; i < array_length(_idlist); i++) {
        if ((floor(_idlist[i]) == _idlist[i]) && (_idlist[i] == _ret)) {
            _ret++;
        } else if ((floor(_idlist[i]) == _idlist[i]) && (_idlist[i] > _ret)) {
            break;
        }
    }
    
    _ret = string(_ret);
    return _ret;
}

function prop_add(_value, _prop, _liveupdate = false, _refresh = false) {
    if (is_callable(_prop)) {
        if (array_length(d_sy.selected)) {
            var _commonval = d_sy.selected[0][$ _value];
            var _ismixedval = false;
            for (var i = 1; i < array_length(d_sy.selected); i++) {
                if d_sy.selected[i][$ _value] != _commonval {
                    _ismixedval = true;
                    break;
                }
            }
            if (_ismixedval) imgui_push_style_color(ImGuiCol.FrameBg,#b9a812,1);
            var _output = _prop();
            
            if ((_liveupdate) && (imgui_is_item_edited()))
            || ((!_liveupdate) && (imgui_is_item_deactivated_after_edit())) {
                
                for (var i = 0; i < array_length(d_sy.selected); i++) {
                    d_sy.selected[i][$ _value] = _output;
                    if (_refresh) {
                        var _refreshfunc = d_sy.selected[i][$ "refresh"];
                        if (is_callable(_refreshfunc)) {
                            with (d_sy.selected[i]) {
                                refresh();
                            }
                        }
                    }
                }
            }
            if (_ismixedval) imgui_pop_style_color();
        }
    }
}

function undostack_push(_step) {
    //if (instance_exists(d_sy)) {
        //array_push(d_sy.undo_stack, _step);
    //}
}

//function undostack_record(_step) {
    //if (instance_exists(d_sy)) {
        //game_save_buffer
    //}
//}
