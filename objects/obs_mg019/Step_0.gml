if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        curx += window_mouse_get_delta_x()/8;
        cury += window_mouse_get_delta_y()/8;
        curx = clamp(curx,0,buff_w);
        cury = clamp(cury,0,buff_h);
        
        if (mouse_check_button_released(mb_left)) && (surface_exists(surf_target)) {
            var _tmpbuff = buffer_create(buff_w*buff_h*4,buffer_fast,1);
            buffer_get_surface(_tmpbuff,surf_target,0);
            for (var w = 0; w < buff_w; w++) {
                for (var h = 0; h < buff_h; h++) {
                    
                    if (buffer_getpixel(_tmpbuff,w,h,buff_w) != c_white) srf_clear++;
                        
                }
                //print(w);
            }
            buffer_delete(_tmpbuff);
            //print($"{srf_clear}/{buff_w*buff_h}");
            if (buff_w*buff_h)-(srf_clear) < 10 {
                if (result == MGR_UNDECIDED) {
                    result = MGR_WIN;
                }
            }
            srf_clear = 0;
        }
    }
}



// Inherit the parent event
event_inherited();



