if (instance_exists(obs_microsys)) {
    image_speed = !obs_microsys.pause;
}

switch (sprite_index) {
    case spr_mg020_guy_death:
        if (image_index > image_number-1) {
            image_speed = 0;
        }
    break;
    case spr_mg020_guy_throw:
        if (image_index > image_number-1) {
            image_index = 0;
            sprite_index = spr_mg020_guy_win;
        }
    break;
}