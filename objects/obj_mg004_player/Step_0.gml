if (!obs_microsys.pause) {
    if (instance_exists(obu_cursor)) {
        phy_speed_x = lerp(phy_speed_x,window_mouse_get_delta_x(),.1);
        phy_speed_y = 0;
        phy_position_y = hook_y;
        phy_fixed_rotation = true;
    }
}
