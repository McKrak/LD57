#macro SEQTRACK_STRING_SEPERATOR ";"
#macro SEQTRACK_VARIABLE_SEPERATOR "$"

/*
	To insert variables into a Sequence Track, define the start of the variables with the
	SEQTRACK_STRING_SEPERATOR symbol, and then each subsequent variable with the
	SEQTRACK_VARIABLE_SEPERATOR.
	
	As an example:
	sprite_message_box;Hello World!$0$0$120$What is this?
	
	The Track itself would be "sprite_message_box"
	Then we seperate that name with the variable section using ";"
	The rest is a few variables which can be read and used: Hello World, 0, 0, 120, What is this?
	Those are all seperated by the "$" symbol
*/

enum e_SeqTrackVars{
	// Parameter Tracks
	NAME,
	POSITION,
	ORIGIN,
	SCALE,
	ROTATION,
	SPRITE_INDEX,			// Can not be SET outside of Keyframe Channels
	IMAGE_SPEED,
	IMAGE_INDEX,
	IMAGE_ANGLE,
	BLEND_MULTIPLY,
	IMAGE_BLEND,
	
	// Sequence Parameters
	FALLOFF,
	GAIN,
	PITCH,
	HEIGHT,
	WIDTH,
	ENABLE,
	MATRIX,
	
	
	// Can't set, only get
	INSTANCE_ID,
	OBJECT_INDEX
}

enum e_SeqVars{
	SEQ_LENGTH,
	SEQ_LOOPMODE,
	SEQ_NAME,
	SEQ_PLAYBACKSPEED,
	SEQ_PLAYBACKSPEEDTYPE,
	SEQ_VOLUME,
	SEQ_XORIGIN,
	SEQ_YORIGIN
} 