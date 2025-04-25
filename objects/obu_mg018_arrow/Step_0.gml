if (instance_exists(obs_microsys) && (instance_exists(obu_cursor)) && (instance_exists(obs_mg018))) {
    if (!obs_microsys.pause) {
    if (obs_mg018.state == obs_mg018.st_monke_move) {
        if collision_point(obu_cursor.x,obu_cursor.y, self, false, false) {
            image_index = 1;
            if (mouse_check_button_pressed(mb_left)) {
                array_push(obs_mg018.monke_pattern, type);
                if (instance_exists(obj_mg018_monke)) {
                    obj_mg018_monke.sprite_index = spr_mg018_monke_move;
                    obj_mg018_monke.image_index = type;
                }
                obs_mg018.f_hmove_monke = 0;
            }
        } else {
            image_index = 0;
        }
    }
    }
}