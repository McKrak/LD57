function sfx_play(_audioID) {
	switch (_audioID) {
		case snu_hover:
            audio_play_sound(_audioID, 0,0,1,0,2);
		default:
			audio_play_sound(_audioID,0,0,1,0,1,1);
		break;
	}
}