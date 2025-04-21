if (!obs_microsys.pause) {
        draw_sprite_ext(spu_microtimer_back,0,64,300,.2,.2,0,c_white,1);
        draw_sprite_ext(spu_microtimer_hand,0,64,300,.2,.2,(time/starttime)*360, c_white,1);
        if (time < 120) {
            draw_sprite_ext(spu_microtimer_number,time/30,24,300,.5,.5,0,c_white,1);
        }
}
