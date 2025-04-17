if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        x-=3*sy.dt;
        if x < -140 instance_destroy();
    }
}