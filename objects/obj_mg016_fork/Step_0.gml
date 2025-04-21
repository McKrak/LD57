if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        xto += window_mouse_get_delta_x();
        x = lerp(x, xto,.1);
        xto = clamp(xto,96,room_width-96)
        x = clamp(x, 96,room_width-96);
    }
}