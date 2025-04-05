
function sprite_to_base64(_sprite) {
	var _subimages = sprite_get_number(_sprite);
	
	var _srf_image = surface_create(sprite_get_width(_sprite)*_subimages,sprite_get_height(_sprite),surface_rgba8unorm);
	
	gpu_set_ztestenable(false);
	surface_set_target(_srf_image);
	for (var i = 0; i < _subimages; i++) {
		draw_sprite(_sprite,i,sprite_get_width(_sprite)*i,0);
	}
	surface_reset_target();
	gpu_set_ztestenable(true);
	
	
	var _buff64 = buffer_create(0,buffer_grow,1);
	buffer_write(_buff64,buffer_u16,sprite_get_width(_sprite));
	buffer_write(_buff64,buffer_u16,sprite_get_height(_sprite));
	buffer_write(_buff64,buffer_u16,_subimages);
	buffer_get_surface(_buff64,_srf_image,buffer_tell(_buff64));
	surface_free(_srf_image);
	
	var _b64 = buffer_base64_encode(_buff64,0,buffer_get_size(_buff64));
	buffer_delete(_buff64);
	
	return _b64;
}

function base64_to_sprite(_b64) {
	var _buff64 = buffer_base64_decode(_b64);
	
	var _width = buffer_read(_buff64,buffer_u16);
	var _height = buffer_read(_buff64,buffer_u16);
	var _subimages = buffer_read(_buff64,buffer_u16);
	gpu_set_ztestenable(false);
	
	var _srf_image = surface_create(_width*_subimages,_height,surface_rgba8unorm);
	buffer_set_surface(_buff64,_srf_image,buffer_tell(_buff64));
	
	buffer_delete(_buff64);
	
	var _sprite = sprite_create_from_surface(_srf_image,0,0,_width,_height,false,false,0,0);
	for (var i = 1; i < _subimages; i++) {
		sprite_add_from_surface(_sprite,_srf_image,(_width)*i,0,_width,_height,false,false);
	}
	
	surface_free(_srf_image);
	gpu_set_ztestenable(true);
	
	return _sprite;
}

function load_rsbc(_id,_lite = false,_path_override = "") {
	//var _file = "";
	//
	//if (_path_override != "") {
		//_file = _path_override;
	//} else {
		//_file = $"Kahuna/CharData/C{_id}.rsbc";
	//}
	//var _return;
	//
	//if (_lite) {
		//_return = {name: "Null", color: #000000, sprite: noone};
	//} else {
		//_return = {name: "Null", color: #000000, sprite: noone};
	//}
	//
	//if _file != "" {
		//try {
			//var _cbuff = buffer_load(_file);
			//var _buff = buffer_decompress(_cbuff);
			//buffer_delete(_cbuff);
					//
			//var _chara_name = buffer_read(_buff,buffer_string);
			//var _r = buffer_read(_buff,buffer_u8);
			//var _g = buffer_read(_buff,buffer_u8);
			//var _b = buffer_read(_buff,buffer_u8);
			//var _chara_color = make_color_rgb(_r,_g,_b);
					//
			//var _sprite;
			//for (var i = 0; i < 2; i++) {
				//var _b64 = buffer_read(_buff,buffer_string);
				//if (_b64 == "") {
					//_sprite[i] = noone;
				//} else {
					//_sprite[i] = base64_to_sprite(_b64);
				//}
				//
				//if (i == 0) && (_lite) {
					//break;
				//}
			//}
				//
			//buffer_delete(_buff);
				//
			//_return.name = _chara_name;
			//_return.color = _chara_color;
			//_return.sprite = _sprite;
			//
		//} catch (_) {
			//show_debug_message("ERROR: The RSBC file is corrputed.");
		//}
	//} else {
		//show_debug_message("ERROR: The RSBC file doesn't exist.");
	//}
	//
	//return _return;
}

function get_char_atlas() {
	//if (sy.char_atlas != noone) {
		//clear_char_atlas();
	//}
	//
	//var _atlas = [];
//
	//try {
		//for (var i = 1; i <= 10; i++) {
			//var _file = load_rsbc(i,true);
//
			//var _iw = 32*8;
			//var _ih = 32*8;
			//var _border = 4;
			//var _rad = 4.5*8;
			//var _col = _file.color;
			//var _srf = surface_create(_iw,_ih);
//
			//surface_set_target(_srf);
			//gpu_set_tex_filter(true);
			//draw_sprite_ext(spu_ch_icon,1,_iw/2,_ih/2,1,1,0,_col,1);
			//gpu_set_colorwriteenable(1,1,1,0);
			//draw_sprite_stretched(_file.sprite[0],0,_iw/3.5,0,_iw,_ih);
			//gpu_set_colorwriteenable(1,1,1,1);
			//gpu_set_tex_filter(TEX_FILTER);
			//surface_reset_target();
//
			//_file.sprite[0] = sprite_create_from_surface(_srf,0,0,_iw,_ih,false,false,_iw/2,_ih/2);
			//surface_free(_srf);
					//
			//array_push(_atlas, _file);
		//}
	//} catch (_) {
		//print("System Character Data seems to be Tampered With...");
	//}
//
	//sy.char_atlas = _atlas;
}

function get_c_char_atlas() {
	//if (sy.c_char_atlas != noone) {
		//clear_c_char_atlas();
	//}
	//
	//var _atlas = [];
	//if (directory_exists(working_directory+"/UserData/Characters")) {
			//var file_name = file_find_first(working_directory+"UserData/Characters/*.rsbc", fa_none);
			//while (file_name != "") {
				//try {
					//var _file = load_rsbc(0,true,working_directory+$"UserData/Characters/{file_name}");
//
					//var _iw = 32*8;
					//var _ih = 32*8;
					//var _border = 4;
					//var _rad = 4.5*8;
					//var _col = _file.color;
					//var _srf = surface_create(_iw,_ih);
//
					//surface_set_target(_srf);
					//gpu_set_tex_filter(true);
					//draw_sprite_ext(spu_ch_icon,1,_iw/2,_ih/2,1,1,0,_col,1);
					//gpu_set_colorwriteenable(1,1,1,0);
					//draw_sprite_stretched(_file.sprite[0],0,_iw/3.5,0,_iw,_ih);
					//gpu_set_colorwriteenable(1,1,1,1);
					//gpu_set_tex_filter(TEX_FILTER);
					//surface_reset_target();
//
					//_file.sprite[0] = sprite_create_from_surface(_srf,0,0,_iw,_ih,false,false,_iw/2,_ih/2);
					//surface_free(_srf);
					//
					//
					//array_push(_atlas, _file);
				//} catch (_) {
					//print($"Error loading {file_name}.");
				//}
//
				//file_name = file_find_next();
			//}
			//file_find_close();
		//}
	//sy.c_char_atlas = _atlas;
}

function clear_char_atlas() {
	//for (var i = 0; i < array_length(sy.char_atlas); i++) {
		//clear_rsbc(sy.char_atlas[i]);
	//}
}

function clear_c_char_atlas() {
	//for (var i = 0; i < array_length(sy.c_char_atlas); i++) {
		//clear_rsbc(sy.c_char_atlas[i]);
	//}
}

function clear_rsbc(_rsbc) {
	//for (var i = 0; i < array_length(_rsbc.sprite); i++) {
		//if (sprite_exists(_rsbc.sprite[i])) {
			//sprite_delete(_rsbc.sprite[i]);
		//}
	//}
}

function set_rsbc(_pid,_cid) {
	//if (is_struct(sy.p[_pid].char)) {
		//clear_rsbc(sy.p[_pid].char);
	//}
	//
	//sy.p[_pid].char = load_rsbc(_cid);
}

function set_c_rsbc(_pid,_fname) {
	//if (is_struct(sy.p[_pid].char)) {
		//clear_rsbc(sy.p[_pid].char);
	//}
	//
	//sy.p[_pid].char = load_rsbc(0,false,$"UserData/Characters/{_fname}");
}

function load_sprite(_spath,_frames = 1) {
	try {
		var _sprite = noone;
		if (string_ends_with(_spath,".gif")) {
			_sprite = sprite_add(_spath,_frames,0,0,0,0);
		} else {
			_sprite = sprite_add(_spath,_frames,0,0,0,0);
		}
		return _sprite;
	} catch (_) {
		show_debug_message("Corrupt Image, Not Loading");
		return noone;
	}
}