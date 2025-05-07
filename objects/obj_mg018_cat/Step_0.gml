if (instance_exists(obs_mg018)) {
    image_xscale = xscale_init*obs_mg018.dance_squish;
}
if (instance_exists(obs_microsys)) {
    if (obs_microsys.pause) image_speed = 0;
        else image_speed = 1;
}

if (sprite_index == spr_mg018_cat_losen) && (image_index > image_number-1) {
    image_speed = 0;
}