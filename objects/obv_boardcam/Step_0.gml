view_set_wport(view,global.res_width/2);
view_set_hport(view,global.res_height/2);
switch (view) {
	case 1:
		view_set_xport(view,0);
		view_set_yport(view,0);
	break;
	case 2:
		view_set_xport(view,global.res_width/2);
		view_set_yport(view,0);
	break;
	case 3:
		view_set_xport(view,0);
		view_set_yport(view,global.res_height/2);
	break;
	case 4:
		view_set_xport(view,global.res_width/2);
		view_set_yport(view,global.res_height/2);
	break;
}

projMat = matrix_build_projection_perspective_fov(60, -global.res_width/global.res_height, 3, 5000);
camera_set_proj_mat(camera, projMat);


var _cx = window_get_width()/2;
var _cy = window_get_height()/2;
var _mx = window_mouse_get_x();
var _my = window_mouse_get_y();


mode();

x += (x_to - x) / lag_speed;
y += (y_to - y) / lag_speed;
z += (z_to - z) / lag_speed;
xtarget += (xtarget_to - xtarget) / lag_speed;
ytarget += (ytarget_to - ytarget) / lag_speed;
ztarget += (ztarget_to - ztarget) / lag_speed;


mLookat = matrix_build_lookat(x,y,z,xtarget,ytarget,ztarget, 0,0,-1);
//Assign the matrix to the camera. This updates were the camera is looking from, without having to unnecessarily update the projection.
camera_set_view_mat(view_camera[view], mLookat);