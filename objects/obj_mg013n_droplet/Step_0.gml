if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        
    }
    if (y > room_height+16) {
        instance_destroy();
    }
    if (place_meeting(x,y,obj_mg013_rainpup)) && (instance_exists(obs_microgame)) {
        if (obs_microgame.result == MGR_UNDECIDED) {
            obs_microgame.result = MGR_LOSE;
        }
    }
}