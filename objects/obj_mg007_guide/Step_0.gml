if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        xsp += window_mouse_get_delta_x()/8;
        ysp += window_mouse_get_delta_y()/8;
        xsp = lerp(xsp, 0, .1);
        ysp = lerp(ysp, 0, .1);
        x += xsp;
        y += ysp;
    }
} 