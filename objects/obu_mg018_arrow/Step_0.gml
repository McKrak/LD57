if (instance_exists(obs_microsys) && (instance_exists(obu_cursor)) && (instance_exists(obs_mg018))) {
    if (!obs_microsys.pause) {
    if (obs_mg018.state == obs_mg018.st_monke_move) {
        if collision_point(obu_cursor.x,obu_cursor.y, self, false, false) {
            image_index = 1;
            if (mouse_check_button_pressed(mb_left)) {
                array_push(obs_mg018.monke_pattern, type);
                if (instance_exists(obj_mg018_monke)) {
                    if (array_last(obs_mg018.monke_pattern) != (obs_mg018.cat_pattern[array_length(obs_mg018.monke_pattern)-1])) {
                        if (obs_mg018.result == MGR_UNDECIDED) {
                            obs_mg018.result = MGR_LOSE;
                            obs_mg018.state = obs_mg018.st_lose;
                            if (layer_sequence_exists(layer,obs_mg018.seq_arrow)) {
                                layer_sequence_destroy(obs_mg018.seq_arrow);
                            }
                        }
                        obj_mg018_monke.sprite_index = spr_mg018_monke_lose;
                        obj_mg018_monke.image_index = 0;
                        if (instance_exists(obj_mg018_cat)) {
                            obj_mg018_cat.sprite_index = spr_mg018_cat_lose;
                            obj_mg018_cat.image_index = 0;
                        }
                    } else if (array_length(obs_mg018.monke_pattern) == array_length(obs_mg018.cat_pattern)) {
                        if (obs_mg018.result == MGR_UNDECIDED) {
                            obs_mg018.result = MGR_WIN;
                            obs_mg018.state = obs_mg018.st_win;
                            if (layer_sequence_exists(layer,obs_mg018.seq_arrow)) {
                                layer_sequence_destroy(obs_mg018.seq_arrow);
                            }
                        } 
                        obj_mg018_monke.sprite_index = spr_mg018_monke_move;
                        obj_mg018_monke.image_index = type;
                        if (instance_exists(obj_mg018_cat)) {
                            obj_mg018_cat.sprite_index = spr_mg018_cat_move;
                            obj_mg018_cat.image_index = type;
                        }
                    } else {
                        obj_mg018_monke.sprite_index = spr_mg018_monke_move;
                        obj_mg018_monke.image_index = type;
                    }
                    
                }
                obs_mg018.f_hmove_monke = 0;
            }
        } else {
            image_index = 0;
        }
    }
    }
}