if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (instance_exists(obs_microgame)) {
            if (obs_microgame.result == MGR_LOSE) {
                image_alpha = lerp(image_alpha, 0.5, 0.1);
                solid = false;
            } else {
                x = clamp(x + window_mouse_get_delta_x()/2, 0, room_width);
            }
        }
    }
}