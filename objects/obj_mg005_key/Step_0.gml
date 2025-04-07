if (!obs_microsys.pause) {
    if (instance_exists(obu_cursor)) && (instance_exists(obs_mg005)) {
        if (obs_mg005.state != obs_mg005.st_unlock) {
            if (collision_point(obu_cursor.x,obu_cursor.y,self,false,false)) {
                if (mouse_check_button(mb_left)) && (obs_mg005.state == obs_mg005.st_notholding) {
                    held = true;
                    unheld = false;
                    prior_x = x;
                    prior_y = y;
                    prior_angle = image_angle;
                }
            }
            if (held) {
                if (mouse_check_button_released(mb_left)) {
                    held = false;
                    unheld = true;
                }
                image_angle = lerp(image_angle,0,.35*sy.dt);
                x = obu_cursor.x;
                y = obu_cursor.y;
                if (collision_point(x,y-100,obj_mg005_gate,false,true)) {
                    obs_mg005.state = obs_mg005.st_unlock;
                    obs_mg005.chosenkey = self;
                }
            }
            if (obs_mg005.state == obs_mg005.st_dragging) {
                prior_x = x;
                prior_y = y;
                prior_angle = image_angle;
            }
            if (unheld) {
                x = lerp(x,prior_x,.1*sy.dt);
                y = lerp(y,prior_y,.1*sy.dt);
                image_angle = lerp(image_angle,prior_angle,.1*sy.dt);
            }
        }
    }
}