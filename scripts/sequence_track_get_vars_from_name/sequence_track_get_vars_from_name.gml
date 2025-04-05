///@func	sequence_track_get_vars_from_name(Track)
///@param	Track
///@desc	The supplied track needs to be the Track Struct stored INSIDE the activeTracks[] array.
//			Use sequence_track_get("name") first to retrieve thee track and then parse it into this function.
function sequence_track_get_vars_from_name(_track){
	
	// Fetch the variables count
	var _name			= _track.name;
	var _varArray		= [];
	var _varCount		= 0;
	var _string			= "";
	
	var _seperatorPos	= string_pos(SEQTRACK_STRING_SEPERATOR, _name);
	if(_seperatorPos == 0){ 
		show_debug_message("No specified variables in the track name, or no seperator used.");
		return false; 
	}
	
	
	_string = string_copy(_name, _seperatorPos +1, string_length(_name) - _seperatorPos +1);
	_varCount = string_count(SEQTRACK_VARIABLE_SEPERATOR, _string) +1;
	
	// Extract the variables into an array
	var i = 0; repeat(_varCount){
		_seperatorPos = string_pos(SEQTRACK_VARIABLE_SEPERATOR, _string);
		if(string_length(_string) > 0){
			if(_seperatorPos == 0){
				_varArray[@ i] = string_copy(_string, 1, string_length(_string));
			} else {
				_varArray[@ i] = string_copy(_string, 1, _seperatorPos -1);
			}
		} else {
			_varArray[@ i] = undefined;
		}
		
		_string = string_delete(_string, 1, _seperatorPos);
		i++;
	}
	
	return _varArray;
}