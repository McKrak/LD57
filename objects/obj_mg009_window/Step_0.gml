if (instance_exists(obs_microsys)) && (instance_exists(obv_3dcam)) && (instance_exists(obs_mg009)) {
    if !obs_microsys.pause && obs_mg009.state != obs_mg009.st_permerror {
        if (point_in_rectangle(obv_3dcam.cursor_x, obv_3dcam.cursor_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
            image_index = 1;
            if (mouse_check_button_pressed(mb_left)) {
                instance_destroy();
                obs_mg009.state = obs_mg009.st_secretlose;
            }
        } else image_index = 0;
    }
}