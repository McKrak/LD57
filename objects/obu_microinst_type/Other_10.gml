
        draw_self();
        if (inst_color) {
            shader_push(shd_colourise);
            shader_set_uniform_f(shader_get_uniform(shd_colourise,"g_Intensity"),1);
            shader_set_uniform_f_array(shader_get_uniform(shd_colourise,"g_TintCol"),[255,128,128,255]);
            draw_sprite_ext(spr_microinst_type,inst,x,y,.4*image_xscale,.2*image_yscale,0,c_white,image_alpha);
            shader_pop();
        } else {
            draw_sprite_ext(spr_microinst_type,inst,x,y,.4*image_xscale,.2*image_yscale,0,c_white,image_alpha);
        }
        
        scribble($"[fa_middle][fa_center]{text}")
            .transform(image_xscale*2,image_yscale,0)
            .blend(c_white,image_alpha)
            .sdf_outline(c_black,1*global.min_scale)
            .z(depth)
            .draw(x,y+48);
