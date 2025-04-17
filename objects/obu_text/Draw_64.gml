scribble($"[fa_middle][fa_center]{text}")
.transform(image_xscale,image_yscale,image_angle)
.blend(image_blend,image_alpha)
.sdf_outline(c_black,1*global.min_scale)
.scale(scale)
.draw(x,y);