if (layer_sequence_is_finished(seq)) || (keyboard_check_pressed(vk_enter)) {
    texturegroup_unload("cutscene_opening");
    texturegroup_load("topmenu");
    room_goto(rmm_main);
    audio_stop_sound(snm_nightamb);
}