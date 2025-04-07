if (!obs_microsys.pause) {
    x += 0.40*sy.dt;
    y = lerp(y, jerk_pos, .1*sy.dt);
    if (jerk < 0) {
        jerk = irandom_range(jerk_min_time,jerk_max_time);
        jerk_pos = irandom_range(jerk_min_y,jerk_max_y);
    } else {
        jerk -= 1*sy.dt;
    }
}