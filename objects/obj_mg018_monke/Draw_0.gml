draw_sprite_ext(sprite_index,image_index,x,y-16,image_xscale,image_yscale/5,image_angle,c_black,0.2);
draw_self();
if (sprite_index == spr_mg018_monke_idle) {
    draw_sprite_ext(spp_mg018_sweat,image_index,x,y-128,image_xscale*2,image_yscale*2,image_angle,image_blend,image_alpha);
}