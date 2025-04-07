if (instance_exists(obs_microgame)) {
    if (obs_microgame.nightmare) image_index = 1;
}
image_xscale = .05;
image_yscale = .05;
jerk = irandom_range(jerk_min_time,jerk_max_time);
jerk_pos = irandom_range(jerk_min_y,jerk_max_y);