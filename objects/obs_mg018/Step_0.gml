
if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (layer_sequence_exists("SYS",seq_announce)) {
            if (layer_sequence_is_paused(seq_announce)) && (!layer_sequence_is_finished(seq_announce)) {
                layer_sequence_play(seq_announce);
            }
        }
        if (layer_sequence_exists("UI",seq_arrow)) {
            if (layer_sequence_is_paused(seq_arrow)) && (!layer_sequence_is_finished(seq_arrow)) {
                layer_sequence_pause(seq_arrow);
            }
        }
        state();
    } else {
        if (layer_sequence_exists("SYS",seq_announce)) {
            if (!layer_sequence_is_paused(seq_announce)) {
                layer_sequence_pause(seq_announce);
            }
        }
        if (layer_sequence_exists("UI",seq_arrow)) {
            if (!layer_sequence_is_paused(seq_arrow)) {
                layer_sequence_pause(seq_arrow);
            }
        }
    }
}
// Inherit the parent event
event_inherited();

