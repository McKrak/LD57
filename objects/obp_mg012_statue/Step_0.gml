if (instance_exists(obs_microsys) && instance_exists(obs_mg012)) {
    if (obs_mg012.state == obs_mg012.st_boss_init) && (!obs_microsys.pause) {
        if (shake_status == 0) {
            shake_status = 1;
        } else if (shake_status == 1) {
            shake_status = -1;
        } else shake_status = 1;
            
    }
}