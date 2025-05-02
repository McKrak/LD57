#macro MGR_UNDECIDED -1
#macro MGR_LOSE 0
#macro MGR_WIN  1

if (instance_exists(obs_microsys)) {
    if (is_array(obs_microsys.microgame_file)) {
        time = obs_microsys.micro_time;
        micro_song = obs_microsys.micro_song[0];
        micro_song_n = obs_microsys.micro_song[1];
        autowin = obs_microsys.micro_autowin;
    }
}

result_prev = MGR_UNDECIDED;
result = MGR_UNDECIDED;
won = false;
starttime = time;
track = -1;
playingsound = undefined;
//if (!nightmare) && (instance_exists(obs_microsys)) {
    //nightmare = obs_microsys.difficulty;
//}
if (irandom_range(0,9) == 9) {
    nightmare = true;
}
var _trackpath = $"{ROOT_DIR}/StreamData/{micro_song}.ogg";
if (nightmare) _trackpath = $"{ROOT_DIR}/StreamData/{micro_song_n}.ogg";
if (file_exists(_trackpath)) {
    track = audio_create_stream(_trackpath);
}
//if (nightmare) && (audio_exists(micro_song_n)) {
    //playingsound = audio_play_sound(micro_song_n, 0,is_boss);
//} else if (audio_exists(micro_song)) {
    playingsound = audio_play_sound(track, 0,is_boss);
//}