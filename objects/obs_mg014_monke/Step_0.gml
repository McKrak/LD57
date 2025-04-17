if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (mouse_check_button_pressed(mb_left)) && (y >= 144) {
            ysp = -10*sy.dt;
        }
        ysp = lerp(ysp, 5, .1*sy.dt);
        y = clamp(y + ysp, -64, 144);
    }
}