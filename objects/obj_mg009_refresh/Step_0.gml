if (instance_exists(obs_microsys)) && (instance_exists(obs_mg009)) {
    if (!obs_microsys.pause) {
        if (instance_exists(obv_3dcam)) {
            if (!reloading) {
                if (collision_point(obv_3dcam.cursor_x,obv_3dcam.cursor_y,self,false,false)) {
                    if (mouse_check_button_pressed(mb_left)) {
                        obs_mg009.state = obs_mg009.st_reload;
                        reloading = true;
                        timer_reload = reload_time;
                    } else image_index = 1;
                } else image_index = 0;
            } else {
                image_index = 2;
                timer_reload -= 1*sy.dt*obs_microsys.spd;
                if (timer_reload < 0) {
                    obs_mg009.state = obs_mg009.st_reloaded;
                    reloading = false;
                }
            }
        }
    }
    
}
