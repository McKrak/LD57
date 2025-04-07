///@func	sequence_variable_set(Sequence, SequenceVar(enum), Value)
///@param	Sequence
///@param	SequenceVar(enum)
///@param	Value
///@desc	Sets the Sequence Variable to the given value
function sequence_variable_set(_sequence, _var, _value){
	var _varname;
	switch(_var){
		case e_SeqVars.SEQ_LENGTH:				_varname = "length"				break;
		case e_SeqVars.SEQ_LOOPMODE:			_varname = "loopmode"			break;
		case e_SeqVars.SEQ_NAME:				_varname = "name"				break;
		case e_SeqVars.SEQ_PLAYBACKSPEED:		_varname = "playbackSpeed"		break;
		case e_SeqVars.SEQ_PLAYBACKSPEEDTYPE:	_varname = "playbackSpeedType"	break;
		case e_SeqVars.SEQ_VOLUME:				_varname = "volume"				break;
		case e_SeqVars.SEQ_XORIGIN:				_varname = "xorigin"			break;
		case e_SeqVars.SEQ_YORIGIN:				_varname = "yorigin"			break;
		default : _varname = "name";
	}
	
	variable_struct_set(_sequence, _varname, _value);
}