///@func	sequence_variable_get(Sequence, SequenceVar(enum))
///@param	Sequence
///@param	SequenceVar(enum)
///@desc	Returns the Sequence Variable
function sequence_variable_get(_sequence, _var){
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
	
	return variable_struct_get(_sequence, _varname);
}