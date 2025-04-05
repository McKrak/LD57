var _centerX = window_get_width()  * 0.5,
	_centerY = window_get_height() * 0.5;
if (mouse_check_button(mb_right)) {
cameraHor -= (window_mouse_get_x() - _centerX) * 0.1;
cameraVer -= (window_mouse_get_y() - _centerY) * 0.1;
cameraVer = clamp(cameraVer, -80, 80);
window_mouse_set(_centerX, _centerY);
}

var _flatDis = lengthdir_x(600,     cameraVer),
	_dirX    = lengthdir_y(_flatDis, cameraHor),
	_dirY    = lengthdir_y(600,     cameraVer),
	_dirZ    = lengthdir_x(_flatDis, cameraHor);

var _camera, _viewmat;
_camera  = view_camera[CAMERA_VIEW];
_viewmat = matrix_build_lookat(
	-_dirX,	200-_dirY,	-_dirZ, 
	 0,		200,		 0,  
	 0,		-1,			 0);
camera_set_view_mat(_camera, _viewmat);