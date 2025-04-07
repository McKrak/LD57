if (instance_exists(obs_microsys)) {
    if (obs_microsys.pause) {
        if (layer_sequence_exists(layer,seq_life)) {
            if (!layer_sequence_is_paused(seq_life)) {
                layer_sequence_pause(seq_life);
            }
        }
    } else {
        if (layer_sequence_exists(layer,seq_life)) {
            if (layer_sequence_is_paused(seq_life)) {
                layer_sequence_play(seq_life);
            }
        }
        layer_sequence_x(seq_life, x);
        layer_sequence_y(seq_life, y);
        layer_sequence_xscale(seq_life, image_xscale);
        layer_sequence_yscale(seq_life, image_yscale);
    }
}