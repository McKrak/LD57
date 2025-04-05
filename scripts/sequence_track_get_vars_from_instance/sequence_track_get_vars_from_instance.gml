///@func	sequence_track_get_vars_from_instance(TrackStruct, InstanceID)
///@param	TrackStruct
///@param	InstanceID
///@desc	Provide the Sequence Instance "activeTracks" struct, 
//			and the InstanceID.
//			This will return an array of every variable defined in the Track Name as seen in the Sequence Editor.
//			Check _SEQUENCESCRIPTS_CONFIG for more info.
function sequence_track_get_vars_from_instance(_activeTracks, _id){
	
	var _l = array_length(_activeTracks);
	if!(_l > 0){ show_debug_message("The Sequence is empty!"); exit; }
	
	for(var i = 0; i < _l; i++){
		
		// Check for .track subtype == 14			
		if(_activeTracks[i].track.type == seqtracktype_instance){
			
			// Check if we found the instance
			var _foundID = variable_struct_get(_activeTracks[i], "instanceID");
			if(_foundID == _id){
				var _name = _activeTracks[i].track.name;
				break;
			}
		}
		
		// Check a level deeper
		if(array_length(_activeTracks[i].activeTracks) > 0){
			sequence_track_get_vars_from_instance(_activeTracks[i], _id);
		}
	}
	
	
	// Fetch the variables after we found the instance Track
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