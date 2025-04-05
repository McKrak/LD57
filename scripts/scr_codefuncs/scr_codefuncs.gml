// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function approach(val1, val2, amount) {
    if (val1 < val2) {
        return min(val1 + amount, val2);
    } else {
        return max(val1 - amount, val2);
    }
}

////Credit: Foxyofjungle
///// @desc Draws a sprite with nineslice turned on, but with custom size and the pivot point is considered.
///// @param {asset.GMSprite} sprite The sprite to draw.
///// @param {real} subimg The sprite frame.
///// @param {real} x The x position to draw.
///// @param {real} y The y position to draw.
///// @param {real} width The width. The nine slice will be stretched to this exact amount.
///// @param {real} height The height. The nine slice will be stretched to this exact amount.
///// @param {real} xscale Relative nineslice xscale.
///// @param {real} yscale Relative nineslice yscale.
///// @param {real} rot Sprite angle.
///// @param {real} col Blend color.
///// @param {real} alpha Sprite alpha.
//function draw_nineslice_stretched_ext(sprite, subimg, x, y, width, height, xscale, yscale, rot, col, alpha) {
//	draw_sprite_ext(sprite, subimg, x, y, (width/sprite_get_width(sprite))*xscale, (height/sprite_get_height(sprite))*yscale, rot, col, alpha);
//}

///// @function                   string_wrap(text, width);
///// @param  {string}    text    The text to wrap
///// @param  {real}      width   The maximum width of the text before a line break is inserted
///// @description        Take a string and add line breaks so that it doesn't overflow the maximum width

function string_wrap(_text, _width)
{
var _text_wrapped = "";
var _space = -1;
var _char_pos = 1;
while (string_length(_text) >= _char_pos)
    {
    if (string_width(string_copy(_text, 1, _char_pos)) > _width)
        {
        if (_space != -1)
            {
            _text_wrapped += string_copy(_text, 1, _space) + "\n";
            _text = string_copy(_text, _space + 1, string_length(_text) - (_space));
            _char_pos = 1;
            _space = -1;
            }
        }
    if (string_char_at(_text,_char_pos) == " ")
        {
        _space = _char_pos;
        }
    _char_pos += 1;
    }
if (string_length(_text) > 0)
    {
    _text_wrapped += _text;
    }
return _text_wrapped;
}

/// @description draw_text_outline(x,y,str,outwidth,outcol,outfidelity)
/// @param x
/// @param y
/// @param character_array
/// @param xscale
/// @param yscale
/// @param angle
/// @param col1
/// @param col2
/// @param col3
/// @param col4
/// @param alp
/// @param outwidth
/// @param random_y
/// @param random_height
/// @param spacing
function draw_text_outline_roshobo(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12, argument13, argument14) {
	var _x = argument0 - array_length(argument2)*argument14/2;
	var _y = argument1;
	var _width = argument11*2;
	var _r_y = argument12;
	var _r_height = argument13;
	var _outcol = c_rsblack;
	for (var i = 0; i < array_length(argument2); i++) {
		scribble(argument2[i]).transform(argument3,argument4).blend(argument6,argument10).msdf_border(_outcol,argument10).draw(_x,_y);
	}
	_width -= argument11;
	_outcol = c_white;
	for (var i = 0; i < array_length(argument2); i++) {
		scribble(argument2[i]).transform(argument3,argument4).blend(argument6,argument10).msdf_border(_outcol,argument10).draw(_x,_y);
	}
	//draw_text_transformed_color(_x,argument1+_width*2,string_hash_to_newline(argument2),argument3, argument4*_r_height[i], argument5, _outcol, _outcol, _outcol, _outcol, argument10);
	//draw_text_transformed_color(_x+_width,argument1+_width*2,string_hash_to_newline(argument2),argument3, argument4*_r_height[i], argument5, _outcol, _outcol, _outcol, _outcol, argument10);
	//draw_text_transformed_color(_x-_width,argument1+_width*2,string_hash_to_newline(argument2),argument3, argument4*_r_height[i], argument5, _outcol, _outcol, _outcol, _outcol, argument10);
	
	for (var i = 0; i < array_length(argument2); i++) {
		draw_text_transformed_color(_x+argument14*i,_y+_r_y[i],string_hash_to_newline(argument2[i]),argument3, argument4*_r_height[i], argument5, argument6, argument7, argument8, argument9, argument10);
	}
}

//////Special thanks to interplanetary_doggy on reddit for this one!
//////https://www.reddit.com/r/gamemaker/comments/pu82qk/comment/k2cq12t/?utm_source=share&utm_medium=web2x&context=3
function draw_nineslice_stretched(_sprite, _subimg, _x, _y, _scale, _width, _height, _col, _alpha){
    //get the 9slice struct
    var _9slice = sprite_get_nineslice(_sprite);
    _9slice.enabled = false;
    //establish margins
    var _sprite_width = sprite_get_width(_sprite);
    var _sprite_height = sprite_get_height(_sprite);
    //for sprite margins
    var _left = _9slice.left;
    var _right = _sprite_width - _9slice.right;
    var _top = _9slice.top;
    var _bottom = _sprite_height - _9slice.bottom;
    //9slice margins relative to sprite
    var _XX_sprite = [0, _left, _right, _sprite_width];
    var _YY_sprite = [0, _top, _bottom, _sprite_height];
    //for acatual margins
    _left = _9slice.left*_scale;
    _right = _width - _9slice.right*_scale;
    _top = _9slice.top*_scale;
    _bottom = _height - _9slice.bottom*_scale;
    //9slice margin positions for actual drawing (relative to _x and _y)
    var _XX_actual = [0, _left, _right, _width];
    var _YY_actual = [0, _top, _bottom, _height];
    for (var _j = 0; _j < 3; ++_j){ //y direction
    	var _part_top_pos = _YY_sprite[_j];
    	var _part_height = _YY_sprite[_j+1]-_YY_sprite[_j];
    	var _part_y = _y + _YY_actual[_j];
    	var _part_y_scale = (_YY_actual[_j+1]-_YY_actual[_j])/_part_height;
    	for (var _i = 0; _i < 3; ++_i){ //x direction
    		var _part_left_pos = _XX_sprite[_i];
    		var _part_width = _XX_sprite[_i+1]-_XX_sprite[_i];
    		var _part_x = _x + _XX_actual[_i];
    		var _part_x_scale = (_XX_actual[_i+1]-_XX_actual[_i])/_part_width;
    		draw_sprite_part_ext(_sprite, _subimg, _part_left_pos, _part_top_pos, _part_width, _part_height, _part_x, _part_y, _part_x_scale, _part_y_scale, _col, _alpha);
    	}
    }
}

function print(_str) {
	show_debug_message($"[{current_time}] (): {_str}");
}

//Credit to FrostyCat on GMS Forums
//https://forum.gamemaker.io/index.php?threads/best-way-to-compare-two-structs-to-determine-if-file-has-changed-solved.92238/
function json_are_equal(a, b) {
    var type = typeof(a);
    if (type != typeof(b)) return false;
    switch (type) {
        case "array":
            var n = array_length(a);
            if (n != array_length(b)) return false;
            for (var i = 0; i < n; ++i) {
                if (!json_are_equal(a[i], b[i])) return false;
            }
        break;
        case "struct":
            var ks = variable_struct_get_names(a);
            var n = array_length(ks);
            var ksb = variable_struct_get_names(b);
            if (n != array_length(ksb)) return false;
            for (var i = 0; i < n; ++i) {
                var k = ks[i];
                if (!(variable_struct_exists(b, k) && json_are_equal(a[$ k], b[$ k]))) return false;
            }
        break;
        default:
            if (a != b) return false;
    }
    return true;
}

//function language_set(_str) {
	//var _file = file_read_all_text($"LanguageData/{_str}.loc");
	//var _lang = json_parse(_file);
	//
	//return _lang;
//}
//
//function loc(_section,_key) {
	//try {
		//var _indices = string_split(_key,".",false,1);
		//if (array_length(_indices) == 2) {
			//if (struct_exists(_section,_indices[0])) {
				//return loc(_section[$ _indices[0]],_indices[1]);
			//}
		//} else {
			//if (struct_exists(_section,_indices[0])) {
				//var _string = _section[$ _indices[0]];
				//if (!is_string(_string)) {
					//throw("You should not be able to see this message!");				
				//} else if (_string == undefined) {
                    //return "Missing string!";
                //} else {
					//return _string;
				//}
			//}
		//}
	//} catch (_) {
		//return "Missing string!";
	//}
//
//}


function string_check(_str1, _str2, _sindex = 0, _eindex = string_length(_str1)) {
	var _ret = true;
	var _checkpos = 0;
	for (var i = _sindex; i < _eindex; i++) {
		if (string_char_at(_str1,i)) != (string_char_at(_str2,_checkpos)) {
			_ret = false;
			return _ret;
		} else {
			_checkpos++;
		}
	}
	return _ret;
}

function inst_find(_type, _var, _value) {
	for (var i = 0; i < instance_number(_type); i++) {
		var _inst = instance_find(_type,i);
		if (variable_instance_exists(_inst.host,_var)) {
			var _target = variable_instance_get(_inst.host,_var);
			if (_target == _value) {
				return _inst;
			}
		}
	}
	
	return noone;
}

function struct_set_if_defined(_struct, _var, _val) {
    if (_val != undefined) {
        set_token(_struct,_var, _val);
        //struct_set(_struct, _var, _val);
    }
}

function array_variable_compare(_array,_var) {
	var _allsame = true;
	if (array_length(_array) > 1) {
		for (var i = 1; i < array_length(_array); i++) {
			if (variable_instance_get(_array[i],_var) != variable_instance_get(_array[i-1],_var)) {
				_allsame = false;
				break;
			}
		}
	} else if (array_length(_array) < 1) {
		_allsame = false;
	}
	return _allsame;
}




function get_token(_container, _string) {
    try {
    var _len = string_length(_string);
        var _current = _container;
        var _str = "";
        var _ind = -1;
        for (var i = 1; i <= _len; i++) {
            var _char = string_char_at(_string,i);
            if (is_array(_current)) {
                if (_char == "[") _char = string_char_at(_string, ++i);
                var _intstr = "";
                while (_char != "]") {
                    _intstr += _char;
                    _char = string_char_at(_string,++i);    
                }
                _ind = int64(_intstr);
                _current = _current[_ind];
                _ind = -1;
            } else {
                if (_char == ".") _char = string_char_at(_string, ++i);
                while (_char != "[") && (_char != ".") && (i <= _len) {
                    _str += _char;
                    _char = string_char_at(_string, ++i);   
                }    
                _current = _current[$ _str];
                _str = "";
            }
        }

    
    
        //var _splitpath = string_split_ext(_string,["[", "]", "."],true);
    //
        //for (var i = 0; i < array_length(_splitpath); i++) {
            //try {
                ////if (string_starts_with(_splitpath[i],"$")) {
                    ////var _splitstructname = string_split_ext()
                ////} else {
                    //var _int = int64(_splitpath[i]);
                    //_current = _current[_int];
                ////}
            //} catch (_err) {
                //_current = _current[$ _splitpath[i]];
//
//
            //}
        //}
        return _current;
    } catch (_err) {
        //print(_err);
        print($"Cannot find value {_string} in container.")
        return undefined;
    }
}

function set_token(_container, _string, _replace) {
    try {
    var _len = string_length(_string);
        var _current = _container;
        var _str = "";
        var _ind = -1;
        for (var i = 1; i <= _len; i++) {
            var _char = string_char_at(_string,i);
            if (is_array(_current)) {
                if (_char == "[") _char = string_char_at(_string, ++i);
                var _intstr = "";
                while (_char != "]") {
                    _intstr += _char;
                    _char = string_char_at(_string,++i);    
                }
                _ind = int64(_intstr);
                
                if (i == _len) {
                    array_set(_current, _ind, _replace);
                } else {
                    if (array_length(_current) <= _ind) {
                        array_resize(_current, _ind + 1);
                        var _nextchar = string_char_at(_string, i + 1);
                        if (_nextchar == "[") array_set(_current, _ind, []);
                        else if (_nextchar == ".") array_set(_current, _ind, { });  
                    }
                    _current = _current[_ind];
                }
                
                
                _ind = -1;
            } else {
                if (_char == ".") _char = string_char_at(_string, ++i);
                while (_char != "[") && (_char != ".") && (i <= _len) {
                    _str += _char;
                    _char = string_char_at(_string, ++i);   
                }    
                if (i - 1 == _len) {
                    struct_set(_current, _str, _replace);
                } else {
                    if (!struct_exists(_current, _str)) {
                        var _nextchar = string_char_at(_string, i + 1);
                        if (_char == "[") struct_set(_current, _str, []);
                        else if (_char == ".") struct_set(_current, _str, { });  
                    }
                    
                    _current = _current[$ _str];
                    _str = "";
                }    
            }
        }

    
    
        //var _splitpath = string_split_ext(_string,["[", "]", "."],true);
    //
        //for (var i = 0; i < array_length(_splitpath); i++) {
            //try {
                ////if (string_starts_with(_splitpath[i],"$")) {
                    ////var _splitstructname = string_split_ext()
                ////} else {
                    //var _int = int64(_splitpath[i]);
                    //_current = _current[_int];
                ////}
            //} catch (_err) {
                //_current = _current[$ _splitpath[i]];
//
//
            //}
        //}
        //return _current;
    } catch (_err) {
        print(_err);
        //return undefined;
    }
}

function directory_count(_dir, _mask = "*") {
    if (directory_exists(_dir)) {
        var _ret = 0;
        var _f = file_find_first(_dir + "/" + _mask, fa_none);
        while (file_exists(_dir + "/" + _f)) {
            _ret++;
            _f = file_find_next();
        }
        file_find_close();
        return _ret;
    } else return 0;
}

function window_get_hover() {
    if (window_has_focus()) {
        var _x = window_get_x();
            var _y = window_get_y();
            var _w = _x + window_get_width();
            var _h = _y + window_get_height();
            var _mx = display_mouse_get_x();
            var _my = display_mouse_get_y();
            //print($"x:{_x} y:{_y} w:{_w} h:{_h} mx:{_mx} my:{_my}");
            
            if (_mx > _x && _mx < _w) && (_my > _y && _my < _h) {
                return true;
            } else return false;
    } else return false;
    
}

function format_int(_int, _leading, _trailing) {
    var _str = string_format(_int, _leading, _trailing);
    _str = string_replace_all(_str, " ", "0");
    return _str;
}



