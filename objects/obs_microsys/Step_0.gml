if (layer_sequence_exists(layer, seq_micropause_prompt)) {
    if (layer_sequence_get_headpos(seq_micropause_prompt) >= 25) {
        layer_sequence_pause(seq_micropause_prompt);
        layer_sequence_headpos(seq_micropause_prompt, 25);
    }
}

if (!pause) {
    if (!window_has_focus()) {
        pause = true;
    }
    audio_resume_sound(music);
    if (layer_sequence_exists("SYS", seq_microprep)) {
        if (layer_sequence_is_paused(seq_microprep)) {
            layer_sequence_play(seq_microprep);
        }
    }
    if (layer_sequence_exists(layer, seq_microstage)) {
        if (layer_sequence_is_paused(seq_microstage)) {
            layer_sequence_play(seq_microstage);
        }
    }
    if (layer_sequence_exists(layer, seq_microlife)) {
        if (layer_sequence_is_paused(seq_microlife)) {
            layer_sequence_play(seq_microlife);
        }
    }
    if (layer_sequence_exists(layer, seq_micronum)) {
        if (layer_sequence_is_paused(seq_micronum)) {
            layer_sequence_play(seq_micronum);
        }
    }
    
    if (instance_exists(obu_cursor)) {
        if (instance_exists(obs_microgame)) {
            obu_cursor.image_index = obs_microgame.cursor_spr;
        } else obu_cursor.image_index = 0;
    }
    if (!window_mouse_get_locked()) window_mouse_set_locked(true);
        
    if (keyboard_check_pressed(vk_enter)) {
        pause = !pause;
    }
    
    state();
    
} else {
    audio_pause_sound(music);
    if (layer_sequence_exists("SYS", seq_microprep)) {
        if (!layer_sequence_is_paused(seq_microprep)) {
            layer_sequence_pause(seq_microprep);
        }
    }
    if (layer_sequence_exists(layer, seq_microstage)) {
        if (!layer_sequence_is_paused(seq_microstage)) {
            layer_sequence_pause(seq_microstage);
        }
    }
    if (layer_sequence_exists(layer, seq_microlife)) {
        if (!layer_sequence_is_paused(seq_microlife)) {
            layer_sequence_pause(seq_microlife);
        }
    }
    if (layer_sequence_exists(layer, seq_micronum)) {
        if (!layer_sequence_is_paused(seq_micronum)) {
            layer_sequence_pause(seq_micronum);
        }
    }
    
    if (!layer_sequence_exists(layer,seq_micropause_exit)) {
        if (!layer_sequence_exists(layer, seq_micropause)) {
            seq_micropause = layer_sequence_create(layer, 0,0, sql_pause_enter);
        } else {
            if (layer_sequence_is_finished(seq_micropause) && keyboard_check_pressed(vk_enter)) {
                layer_sequence_destroy(seq_micropause);
                seq_micropause_exit = layer_sequence_create(layer,0,0,sql_pause_exit);
            }
        }
    } else {
        if (layer_sequence_is_finished(seq_micropause_exit)) {
            layer_sequence_destroy(seq_micropause_exit);
            pause = false;
        }
    }
    
    if (instance_exists(obu_cursor)) {
        obu_cursor.image_index = 0;
    }
    
    if (window_mouse_get_locked()) window_mouse_set_locked(false);
}