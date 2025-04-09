// Auto-generated stubs for each available event.

function squ_typewriter_Moment()
{
    var _keys = ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"];
    _keys = array_reverse(_keys);
    for (var i = 0; i < instance_number(obj_typewriter_key); i++) {
        var _inst = instance_find(obj_typewriter_key,i);
        _inst.key = _keys[i];
        
    }
}