// Inherit the parent event
event_inherited();

snip_cooldown = 10/spd;
if (nightmare) {
    layer_background_sprite(layer_background_get_id("Background"), spb_mg011_bg_nightmare);
    snip_cooldown = 5/spd;
}
seq_scissors = layer_sequence_create(layer,0,0,sqr_mg011_scissors);
seq_win = -1;
snip_timer = snip_cooldown;
left = instance_number(obj_mg011_leaf);

if (!nightmare) {
    var _leafcount = instance_number(obj_mg011_leaf);
    var _leaves = [];
    var _trimleaves = irandom_range(2,4);
    for (var i = 0; i < _leafcount; i++) {
        array_push(_leaves, instance_find(obj_mg011_leaf, i));
    }
    _leaves = array_shuffle(_leaves);
    for (var i = 0; i < _trimleaves; i++) {
        instance_destroy(_leaves[i]);
        left--;
    }
}

layer_sequence_speedscale(seq_scissors, spd+(1.25*nightmare));



st_idle = function() {
    if (mouse_check_button_pressed(mb_left)) {
        if (instance_exists(obj_mg011_scissors)) {
            var _inst = collision_point(obj_mg011_scissors.x,obj_mg011_scissors.y,obj_mg011_leaf,false,true)
            if (instance_exists(_inst)) {
                _inst.state = _inst.st_cut;
                left--;
            }
            state = st_snip;
            obj_mg011_scissors.image_index = 1;
        }
    }
}

st_snip = function() {
    snip_timer -= 1*sy.dt;
    if (snip_timer < 0) {
        snip_timer = snip_cooldown;
        state = st_idle;
        obj_mg011_scissors.image_index = 0;
    }
}

st_finish = function() {
    
}


state = st_idle;