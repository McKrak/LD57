time_skip = 155;
timer_skip = time_skip;
skip_prompt = true;
aud_amb = -1;
trk_amb = -1;
var _f = $"{ROOT_DIR}/StreamData/snm_nightamb.ogg";
if (file_exists(_f)) {
    print("GURT");
    aud_amb = audio_create_stream(_f);
    if (audio_exists(aud_amb)) {
        trk_amb = audio_play_sound(aud_amb,0,true);
    }
}

seq_skip = -1;
seq = layer_sequence_create(layer,0,0,sqv_opening);