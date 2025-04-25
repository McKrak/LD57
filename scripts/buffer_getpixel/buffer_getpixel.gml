/// @func buffer_getpixel(buff,x,y,width)
function buffer_getpixel() {
	///buffer_exists
	var b = argument[0];
	if (!buffer_exists(b)) exit

	var px = (argument[1]+(argument[2]*argument[3]))*4;///get pixel

	var p1 = buffer_peek(b,px,buffer_u8);
	var p2 = buffer_peek(b,px+1,buffer_u8);
	var p3 = buffer_peek(b,px+2,buffer_u8);

	return (p1+(256*p2))+(65536*p3);
}