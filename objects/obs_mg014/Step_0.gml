if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) && (result != MGR_LOSE) {
        layer_hspeed("BG_GROUND", -3*sy.dt);
        timer_spawn -= 1*sy.dt;
        if (timer_spawn < 0) {
            instance_create_layer(380,144,layer,obj_mg014_obstacle);
            time_spawn = irandom_range(60,120);
            timer_spawn = time_spawn;
        }
    } else {
        layer_hspeed("BG_GROUND", 0);
    }
}

event_inherited();