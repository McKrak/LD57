if (instance_exists(obs_microsys) && (instance_exists(obs_microgame))) {
    if (!obs_microsys.pause) {
        if (obs_microgame.result == MGR_UNDECIDED) {
            x -= 0.40*sy.dt;
            y = lerp(y, obv_3dcam.cursor_y, .1*sy.dt);  
            if (place_meeting(x,y,obj_mg003_fuzzy_hand)) {
                instance_destroy(obj_mg003_fuzzy_hand);
                sprite_index = spr_mg003_handshake;
                if (obs_microgame.nightmare) obs_microgame.result = MGR_LOSE;
                else obs_microgame.result = MGR_WIN;
            } 
            if (x < 360) {
                if (obs_microgame.nightmare) obs_microgame.result = MGR_WIN;
                else obs_microgame.result = MGR_LOSE;
            }
        }
        
    }
}