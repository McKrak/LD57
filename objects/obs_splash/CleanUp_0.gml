layer_sequence_destroy(seq_skip);
texturegroup_unload("cutscene_opening");
if (audio_exists(trk_amb)) {
    audio_stop_sound(trk_amb);
    audio_destroy_stream(aud_amb);
}
