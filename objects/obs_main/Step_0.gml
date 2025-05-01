if (texturegroup_get_status("topmenu") == texturegroup_status_fetched) || (os_get_config() == "NewConfig1") {
    if (!layer_sequence_exists(layer,seq)) seq = layer_sequence_create(layer,0,0,sqb_main);
}
if (keyboard_check_pressed(vk_enter)) {
    layer_sequence_headpos(seq,250);
}
if (layer_sequence_is_finished(seq)) {
    if (!layer_sequence_exists(layer,seq_ui)) seq_ui = layer_sequence_create(layer,0,0,sql_main); 
    if (keyboard_check_pressed(vk_enter)) {
        layer_sequence_headpos(seq,60);
    }
}