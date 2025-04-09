if (texturegroup_get_status("topmenu") == texturegroup_status_fetched) || (os_get_config() == "NewConfig1") {
    if (!layer_sequence_exists(layer,seq)) seq = layer_sequence_create(layer,0,0,sql_main);
}