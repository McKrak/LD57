if (!obs_microsys.pause) {
    if (layer_sequence_exists(layer,seq_handshake_intro)) {
        if (layer_sequence_is_paused(seq_handshake_intro)) {
            layer_sequence_play(seq_handshake_intro);
        }
    }
    state();
} else {
    if (layer_sequence_exists(layer,seq_handshake_intro)) {
        if (!layer_sequence_is_paused(seq_handshake_intro)) {
            layer_sequence_pause(seq_handshake_intro);
        }
    }
}
// Inherit the parent event
event_inherited();

