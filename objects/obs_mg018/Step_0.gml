
if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (layer_sequence_exists("SYS",seq_announce)) {
            if (layer_sequence_is_paused(seq_announce)) && (!layer_sequence_is_finished(seq_announce)) {
                layer_sequence_play(seq_announce);
            }
        }
        if (layer_sequence_exists("UI",seq_arrow)) {
            if (layer_sequence_is_paused(seq_arrow)) && (!layer_sequence_is_finished(seq_arrow)) {
                layer_sequence_play(seq_arrow);
            }
        }
        if (layer_sequence_exists("WIN_BG",seq_winbg)) {
            if (layer_sequence_is_paused(seq_winbg)) {
                layer_sequence_play(seq_winbg);
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
        if (layer_sequence_exists("WIN_BG",seq_winbg)) {
            if (!layer_sequence_is_paused(seq_winbg)) {
                layer_sequence_pause(seq_winbg);
            }
        }
    }
}
// Inherit the parent event
event_inherited();

