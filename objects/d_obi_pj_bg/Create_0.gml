sprite = noone;
function refresh(_b64) {
	var _tempbuff = buffer_base64_decode(_b64);
	buffer_save(_tempbuff,"_TEMP/img.jpg");
	if (file_exists("_TEMP/img.jpg")) {
		sprite = sprite_add("_TEMP/img.jpg",0,0,0,0,0);
		file_delete("_TEMP/img.jpg");
		layer_background_sprite(layer_background_get_id("Background"),_board.bg_day);
	}
}

