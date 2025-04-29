if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (layer_sequence_exists("Lose",seq_lose)) {
            if (layer_sequence_is_paused(seq_lose)) && (!layer_sequence_is_finished(seq_lose)) {
                layer_sequence_play(seq_lose);
            }
        }
        state();
    } else {
        if (layer_sequence_exists("Lose",seq_lose)) {
            if (!layer_sequence_is_paused(seq_lose)) {
                layer_sequence_pause(seq_lose);
            }
        }
    }
}

// Inherit the parent event
event_inherited();

