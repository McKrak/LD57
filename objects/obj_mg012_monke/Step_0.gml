if (instance_exists(obs_microgame) && (instance_exists(obs_microsys))) {
    if (!obs_microsys.pause) {
        state();
    }
}