initx = x;
targetx = x+138;
textalpha = 1;
if (instance_exists(obs_mg015)) {
    if (obs_mg015.state = obs_mg015.st_dragging) {
        textalpha = lerp(textalpha,0,.1);
    } else {
        textalpha = lerp(textalpha,1,.1);
    }
}