///model_load(filepath, vformat, freeze)
/// @func model_load(filepath, vformat, freeze)
/// @desc Loads a mobel in via buffer. Returns -1 if the file isn't found, otherwise returns a vertex buffer ID
/// @arg filepath
/// @arg vformat
/// @arg freeze
/// @return -1 on fail or a vbuffer ID
function model_load(argument0, argument1, argument2=true) {

	if(!file_exists(argument0))
	{
		show_debug_message("File not Found: " + string(argument0));
		return -1;
	}
	var buff = buffer_load(argument0);

	var vbuff = vertex_create_buffer_from_buffer(buff, argument1);
	if argument2 vertex_freeze(vbuff);

	buffer_delete(buff);
	return vbuff;
}
