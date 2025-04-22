// Inherit the parent event
event_inherited();
seq_announce = -1;
seq_arrow = -1;
ele_arrow_u = noone;
ele_arrow_l = noone;
ele_arrow_r = noone;
ele_arrow_d = noone;
inst_arrow_last = noone;

cat_move = 0;
cat_pattern = [];
monke_pattern = [];
time_cat_move = 45;
timer_cat_move = time_cat_move;


st_wait = function() {
    state = st_cats_turn;
}


st_cats_turn = function() {
    for (var i = 0; i < 4; i++) {
        array_push(cat_pattern,irandom_range(0,3));
    }
    if (!layer_sequence_exists("UI",seq_arrow)) {
        seq_arrow = layer_sequence_create("UI",obj_mg018_cat.x-32,obj_mg018_cat.y-96,sql_mg018_arrow);
    }
    state = st_cat_move;
}

st_cat_move = function() {
    timer_cat_move-=1*sy.dt;
    if (timer_cat_move < 0) {
        timer_cat_move = time_cat_move;
        if (cat_move < array_length(cat_pattern)) { 
            var _move = cat_pattern[cat_move];
            inst_arrow_last = instance_find(obu_mg018_arrow,_move);
            if (instance_exists(inst_arrow_last)) {
                inst_arrow_last.image_index = 1;
            }
            if (instance_exists(obj_mg018_cat)) {
                obj_mg018_cat.sprite_index = spr_mg018_cat_move;
                obj_mg018_cat.image_index = _move;
            }
        } else {
            layer_sequence_destroy(seq_arrow);
            if (instance_exists(obj_mg018_cat)) {
                obj_mg018_cat.sprite_index = spr_mg018_cat_idle;
                obj_mg018_cat.image_index = 0;
            }
            if (!layer_sequence_exists("UI", seq_announce)) {
                seq_announce = layer_sequence_create("UI",0,0,sql_mg018_announce);
            }
            state = st_monke_move;
        }
        cat_move++;
    } else if (timer_cat_move < 10) {
        if (instance_exists(inst_arrow_last)) {
            inst_arrow_last.image_index = 0;
            inst_arrow_last = noone;
        }
        if (instance_exists(obj_mg018_cat)) {
            obj_mg018_cat.sprite_index = spr_mg018_cat_idle;
            obj_mg018_cat.image_index = 0;
        }
    }
}

st_monke_move = function() {
    if (!layer_sequence_exists("UI",seq_arrow)) {
        seq_arrow = layer_sequence_create("UI",obj_mg018_monke.x+32,obj_mg018_monke.y-96,sql_mg018_arrow);
    }
}

state = st_wait;