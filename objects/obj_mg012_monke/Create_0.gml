time_fire = 30;
timer_fire = time_fire;
time_hit = 120;
timer_hit = time_hit;
xsp = random_range(-2,2);
ysp = random_range(-12, -4);


act_move = function() {
    x = lerp(x, x + window_mouse_get_delta_x(), .1);
    y = lerp(y, y + window_mouse_get_delta_y(), .1);
    if (instance_exists(obs_mg012_bounds)) {
        x = clamp(x,obs_mg012_bounds.bbox_left,obs_mg012_bounds.bbox_right);
        y = clamp(y,obs_mg012_bounds.bbox_top,obs_mg012_bounds.bbox_bottom);
    }
    if (place_meeting(x,y,GRP_mg012_COLLIDABLE)) {
        state = st_hit;
        obs_microgame.time = 120;
    }
}

st_idle = function() {
    act_move();
    if (mouse_check_button_pressed(mb_left)) {
        instance_create_layer(x+16,y-12,"Bullets",obj_mg012_fire);
        state = st_fire;
        timer_fire = time_fire;
    }
}

st_fire = function() {
    act_move();
    timer_fire -= 1*obs_microgame.spd*sy.dt;
    if (timer_fire < 0) {
        state = st_idle;
    }
}

st_hit = function() {
    xsp = lerp(xsp, 0, .01*sy.dt);
    ysp = lerp(ysp, 6, .1*sy.dt);
    x += xsp;
    y += ysp;
    image_angle -= 5*sy.dt;
    timer_hit -= 1*sy.dt;
    if (timer_hit < 0) {
        obs_microgame.result = MGR_LOSE;
        obs_microgame.time = -1;
    }
}

state = st_idle;