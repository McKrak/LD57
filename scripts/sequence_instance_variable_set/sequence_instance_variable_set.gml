///@func	sequence_instance_variable_set(TrackStruct, TrackName, VariableName, Value)
///@param	TrackStruct
///@param	TrackName
///@param	VariableName
///@param	Value
///@desc	Provide the Sequence Instance "activeTracks" struct, 
//			the name of the track as seen in the Sequence editor,
//			the name of the variable you want to set
//			and lastly the value you want to set it to.
function sequence_instance_variable_set(_activeTracks, _trackName, _variable, _value){
	var _t = sequence_track_get(_activeTracks, _trackName);
		variable_instance_set(_t.instanceID, _variable, _value);
}