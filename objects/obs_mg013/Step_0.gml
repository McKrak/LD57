if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        timer_spawndroplet -= 1*sy.dt;
        if (timer_spawndroplet < 0) {
            instance_create_layer(irandom_range(0,room_width), -32, layer,obj_mg013_droplet);
        }
    }
}
// Inherit the parent event
event_inherited();

