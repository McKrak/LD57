///@func	sequence_track_get(TrackStruct, TrackName)
///@param	TrackStruct
///@param	TrackName
///@desc	Provide the Sequence Instance "activeTracks" struct
//			and the name of the track as seen in the Sequence editor.
//			Returns the Track Struct of the given Track
function sequence_track_get(_activeTracks, _trackName){
			
	var _l = array_length(_activeTracks);
	if!(_l > 0){ show_debug_message("The Track Struct is empty!"); exit; }
		
	// Recursive search through all Tracks in a Track Struct
	for(var i = 0; i < _l; i++){
			
		// Check for track Name	
		if(_activeTracks[i].track.name == _trackName){
			return _activeTracks[i];
		}
			
		// Check a level deeper
		if(array_length(_activeTracks[i].activeTracks) > 0){
			sequence_track_get(_activeTracks[i], _trackName);
		}
	}
	
	show_debug_message("Can't find the track!");
	return false;
}