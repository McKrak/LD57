
if (point_in_rectangle(obu_cursor.x, obu_cursor.y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
    image_index = 1;
    if (mouse_check_button_released(mb_left)) {
        instance_destroy();
    }
} else image_index = 0;