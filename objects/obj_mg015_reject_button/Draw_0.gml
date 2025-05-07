draw_self();
gpu_push_state();
gpu_set_texfilter(false);
gpu_set_blendmode(bm_normal);
shader_push();
scribble("[fnt_main_alt][fa_center][fa_middle]REJECT").z(depth).blend(image_blend,textalpha).draw(initx,y+32);
shader_pop();
gpu_pop_state();