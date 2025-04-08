if (instance_exists(obs_microsys)) && (instance_exists(obs_microgame)) {
    if (!obs_microsys.pause) {
        if (timer_hurt > 0) {
            timer_hurt -= 1*sy.dt;
            image_blend = c_red;
        } else image_blend = c_white;
        if (hp < 0) && (state != st_dead) {
            state = st_dead;
            obs_microgame.result = MGR_WIN;
            obs_microgame.time = 120;
        }
        state();
    }
}