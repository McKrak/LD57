if (layer_sequence_is_finished(seq)) || ((keyboard_check_pressed(vk_enter)) && skip_prompt) {
    texturegroup_unload("cutscene_opening");
    texturegroup_load("topmenu");
    room_goto(rmm_main);
    audio_stop_sound(snm_nightamb);
}

if (keyboard_check_pressed(vk_enter) && !skip_prompt) {
    if (layer_sequence_exists(layer,seq_skip)) {
        layer_sequence_headpos(seq_skip,0);
    }
    skip_prompt = true;
    timer_skip = time_skip;
}

if (skip_prompt) {
    if (!layer_sequence_exists(layer, seq_skip)) {
        seq_skip = layer_sequence_create(layer,0,0,sql_skip);
    }
    timer_skip-=1*sy.dt;
    if (timer_skip < 0) {
        skip_prompt = false;
    }
}

if (layer_sequence_is_finished(seq_skip)) {
    layer_sequence_destroy(seq_skip);
}