//shader_push(shm_ambient);
//shader_set_uniform_f(u_AmbientColor, ambientColor.X, ambientColor.Y, ambientColor.Z);


//with (obr_mesh) Draw(true);
//shader_pop();
if (add_shadows) {
	with (obr_light) Mapping();
}
gpu_set_blendmode(bm_add);
with (obr_light) Draw();
gpu_set_blendmode(bm_normal);

//matrix_set(matrix_world, matrix_build_identity());

with (obr_wireframe) Draw();