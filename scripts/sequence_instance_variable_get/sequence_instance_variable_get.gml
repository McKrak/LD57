///@func	sequence_instance_variable_get(TrackStruct, TrackName, VariableName)
///@param	TrackStruct
///@param	TrackName
///@param	VariableName
///@desc	Provide the Sequence Instance "activeTracks" struct, 
//			the name of the track as seen in the Sequence editor
//			and the name of the variable you want to get
function sequence_instance_variable_get(_activeTracks, _trackName, _variable){
	var _t = sequence_track_get(_activeTracks, _trackName);
		return variable_instance_get(_t.instanceID, _variable);
}