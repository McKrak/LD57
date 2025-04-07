if (obs_mg008.result != MGR_WIN) {
    draw_sprite_ext(sprite_index,1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
    
    with (obj_mg008_toothtarget) {
        if (instance_exists(obs_mg008)) {
            if (instance_exists(obs_mg008.holding_tooth)) {
                if (obs_mg008.holding_tooth.index == index) image_blend = c_yellow;
            }
        }
        draw_self();
        image_blend = c_white;
    }
    with (obj_mg008_tooth) draw_self();
    
    
    draw_self();
} else {
    sprite_index = spr_mg008_toothfull;
    draw_self();
}
