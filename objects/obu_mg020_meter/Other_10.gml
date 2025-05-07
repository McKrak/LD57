gpu_push_state();
gpu_set_tex_filter(false);
//shader_push(shd_default);
//
//shader_pop();

draw_nineslice(sprite_index,image_index,x,y,image_xscale,image_yscale,0.5,image_angle,image_blend,image_alpha);
draw_rectangle_color(border_r,border_u,border_l,border_d,c_red,c_red,c_red,c_red,false);
draw_rectangle_color(border_r,border_u+(border_d-border_u)*winstart,border_l,border_u+(border_d-border_u)*winend,c_lime,c_lime,c_lime,c_lime,false);
draw_sprite_ext(spu_mg020_arrow,image_index,x,arrow_ypos,1,1,0,c_white,1);
gpu_pop_state();