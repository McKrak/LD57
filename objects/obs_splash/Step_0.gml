if (layer_sequence_is_finished(seq)) {
    texturegroup_unload("cutscene_opening");
    room_goto(rmm_main);
}