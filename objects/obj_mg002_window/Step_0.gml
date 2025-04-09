
if (!obs_microsys.pause) {
if (point_in_rectangle(obv_3dcam.cursor_x, obv_3dcam.cursor_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
    image_index = 1;
    if (mouse_check_button_released(mb_left)) {
        instance_destroy();
    }
} else image_index = 0; /*else if (point_in_rectangle(obv_3dcam.cursor_x, obv_3dcam.cursor_y, 
    x - image_xscale*sprite_width/2, y - image_yscale*sprite_height/2,
    x + image_xscale*sprite_width/2, y + image_yscale*sprite_height/2)) {
        if (mouse_check_button(mb_left)) {
            x = obv_3dcam.cursor_x;
            y = obv_3dcam.cursor_y;
        }
    }*/
}