gpu_set_ztestenable(false);
if (!surface_exists(surf)) {
	surf = surface_create(640,360);
}

	surface_set_target(surf);
	draw_circle_color(50,50,50,c_blue,c_green,false);
	surface_reset_target();
gpu_set_ztestenable(true);