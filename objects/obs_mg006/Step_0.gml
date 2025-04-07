if (instance_exists(obv_3dcam) && instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        var _hovering_fake = false;
        var _inst = collision_circle_list(obv_3dcam.cursor_x, obv_3dcam.cursor_y,32,obj_mg006_person,true,true,ds_caught,false);
        print(ds_caught);
        for (var i = 0; i < _inst; i++) {
            
            if (ds_caught[| i].is_fake) {
                _hovering_fake = true;
                print(timer_hovering);
                timer_hovering -= 1*spd*sy.dt;
                if (timer_hovering < 0) {
                    if (result == MGR_UNDECIDED) {
                        result = MGR_WIN;
                    }
                }
            }
        }
        ds_list_clear(ds_caught);
        if (!_hovering_fake) {
            timer_hovering = 35;
        }
    }
}

event_inherited();