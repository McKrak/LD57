if (instance_exists(obs_mg015)) {
    if (obs_mg015.state = obs_mg015.st_dragging) {
        image_alpha = lerp(image_alpha,0,.1);
    } else {
        image_alpha = lerp(image_alpha,1,.1);
    }
}