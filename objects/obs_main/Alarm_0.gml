var button1 = sequence_track_get(seqinst.activeTracks, "play");
var button4 = sequence_track_get(seqinst.activeTracks, "exit");
button1.instanceID.text = loc("topmenu.play");
button4.instanceID.text = loc("topmenu.exit");
button4.instanceID.action = act_exit;
button1.instanceID.action = act_play;