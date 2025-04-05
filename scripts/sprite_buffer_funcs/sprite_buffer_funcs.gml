function sprite_add_from_base64(_buff) {
    var _tempbuff = buffer_base64_decode(_buff);
    buffer_save(_tempbuff,"_TEMP/img.jpg");
    buffer_delete(_tempbuff);
    if (file_exists("_TEMP/img.jpg")) {
        var _spr = sprite_add("_TEMP/img.jpg",0,0,0,0,0);
        file_delete("_TEMP/img.jpg");
        return _spr;
    } else return undefined;
}


