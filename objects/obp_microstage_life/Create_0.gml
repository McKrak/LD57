xsp = random_range(-2,2);
ysp = random_range(-12, -4);
xoff = 0;
yoff = 0;
ang = 0;
//if (instance_exists(obs_microsys)) {
    //if (obs_microsys.life < instance_number(obp_microstage_life)) && (obs_microsys.micro_result != MGR_LOSE) {
        //
    //} else if (obs_microsys.life < instance_number(obp_microstage_life)-1)  {
        //instance_destroy();
    //}
//}

kill = function() {
    state = st_kill;
}

st_kill = function() {
    xsp = lerp(xsp, 0, .01*sy.dt);
    ysp = lerp(ysp, 5, .035*sy.dt);
    xoff += xsp;
    yoff += ysp;
    ang += 2*sy.dt;
    
    if yoff > 96 {
        instance_destroy();
    }
}

st_idle = function() {
    
}

state = st_idle;