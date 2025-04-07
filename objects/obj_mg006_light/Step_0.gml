if (instance_exists(obs_microsys) 
    && instance_exists(obs_microgame)
    && instance_exists(obv_3dcam)) {
    if (!obs_microsys.pause) {
        x = obv_3dcam.cursor_x;
        y = obv_3dcam.cursor_y;
        if (obs_microgame.result == MGR_WIN) {
            image_xscale = lerp(image_xscale,4,.1);
            image_yscale = lerp(image_yscale,4,.1);
        }
    }
    
}