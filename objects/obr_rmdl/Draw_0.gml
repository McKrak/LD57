//if (outline) {
//	var g_OutlineColour	= shader_get_uniform(shm_outline, "g_OutlineColour");
//	var g_OutlineRadius = shader_get_uniform(shm_outline, "g_OutlineRadius");
//	var g_OutlinePixelScale = shader_get_uniform(shm_outline, "g_OutlinePixelScale");
//	shader_set_uniform_f(g_OutlineColour,0.0,0.0,0.0,1.0);
//	shader_set_uniform_f(g_OutlineRadius,2.0);
//	shader_set_uniform_f(g_OutlinePixelScale,1.0);
//	shader_push(shm_outline);
	
//}


//if (collidable) {
//	if (instance_exists(obv_3dcam)) {
//		if (obv_3dcam.do_col_check) {
//			if (surface_exists(obv_3dcam.col_surf)) {
//				gpu_set_ztestenable(false);
//				surface_set_target(obv_3dcam.col_surf);
//				draw_set_color(col_color);
//				draw_circle(50,50,50,0);
//				matrix_set(matrix_world, mat);
//				vertex_submit(buff, pr_trianglelist, -1);
//				draw_set_color(c_white);
//				surface_reset_target();
//				gpu_set_ztestenable(true);
//			}
//		}
//	}
//}
if self_update Update();
if do_draw Draw(true);

//if outline shader_pop();