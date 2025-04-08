var _num = instance_number(object_index);
var _ind = 0;
for (var i = 0; i < _num; i++) {
    var _inst = instance_find(object_index, i);
    if (_inst == id) {
        _ind = i;
        break;
    }
}
if (instance_exists(obs_microsys)) {
    var _str = format_int(obs_microsys.level,3,0);
    _str = string_replace_all(_str, " ", "0");
    var _int = 0;
    try {
        _int = int64(string_char_at(_str,_ind+1));
    } catch (_) {
        
    }
    image_index = _int;
}