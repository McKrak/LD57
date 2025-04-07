// Inherit the parent event
event_inherited();
//dragmode = false;
chosenkey = noone;

st_notholding = function() {
    if (mouse_check_button(mb_left)) {
        if (instance_exists(obu_cursor)) {
            if (!collision_point(obu_cursor.x,obu_cursor.y,obj_mg005_key,false,true)) {
                state = st_dragging;
            } else {
                state = st_holding;
            }
        }
    }
}

st_holding = function() {
    if (mouse_check_button_released(mb_left)) {
        state = st_notholding;
    }
}

st_dragging = function() {
    if (instance_exists(obj_mg005_keyring)) {
        if (layer_sequence_exists(layer, obj_mg005_keyring.seq_keyring)) {
            layer_sequence_angle(obj_mg005_keyring.seq_keyring, layer_sequence_get_angle(obj_mg005_keyring.seq_keyring) - window_mouse_get_delta_x()/2);
        }
    }
    if (mouse_check_button_released(mb_left)) {
        state = st_notholding;
    }
}

st_unlock = function() {
    if (instance_exists(chosenkey) && instance_exists(obj_mg005_gate)) {
        if (chosenkey.type == obj_mg005_gate.requires) {
            obj_mg005_gate.sprite_index = spr_mg005_gate_eat;
            result = MGR_WIN;
        } else {
            obj_mg005_gate.sprite_index = spr_mg005_gate_spit;
            result = MGR_LOSE;
        }
        
        
    }
}

state = st_notholding;
