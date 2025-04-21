/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (result == MGR_UNDECIDED) {
            result = MGR_WIN;
        }
    }
}
// Inherit the parent event
event_inherited();

