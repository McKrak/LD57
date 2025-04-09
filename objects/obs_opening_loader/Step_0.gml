if (texturegroup_get_status("cutscene_opening") == texturegroup_status_fetched) || (os_get_config() == "NewConfig1") {
    room_goto(rmm_opening);
}