if (instance_exists(obs_microsys) && (instance_exists(obs_microgame))) {
    if (!obs_microsys.pause) && (obs_microgame.result != MGR_LOSE) {
        x-=3*sy.dt;
        if x < -140 instance_destroy();
    }
}