/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        var _caught = 0;
        for (var i = 0; i < instance_number(obj_mg016_vegg); i++) {
            var _inst = instance_find(obj_mg016_vegg,i);
            if (_inst.state = _inst.st_stabbed) {
                _caught++;
            }
        }
        if (_caught == instance_number(obj_mg016_vegg)) && (result == MGR_UNDECIDED) {
            result = MGR_WIN;
        }
    }
}
// Inherit the parent event
event_inherited();

