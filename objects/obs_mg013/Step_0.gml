if (instance_exists(obs_microsys)) {
    physics_pause_enable(obs_microsys.pause);
    if (!obs_microsys.pause) {
        timer_spawndroplet -= 1*sy.dt;
        if (timer_spawndroplet < 0) {
            timer_spawndroplet = time_spawndroplet;
            if (nightmare) {
                instance_create_layer(irandom_range(0,room_width), -32, layer,obj_mg013n_droplet);
            } else {
                repeat (5) {
                    instance_create_layer(irandom_range(0,room_width), -32, layer,obj_mg013_droplet);
                }
                
            }
            
        }
    }
}


// Inherit the parent event
event_inherited();

