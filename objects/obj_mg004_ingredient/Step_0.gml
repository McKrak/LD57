if (y > 290) {
    if (instance_exists(obs_microgame)) {
        if (obs_microgame.result == MGR_UNDECIDED) obs_microgame.result = MGR_LOSE;
    }
    if (y > 420) {
        instance_destroy();
    }
}