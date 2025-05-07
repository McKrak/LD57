#macro MGR_UNDECIDED -1
#macro MGR_LOSE 0
#macro MGR_WIN  1

if (instance_exists(obs_microsys)) {
    if (is_array(obs_microsys.microgame_file)) {
        time = obs_microsys.micro_time;
        micro_song = obs_microsys.micro_song[0];
        micro_song_n = obs_microsys.micro_song[1];
        autowin = obs_microsys.micro_autowin;
        cursor_spr = obs_microsys.micro_showcursor ? 0 : 3;
        nightmare = obs_microsys.micro_nightmare;
    }
}

result_prev = MGR_UNDECIDED;
result = MGR_UNDECIDED;
won = false;
starttime = time;
track = -1;
playingsound = undefined;


//if (audio_exists(track)) {
    //playingsound = audio_play_sound(track, 0,is_boss);
//}

//}