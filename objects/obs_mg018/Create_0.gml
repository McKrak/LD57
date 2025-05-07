// Inherit the parent event
event_inherited();
seq_announce = -1;
seq_arrow = -1;
seq_winbg = -1;
ele_arrow_u = noone;
ele_arrow_l = noone;
ele_arrow_r = noone;
ele_arrow_d = noone;
inst_arrow_last = noone;

cat_moves = 4;
if (nightmare) cat_moves = 6;
cat_move = 0;
cat_pattern = [];
monke_pattern = [];
time_cat_move = 45;
timer_cat_move = time_cat_move;

ac_dance = animcurve_get_channel(acr_mg018_dance, "hmove");
f_hmove_cat = 1;
f_hmove_monke = 1;
dance_squish = 1;
dance_squish_monke = 1;


st_wait = function() {
    state = st_cats_turn;
}


st_cats_turn = function() {
    for (var i = 0; i < cat_moves; i++) {
        array_push(cat_pattern,irandom_range(0,3));
    }
    if (!layer_sequence_exists("UI",seq_arrow)) {
        seq_arrow = layer_sequence_create("UI",obj_mg018_cat.x,obj_mg018_cat.y-96,sql_mg018_arrow);
    }
    state = st_cat_move;
}

st_cat_move = function() {
    f_hmove_cat += .05*sy.dt;
    dance_squish = animcurve_channel_evaluate(ac_dance,f_hmove_cat);
    timer_cat_move-=1*sy.dt;
    if (timer_cat_move < 0) {
        f_hmove_cat = 0;
        timer_cat_move = nightmare? 30 : time_cat_move;
        if (cat_move < array_length(cat_pattern)) { 
            var _move = cat_pattern[cat_move];
            sfx_play(asset_get_index($"axf_mg018_hit{_move}"));
            inst_arrow_last = instance_find(obu_mg018_arrow,_move);
            if (instance_exists(inst_arrow_last)) {
                inst_arrow_last.image_index = 1;
            }
            if (instance_exists(obj_mg018_cat)) {
                if (!nightmare) obj_mg018_cat.sprite_index = spr_mg018_cat_move;
                    else obj_mg018_cat.sprite_index = spr_mg018_cat_moven;
                obj_mg018_cat.image_index = _move;
            }
        } else {
            layer_sequence_destroy(seq_arrow);
            if (instance_exists(obj_mg018_cat)) {
                if (!nightmare) obj_mg018_cat.sprite_index = spr_mg018_cat_idle;
                    else obj_mg018_cat.sprite_index = spr_mg018_cat_idlen;
                obj_mg018_cat.image_index = 0;
            }
            if (!layer_sequence_exists("SYS", seq_announce)) {
                seq_announce = layer_sequence_create("SYS",0,0,sql_mg018_announce);
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
            if (!nightmare) obj_mg018_cat.sprite_index = spr_mg018_cat_move;
                else obj_mg018_cat.sprite_index = spr_mg018_cat_moven;
            obj_mg018_cat.image_index = 0;
        }
    }
}

st_monke_move = function() {
    if (!layer_sequence_exists("UI",seq_arrow)) {
        seq_arrow = layer_sequence_create("UI",obj_mg018_monke.x,obj_mg018_monke.y-96,sql_mg018_arrow);
    }
    if (f_hmove_monke < 1) {
        f_hmove_monke += .05*sy.dt;
        dance_squish_monke = animcurve_channel_evaluate(ac_dance,f_hmove_monke);
    }
}

st_lose = function() {
    
}

st_win = function() {
    if (f_hmove_cat < 1) {
        f_hmove_cat += .05*sy.dt;
        dance_squish = animcurve_channel_evaluate(ac_dance,f_hmove_cat);
    }

    if (f_hmove_monke < 1) {
        f_hmove_monke += .05*sy.dt;
        dance_squish_monke = animcurve_channel_evaluate(ac_dance,f_hmove_monke);
    }
    if (!layer_sequence_exists("WIN_BG",seq_winbg)) {
        seq_winbg = layer_sequence_create("WIN_BG",0,0,sqb_mg018_win);
    }
}

state = st_wait;