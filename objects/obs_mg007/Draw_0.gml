
gpu_push_state();
gpu_set_blendmode(bm_normal);
with (obj_mg007_light) Mapping();
gpu_set_blendmode(bm_add);
with (obj_mg007_light) Draw();
gpu_pop_state();