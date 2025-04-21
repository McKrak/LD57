// Inherit the parent event
event_inherited();
time_call = irandom_range(30,90);
timer_call = time_call;

st_waiting = function() {
    timer_call -= 1*sy.dt;
    if (timer_call < 0) {
        layer_background_index(layer_background_get_id("Background"),1);
        layer_set_visible("Call",true);
        state = st_calling;
    }
}

st_calling = function() {
    obj_mg015_reject_button.x = lerp(obj_mg015_reject_button.x,obj_mg015_reject_button.initx,.1);
    if (instance_exists(obv_3dcam)) {
        if (collision_point(obv_3dcam.cursor_x,obv_3dcam.cursor_y,obj_mg015_reject_button,false,true)) && (mouse_check_button_pressed(mb_left)) {
            state = st_dragging;
        }
    }
}

st_dragging = function() {
    if (collision_point(obv_3dcam.cursor_x,obv_3dcam.cursor_y,obj_mg015_reject_button,false,true)) && (mouse_check_button(mb_left)) {
        obj_mg015_reject_button.x = clamp(obv_3dcam.cursor_x,obj_mg015_reject_button.initx,obj_mg015_reject_button.targetx);
    } else {
        if (mouse_check_button_released(mb_left)) && (obj_mg015_reject_button.x == obj_mg015_reject_button.targetx) {
            state = st_reject;
            result = MGR_WIN;
        } else state = st_calling;
    }
}

st_reject = function() {
    layer_set_visible("Call", false);
}

state = st_waiting;