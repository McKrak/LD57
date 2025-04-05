///@func	sequence_track_variable_get(Track, SequenceTrackVar(enum))
///@param	Track
///@param	SequenceTrackVar(enum)
///@desc	The supplied track needs to be the Track Struct stored INSIDE the activeTracks[] array.
//			Use sequence_track_get("name") first to retrieve thee track and then parse it into this function.
function sequence_track_variable_get(_track, _varEnum){
	switch(_varEnum){
		case e_SeqTrackVars.POSITION:		return [_track.posx, _track.posy];							break;
		case e_SeqTrackVars.SCALE:			return [_track.scalex, _track.scaley];						break;
		case e_SeqTrackVars.ROTATION:		return _track.rotation;										break;
		case e_SeqTrackVars.ORIGIN:			return [_track.xorigin, _track.yorigin]						break;
		case e_SeqTrackVars.IMAGE_BLEND:
		case e_SeqTrackVars.BLEND_MULTIPLY:	return _track.colormultiply;								break;
		case e_SeqTrackVars.IMAGE_SPEED:	return _track.imagespeed;									break;
		case e_SeqTrackVars.IMAGE_INDEX:	return _track.imageindex;									break;
		case e_SeqTrackVars.SPRITE_INDEX:	return _track.track.keyframes[0].channels[0].spriteIndex;	break;
		case e_SeqTrackVars.ENABLE:			return _track.track.enabled;								break;
		case e_SeqTrackVars.HEIGHT:			return _track.height;										break;
		case e_SeqTrackVars.WIDTH:			return _track.width;										break;
		case e_SeqTrackVars.PITCH:			return _track.pitch;										break;
		case e_SeqTrackVars.GAIN:			return _track.gain;											break;
		case e_SeqTrackVars.INSTANCE_ID:	return _track.instanceID;									break;
		case e_SeqTrackVars.OBJECT_INDEX:	return _track.track.keyframes[0].channels[0].objectIndex;	break;
		case e_SeqTrackVars.MATRIX:			return _track.matrix;										break;
		
		default : return false;
	}
}