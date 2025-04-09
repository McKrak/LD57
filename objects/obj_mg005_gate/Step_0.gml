if (instance_exists(obs_microsys)) && (instance_exists(obs_mg005)) {
    if (!obs_microsys.pause) && (obs_mg005.state == obs_mg005.st_unlock) {
        if (image_index < image_number - 1) {
            image_index += 0.1*sy.dt;
        }
    }
}