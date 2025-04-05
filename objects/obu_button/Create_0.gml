text = "Placeholder text";
sprite_index = spu_button;
ac_hover = animcurve_get_channel(acu_button, "hover");
ac_unhover = animcurve_get_channel(acu_button, "unhover");
t = 0;
size = 1;
is_hovered = false;


state_idle = function() {
    is_hovered = false;
    t = clamp(t-0.00001*delta_time, 0, 1);
    size = animcurve_channel_evaluate(ac_hover, t);
    image_blend = c_white;
}
state_hovered = function() {
    if (!is_hovered) {
        is_hovered = true;
        sfx_play(snu_hover);
    }
    if (instance_exists(obu_cursor)) {
        if !collision_point(obu_cursor.x,obu_cursor.y, self, false, false) state = state_idle;
    }
    
    t = clamp(t+0.00001*delta_time, 0, 1);
    size = animcurve_channel_evaluate(ac_hover, t);
    image_blend = hover_col;
}

state = state_idle;