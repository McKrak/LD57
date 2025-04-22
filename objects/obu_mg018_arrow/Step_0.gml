if (instance_exists(obs_microsys) && (instance_exists(obu_cursor)) && (instance_exists(obs_mg018))) {
    if (obs_mg018.state == obs_mg018.st_monke_move) {
        if collision_point(obu_cursor.x,obu_cursor.y, self, false, false) {
            image_index = 1;
            if (mouse_check_button_pressed(mb_left)) {
                array_push(obs_mg018.monke_pattern, type);
            }
        } else {
            image_index = 0;
        }
    }
}