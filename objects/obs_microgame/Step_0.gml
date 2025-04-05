if (!obs_microsys.pause) {
    time -= 1*sy.dt;
    if (time < 0) {
        if (result = MGR_UNDECIDED) {
            if autowin result = MGR_WIN else result = MGR_LOSE;
        }
        obs_microsys.state = obs_microsys.st_microfinish;
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
}