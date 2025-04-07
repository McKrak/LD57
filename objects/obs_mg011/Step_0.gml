if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (layer_sequence_is_paused(seq_scissors)) {
            layer_sequence_play(seq_scissors);
        }
        if (layer_sequence_is_paused(seq_win)) {
            layer_sequence_play(seq_win);
        }
        state();
        if (left == 0) {
            if (result == MGR_UNDECIDED) {
                result = MGR_WIN;
                if !nightmare seq_win = layer_sequence_create(layer,0,0,sqr_mg011_win);   
            }
        }
    } else {
        if (!layer_sequence_is_paused(seq_scissors)) {
            layer_sequence_pause(seq_scissors);
        }
        if (!layer_sequence_is_paused(seq_win)) {
            layer_sequence_pause(seq_win);
        }
    }
}

// Inherit the parent event
event_inherited();

