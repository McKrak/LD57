/*	
	 !! The variable change will only take place for the current playhead position, making this the most effective when your sequence is paused or when applying the change every frame!!
	 !! This can greatly be put to use when grouping Tracks together using the Group function in the Sequence Editor !!

	Make sure to supply an array of 2 values for POSITION, SCALE and ORIGIN
	OBJECT_INDEX and INSTANCE_ID are both variables that can not be set, but they can be read.

	> POSITION		:	[x, y]
	> SCALE			:	[xs, ys]
	> ROTATION		:	real
	> ORIGIN		:	[xo, yo]
	> IMAGE_BLEND	:	[R, G, B, A]
	> BLEND_MULTIPLY:	[R, G, B, A]
	> IMAGE_SPEED	:	real
	> IMAGE_INDEX	:	real
	> SPRITE_INDEX	:	int
	> ENABLE		:	bool
	> HEIGHT		:	real
	> WIDTH			:	real
	> PITCH			:	real
	> GAIN			:	real
	> MATRIX		:	[matrix]
*/

///@func	sequence_track_variable_set(Track, SequenceTrackVar(enum), Value(some_need_array))
///@param	Track
///@param	SequenceTrackVar(enum)
///@param	Value(some_need_array)
///@desc	The supplied track needs to be the Track Struct stored INSIDE the activeTracks[] array.
//			Use sequence_track_get("name") first to retrieve thee track and then parse it into this function.
function sequence_track_variable_set(_track, _varEnum, _value){
	switch(_varEnum){
		case e_SeqTrackVars.POSITION:		_track.posx												= _value[0];	_track.posy		= _value[1];	break;
		case e_SeqTrackVars.SCALE:			_track.scalex											= _value[0];	_track.scaley	= _value[1];	break;
		case e_SeqTrackVars.ROTATION:		_track.rotation											= _value;										break;
		case e_SeqTrackVars.ORIGIN:			_track.xorigin											= _value[0];	_track.yorigin	= _value[1];	break;
		case e_SeqTrackVars.IMAGE_BLEND:
		case e_SeqTrackVars.BLEND_MULTIPLY:	_track.colormultiply									= _value;										break;
		case e_SeqTrackVars.IMAGE_SPEED:	_track.imagespeed										= _value;										break;
		case e_SeqTrackVars.IMAGE_INDEX:	_track.imageindex										= _value;										break;
		case e_SeqTrackVars.SPRITE_INDEX:	_track.track.keyframes[0].channels[0].spriteIndex		= _value;										break;
		case e_SeqTrackVars.ENABLE:			_track.track.enabled									= _value;										break;
		case e_SeqTrackVars.HEIGHT:			_track.height											= _value;										break;
		case e_SeqTrackVars.WIDTH:			_track.width											= _value;										break;
		case e_SeqTrackVars.PITCH:			_track.pitch											= _value;										break;
		case e_SeqTrackVars.GAIN:			_track.gain												= _value;										break;
		case e_SeqTrackVars.MATRIX:			_track.matrix											= _value;										break;
		
		default : return false;
	}
}