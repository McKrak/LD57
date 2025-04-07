draw_self();
var _contentx = x-((sprite_width*image_xscale)/2);
var _contenty = y-((sprite_height*image_yscale)/2);
var _cornerx = x + sprite_width*image_xscale/2;
var _cornery = y + sprite_height*image_yscale/2;
draw_sprite_ext(spr_mg002_ad,ad_type,x,y+24,image_xscale/2/1.1,image_yscale/2/1.4, image_angle,image_blend,image_alpha);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);