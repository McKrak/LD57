gpu_push_state();
gpu_set_tex_filter(true);

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*size,image_yscale*size,image_angle,image_blend,image_alpha);
scribble("[fa_center][fa_middle]"+text).blend(c_black,1).scale(.35).draw(x,y);
gpu_pop_state();

//draw_text_scribble(x, y, text);
//var _font = draw_get_font();
//draw_set_font(fnt_main);
//
//draw_set_halign(fa_center);
//draw_set_valign(fa_middle);
//draw_text_color(x,y,text,c_black,c_black,c_black,c_black,1);
//draw_set_font(_font);
