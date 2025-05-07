physics_world_update_speed(1*sy.dt);

if (instance_exists(obs_microsys)) {
    physics_pause_enable(obs_microsys.pause);
    layer_sprite_speed(layer_sprite_get_id("BG_TREES","graphic_1C34B1"),!obs_microsys.pause);
    layer_sprite_speed(layer_sprite_get_id("BG_TREES","graphic_65A7C2EE"),!obs_microsys.pause);
    layer_hspeed("BG_CLOUDS",-0.025*!obs_microsys.pause)
    if (!obs_microsys.pause) {
        state();
    }
}


event_inherited();

