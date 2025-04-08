#macro MGR_UNDECIDED -1
#macro MGR_LOSE 0
#macro MGR_WIN  1

result_prev = MGR_UNDECIDED;
result = MGR_UNDECIDED;
won = false;
starttime = time;
playingsound = undefined;
//if (!nightmare) && (instance_exists(obs_microsys)) {
    //nightmare = obs_microsys.difficulty;
//}
if (irandom_range(0,9) == 9) {
    nightmare = true;
}
if (nightmare) && (audio_exists(micro_song_n)) {
    playingsound = audio_play_sound(micro_song_n, 0,is_boss);
} else if (audio_exists(micro_song)) {
    playingsound = audio_play_sound(micro_song, 0,is_boss);
}