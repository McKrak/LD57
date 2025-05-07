if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        image_speed = 1;
        if (instance_exists(obs_microgame)) {
            if (obs_microgame.result != MGR_LOSE) {
                wander_timer-=1*sy.dt;
                if (wander_timer < 0) {
                    sprite_index = wander_sprite;
                    var _dir = point_direction(x,y,wander_x,y);
                    x += lengthdir_x(1*sy.dt,_dir);
                    //move_towards_point(wander_x,y,1*sy.dt);
                    if (point_distance(x,y,wander_x,y) < 1) {
                        wander_time = irandom_range(50,110);
                        wander_timer = wander_time;
                        wander_sprite = obs_microgame.nightmare ? spr_mg013n_rainpup_lwalk : spr_mg013_rainpup_lwalk;
                        if (sign(x - wander_x) == -1) wander_sprite = obs_microgame.nightmare ? spr_mg013n_rainpup_rwalk : spr_mg013_rainpup_rwalk;
                    }
                } else {
                    speed = 0;
                    sprite_index = obs_microgame.nightmare ? spr_mg013n_rainpup : spr_mg013_rainpup;
                }
            } else {
                sprite_index = spr_mg013_rainpup_sad;
                speed = 0;
            }
        }
    } else {
        speed = 0;
        image_speed = 0;
    }
}