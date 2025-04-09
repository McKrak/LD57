time_appear = 240;
timer_appear = time_appear;
time_attack = 15;
timer_attack = time_attack;
light_offset = -304;
hp = 25;
boom_size = 0;
boom_opacity = 1;
time_hurt = 5;
timer_hurt = 0;
ytarget = random_range(obs_mg012_bounds.bbox_top-light_offset,obs_mg012_bounds.bbox_bottom-light_offset);

st_waiting = function() {
    
}

st_appear = function() {
    timer_appear -= 1*sy.dt;
    y = lerp(y,360,.05*sy.dt);
    if (timer_appear < 0) {
        timer_appear = time_appear/4;
        state = st_attack_prepare;
    }
}

st_attack_prepare = function() {
    timer_appear -= 1*sy.dt;
    y = lerp(y, ytarget,.1);
    if (timer_appear < 0) {
        ytarget = random_range(obs_mg012_bounds.bbox_top-light_offset,obs_mg012_bounds.bbox_bottom-light_offset);
        timer_appear = time_appear/8;
        state = st_attack;
    }
}

st_attack = function() {
    timer_attack -= 1*sy.dt;
    if (timer_attack < 0) {
        timer_attack = time_attack;
        instance_create_layer(x-32,y+light_offset,"Bullets",obj_mg012_bullet);
        state = st_attack_prepare;
    }
}

st_dead = function() {
    boom_opacity = lerp(boom_opacity, 0, .05*sy.dt);
    boom_size = lerp(boom_size, 1, .1*sy.dt);
    image_alpha = 0;
}

state = st_waiting;