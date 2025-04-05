/// @function file_read_all_text(filename)
/// @description Reads entire content of a given file as a string, or returns undefined if the file doesn't exist.
/// @param {string} filename        The path of the file to read the content of.
function file_read_all_text(_filename) {
    if (!file_exists(_filename)) {
        return undefined;
    }
    //var _file = file_text_open_read(_filename);
    //var _result = file_text_read_string(_file);
    //file_text_close(_file);
    //return _result;
    var _buffer = buffer_load(_filename);
    var _result = undefined;
    try {
        _result = buffer_read(_buffer, buffer_string);
    } catch (_err) {
        print(_err);
    }
    
    
    buffer_delete(_buffer);
    return _result;
}

/// @function file_write_all_text(filename,content)
/// @description Creates or overwrites a given file with the given string content.
/// @param {string} filename        The path of the file to create/overwrite.
/// @param {string} content            The content to create/overwrite the file with.
function file_write_all_text(_filename, _content) {
    var _file = file_text_open_write(_filename);
    file_text_write_string(_file,_content);
    file_text_close(_file);
    //var _buffer = buffer_create(string_length(_content), buffer_grow, 1);
    //buffer_write(_buffer, buffer_string, _content);
    
    //buffer_save(_buffer, _filename);
    //buffer_delete(_buffer);
}


