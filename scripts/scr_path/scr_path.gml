function nodepath(_path = "") constructor {
    path = string_split(_path, "/");
    if (array_last(path) == "/") {
        array_push(path, "");
    }
    
    function set(_path) {
        path = string_split(_path, "/");
        if (array_last(path) == "/") {
            array_push(path, "");
        }
    }
    
    function is_subdir_of(_rhs) {
        var _dirlen = array_length(path);
        var _parlen = array_length(_rhs.path);
        if _dirlen < _parlen return false;
        for (var i = 0; i < array_length(_rhs.path); i++) {
            if (path[i] != _rhs.path[i]) return false;
        }
        return true;
    }
    
    function update_pardir(_rhs) {
        for (var i = 0; i < array_length(_rhs.path); i++) {
            path[i] = _rhs.path[i];
        }
    }
    
    function toString() {
        var _ret = "";
        for (var i = 0; i < array_length(path); i++) {
            _ret += path[i];
        }
        return _ret;
    }
    
}