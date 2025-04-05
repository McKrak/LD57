if (!pause) {
    if (layer_sequence_exists(layer, seq_microprep)) {
        if (layer_sequence_is_paused(seq_microprep)) {
            layer_sequence_play(seq_microprep);
        }
    }
    if (layer_sequence_exists(layer, seq_microstage)) {
        if (layer_sequence_is_paused(seq_microstage)) {
            layer_sequence_play(seq_microstage);
        }
    }

    state();
} else {
    if (layer_sequence_exists(layer, seq_microprep)) {
        if (!layer_sequence_is_paused(seq_microprep)) {
            layer_sequence_pause(seq_microprep);
        }
    }
    if (layer_sequence_exists(layer, seq_microstage)) {
        if (!layer_sequence_is_paused(seq_microstage)) {
            layer_sequence_pause(seq_microstage);
        }
    }
}

if (keyboard_check_pressed(vk_escape)) {
    pause = !pause;
}