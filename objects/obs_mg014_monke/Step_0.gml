if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (sprite_index != spr_mg014_monkehurt) {
            if (mouse_check_button_pressed(mb_left)) && (y >= 144) {
                ysp = -10;
                sfx_play(axf_mg014_jump);
            }
            ysp = lerp(ysp, 4, .1);
            y = clamp(y + ysp, -64, 144);
        }
        
        if (place_meeting(x,y,obj_mg014_obstacle)) {
            sprite_index = spr_mg014_monkehurt;
            if (instance_exists(obs_microgame)) {
                if (obs_microgame.result == MGR_UNDECIDED) {
                    sfx_play(axf_mg014_lose);
                    obs_microgame.result = MGR_LOSE;
                }
                
            }
        }
    }
}