if (!obs_microsys.pause) {
    if (layer_sequence_is_paused(seq_result)) {
        layer_sequence_play(seq_result);
    }
    state();
} else {
    if (!layer_sequence_is_paused(seq_result)) {
        layer_sequence_pause(seq_result);
    }
}

// Inherit the parent event
event_inherited();

