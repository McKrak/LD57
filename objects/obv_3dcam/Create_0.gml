//First, create the camera. We could use camera_create_view, but that is more useful in a 2D environment
camera = camera_create();

view_enabled[view] = true;
view_visible[view] = true;



view_set_camera(view, camera);

look_dir = 0;
look_pitch = 0;


mLookat = 0;

spd = 10;

proj_mat = undefined;
view_mat = undefined;


drawmode = true;
output = noone;

res_ratio_width = 1;
res_ratio_height = 1;
ortho_zoom = 1;