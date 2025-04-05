gpu_push_state();
gpu_set_tex_filter(true);

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*size,image_yscale*size,image_angle,image_blend,image_alpha);

gpu_pop_state();
