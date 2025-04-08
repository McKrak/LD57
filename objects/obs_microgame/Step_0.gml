if (!obs_microsys.pause) {
        if (!is_boss) time -= 1*sy.dt*spd;
        if (time < 0) {
            if (result = MGR_UNDECIDED) {
                if autowin result = MGR_WIN else result = MGR_LOSE;
            }
            obs_microsys.state = obs_microsys.st_microfinish;
            if (result == MGR_WIN) && (is_boss) {
                obs_microsys.life = clamp(obs_microsys.life+1,0,4);
            }
        } else {
            if (result != result_prev) {
                result_prev = result;
                if (result == MGR_WIN) {
                    sfx_play(snu_microwinA);
                } else if (result == MGR_LOSE) {
                    sfx_play(snu_microlose0);
                }
            }
        }

    
    if (audio_exists(playingsound)) {
        audio_resume_sound(playingsound);
    }
    
} else {
    if (audio_exists(playingsound)) {
        audio_pause_sound(playingsound);
    }
}