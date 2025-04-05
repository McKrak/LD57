//First, create the camera. We could use camera_create_view, but that is more useful in a 2D environment
camera = camera_create();

view_visible[view] = true;

/** Then, we need to build a projection matrix. 
* I keep this in instance scope in case I need to reassign it later. (Though you can retrieve matrices from a camera with camera_get_* functions)
* I use matrix_build_projection_perspective_fov, as it gives the most control over how your projections looks.
*
* Here's how I use the arguments: 
* I give a 60 degree vertical field of view, 
* with an aspect ratio of view_wport/view_hport, 
* a 32 unit near clipping plane, and a 32000 far clipping plane. 
* Some of these values may need tweaking to your liking.
*/
projMat = matrix_build_projection_perspective_fov(60, -view_get_wport(view)/view_get_hport(view), 3, 5000);
//matrix_build_projection_ortho(view width, view height, znear, zfar);

//Now we assign the projection matrix to the camera
camera_set_proj_mat(camera, projMat);
//Finally, we bind the camera to the view
view_set_camera(view, camera);


x = 0;
y = 0;
z = 60;
xtarget = 0;
ytarget = 0;
ztarget = 0;
xtarget_to = 0;
ytarget_to = 0;
ztarget_to = 0;
x_to = 0;
y_to = 0;
z_to = 0;
look_dir = 0;
look_pitch = 0;
rotx = -45;
roty = 0;
rotz = 0;
lag_speed = 16;


mode_normal = function() {
	x_to = obi_bchar.x;
	y_to = obi_bchar.y+128;
	z_to = 128;
	xtarget_to = obi_bchar.x;
	ytarget_to = obi_bchar.y;
	ztarget_to = obi_bchar.z;
}
mode_zoom = function() {
	x_to = obi_bchar.x;
	y_to = obi_bchar.y+96;
	z_to = 96;
	xtarget_to = obi_bchar.x;
	ytarget_to = obi_bchar.y;
	ztarget_to = obi_bchar.z;
}
mode_overhead = function() {
	x_to = obi_bchar.dest_x*48+24;
	y_to = obi_bchar.dest_y*48+24+48;
	z_to = obi_bchar.dest_z*48+196;
	xtarget_to = obi_bchar.dest_x*48+24;
	ytarget_to = obi_bchar.dest_y*48+24;
	ztarget_to = obi_bchar.dest_z*48;
}


mode = mode_normal;
//Assigns the update script named "camera_update_script" to the camera belonging to view0
//camera_set_update_script(view_camera[0], scv_3dcam);
mLookat = 0;