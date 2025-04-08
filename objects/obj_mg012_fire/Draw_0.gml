if (state == st_move) {
    draw_sprite_ext(spr_mg012_fire,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
    draw_self();
} else {
    boom_size = lerp(boom_size,1,.1);
    image_alpha = lerp(image_alpha,0,.1);
    draw_sprite_ext(sbp_mg012_boom,image_index,x,y,boom_size,boom_size,image_angle,image_blend,image_alpha);
}
