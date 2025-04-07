image_xscale = .15;
image_yscale = .15;
if (is_fake) {
    image_index = 1;
}
tick = random(500);

spd = 1;
wander_x = x;
wander_y = y;
if ((irandom(1))) {
    wander_x = random_range(64, room_width-64);
    wander_y = random_range(64, room_height-64);
}

