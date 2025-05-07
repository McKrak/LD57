image_xscale = .3334;
image_yscale = .3334;
dieangle = irandom_range(-45,45);
switch (type) {
    case 0:
        sprite_index = spr_mg016_broc;
    break;
    case 1:
        sprite_index = spr_mg016_carrot;
    break;
    case 2:
        sprite_index = spr_mg016_pea;
    break;
}
initx = x;

st_run = function() {
    if (x == 96) || (x == room_width-96) {
        dir = !dir;
    }
    if (dir == 1) {
        move_towards_point(room_width-96,y,spd*sy.dt);
    } else {
        move_towards_point(96,y,spd*sy.dt);
    }
    x = clamp(x,96,room_width-96);

    if (place_meeting(x,y,obj_mg016_fork)) {
        if (obj_mg016_fork.state = obj_mg016_fork.st_stab) {
            state = st_stabbed;
        }
    }
}

st_stabbed = function() {
    switch type {
        case 0:
            sprite_index = spr_mg016_broc_caught;
        break;
        case 1:
            sprite_index = spr_mg016_carrot_caught;
        break;
        case 2:
            sprite_index = spr_mg016_pea_caught;
        break;
    }
    image_angle = lerp(image_angle,dieangle,.2*sy.dt);
    y = obj_mg016_fork.y-32;
    x = obj_mg016_fork.x;
}

state = st_run;