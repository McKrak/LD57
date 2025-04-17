if (instance_exists(obs_microgame)) && (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) && (obs_microgame.result == MGR_LOSE) {
        image_alpha = lerp(image_alpha,.5,.1);
    }
}