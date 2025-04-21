if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        timer_kill -= 1*sy.dt;
        if (timer_kill < 0) {
            instance_destroy();
        }
        image_xscale = lerp(image_xscale,.5,.2);
        image_yscale = lerp(image_yscale,.5,.2);
    }
}