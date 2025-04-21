scribble($"[fa_middle][fa_right]{text}")
.transform(image_xscale,image_yscale,image_angle)
.blend(image_blend,image_alpha*.5)
.sdf_outline(c_black,0.25*global.min_scale)
.draw(x,y);