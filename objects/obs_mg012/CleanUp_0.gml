// Inherit the parent event
event_inherited();

if (audio_exists(playingsound)) {
    audio_stop_sound(playingsound);
}
