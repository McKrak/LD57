if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (result == MGR_WIN) {
            state = st_boss_clear;
        }
        state();
    } else {
        layer_sequence_pause(seq_statue);
    }
}

// Inherit the parent event
event_inherited();

