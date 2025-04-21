if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        state();
        image_speed = 1;
    } else {
        speed = 0;
        image_speed = 0;
    }
}