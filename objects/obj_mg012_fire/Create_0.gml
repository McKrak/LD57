image_xscale = .15;
image_yscale = .15;

time_boom = 10;
timer_boom = time_boom;
boom_size = .15;

st_move = function() {
    x+=8*sy.dt;
    if x > 700 instance_destroy();
}

st_explode = function() {
    timer_boom -= 1*sy.dt;
    if (timer_boom < 0) {
        instance_destroy();
    }
}

state = st_move;