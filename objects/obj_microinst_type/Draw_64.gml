if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        draw_self();
        draw_sprite_ext(spr_microinst_type,inst,x,y,.2,.2,0,c_white,1);
        scribble($"[fa_middle][fa_center]{text}")
            .transform(image_xscale*2,image_yscale,0)
            .blend(image_blend,image_alpha)
            .sdf_outline(c_black,1*global.min_scale)
            .gradient(c_blue,.25)
            .draw(x,y+48);
    }
}