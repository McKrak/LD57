//if (window_has_focus()) {
    if (!window_mouse_get_locked()) {
        
        var _x = device_mouse_x_to_gui(0);
        var _y = device_mouse_y_to_gui(0);
        if (!is_nan(_x)) x = _x;
        if (!is_nan(_y)) y = _y;
    } else {
        x = clamp(x + window_mouse_get_delta_x(), 0, NATIVE_W);
        y = clamp(y + window_mouse_get_delta_y(), 0, NATIVE_H);
        if (instance_exists(obs_cursor_bounds)) {
            x = clamp(x,obs_cursor_bounds.bbox_left,obs_cursor_bounds.bbox_right);
            y = clamp(y,obs_cursor_bounds.bbox_top,obs_cursor_bounds.bbox_bottom);
        }
    }
//}


var _hover = collision_point(x,y,obu_button,false,true);
if (instance_exists(_hover)) {
    
    _hover.state = _hover.state_hovered;
    if (mouse_check_button_pressed(mb_left)) {
        sfx_play(snu_select);
        if (is_callable(_hover.action)) _hover.action();
    }
}



t = (t + (.000001*delta_time)) mod 1;
if (!window_get_hover()) {
    image_alpha = animcurve_channel_evaluate(ac_offscreen, t);
} else { 
    t = .5;
    image_alpha = 1;
    //part_particles_create(ps_trail, x,y, px_trail.emitters[0].ind, 1);
}

