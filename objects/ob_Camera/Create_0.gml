
globalvar CAMERA_VIEW;
CAMERA_VIEW = 0;

view_enabled = true;
view_set_visible(CAMERA_VIEW, true);

var _centerX = window_get_width()  * 0.5,
	_centerY = window_get_height() * 0.5,
	_camera, _projmat;

window_mouse_set(_centerX, _centerY);
_camera = view_camera[CAMERA_VIEW];
_projmat = matrix_build_projection_perspective_fov(
	60, -_centerX/_centerY, 1, 32000);
camera_set_proj_mat(_camera, _projmat);

cameraHor = 0;
cameraVer = 0;