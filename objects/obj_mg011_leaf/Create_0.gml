if (instance_exists(obs_microgame)) {
    if (obs_microgame.nightmare) sprite_index = spr_mg011_leaf_nightmare;
}

xsp = random_range(-2,2);
ysp = random_range(-12, -4);

st_idle = function() {
    
}

st_cut = function() {
    image_index = 1;
    xsp = lerp(xsp, 0, .01*sy.dt);
    ysp = lerp(ysp, 6, .1*sy.dt);
    x += xsp;
    y += ysp;
    
    if y > 420 {
        instance_destroy();
    }
}

state = st_idle;