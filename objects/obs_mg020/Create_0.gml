// Inherit the parent event
event_inherited();

seq_boxes = layer_sequence_create("Instances_Behind",300,128,sqr_mg020_boxlayout_0);

st_ready = function() {
    if (instance_exists(obu_mg020_meter)) {
        with (obu_mg020_meter) {
            arrow_move = (arrow_move+0.025*sy.dt) mod 1;
            arrow_ypos = border_u + (border_d-border_u)*arrow_move;
            if (mouse_check_button_pressed(mb_left)) {
                var _range = [border_u+(border_d-border_u)*winstart,border_u+(border_d-border_u)*winend];
                array_sort(_range,true);
                if (arrow_ypos > _range[0])
                && (arrow_ypos < _range[1]) {
                    if (instance_exists(obj_mg020_guy)) {
                        sfx_play(axf_mg020_boxthrow);
                        obj_mg020_guy.sprite_index = spr_mg020_guy_throw;
                        obj_mg020_guy.image_index = 0;
                        obj_mg020_guy.throw_box();
                        if (obs_microgame.result == MGR_UNDECIDED) {
                            obs_microgame.result = MGR_WIN;
                        }
                    }
                    obs_microgame.state = obs_microgame.st_thrown;
                } else {
                    if (instance_exists(obj_mg020_guy)) {
                        obj_mg020_guy.sprite_index = spr_mg020_guy_death;
                        obj_mg020_guy.image_index = 0;
                        obj_mg020_guy.holding.phy_active = true;
                        if (obs_microgame.result == MGR_UNDECIDED) {
                            obs_microgame.result = MGR_LOSE;
                        }
                    }
                    obs_microgame.state = obs_microgame.st_lose;
                }
            }
        }
    }

}

st_thrown = function() {
    
}

st_lose = function() {
    
}

state = st_ready;