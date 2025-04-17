if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        timer_spawn -= 1*sy.dt;
        if (timer_spawn < 0) {
            instance_create_layer(380,144,layer,obj_mg014_obstacle);
            time_spawn = irandom_range(60,120);
            timer_spawn = time_spawn;
        }
    }
}

event_inherited();