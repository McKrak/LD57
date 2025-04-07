if (!obs_microsys.pause) {
    tick-= 1*sy.dt;
    
    if (tick < 0) {
        wander_x = random_range(64, room_width-64);
        wander_y = random_range(64, room_height-64);
        tick = random(500);
    }
    if (point_distance(x,y,wander_x,wander_y) > 1) {
        move_towards_point(wander_x,wander_y,spd*sy.dt);
    } else speed = 0;
}