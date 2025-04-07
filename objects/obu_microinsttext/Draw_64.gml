if (!obs_microsys.pause) {
    scribble($"[fa_middle][fa_center]{text}")
    .transform(image_xscale,image_yscale,image_angle)
    .blend(image_blend,image_alpha)
    .sdf_outline(c_black,2)
    .gradient(c_black,.25)
    .draw(x,y);
}
