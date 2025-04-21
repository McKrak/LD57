xto = x;
inity = y;

st_hover = function() {
        xto += window_mouse_get_delta_x();
        x = lerp(x, xto,.1);
        xto = clamp(xto,96,room_width-96)
        x = clamp(x, 96,room_width-96);
    if (mouse_check_button_pressed(mb_left)) {
        state = st_stab;
    }
}

st_stab = function() {
    y = clamp(y+16*sy.dt,-9999,310);
    if (y == 310) {
        instance_create_layer(x,y,layer,obp_mg016_strike);
        state = st_lift;
    }
}

st_lift = function() {
    y = lerp(y, inity, .3);
    if (point_distance(x,y,x,inity) < 2) {
        state = st_hover;
    }
}

state = st_hover;