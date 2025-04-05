load_microstage = -1;
pause = false;

level = 0;
life = 4;
spd = 1;
difficulty = 0;
microgame = 0;
micro_result = MGR_UNDECIDED;

seq_microstage = -1;
seq_microprep = -1;

timer_microwait = 30;
timer_microresult = 60;
timer_microgame = 300;

st_preinit = function() {
    room_goto(rmz_microstage);
    state = st_init;
}

st_init = function() {
    texturegroup_load("microstage00", true);
    if (texturegroup_get_status("microstage00") == texturegroup_status_fetched) {
        state = st_intro;
        seq_microstage = layer_sequence_create(layer,0,0,sqb_microstage);
    }
}

st_intro = function() {
    state = st_microwait;
}

st_microreturn = function() {
    seq_microstage = layer_sequence_create(layer,0,0,sqb_microstage);
    state = st_microresult;
}

st_microresult = function() {
    timer_microresult -= 1*sy.dt;
    if (timer_microresult < 0) {
        timer_microresult = 60;
        state = st_microwait;
    }
}

st_microwait = function () {
    microgame = 3;//irandom_range(0,2);
    texturegroup_load($"mg{format_int(microgame,3,0)}");
    timer_microwait -= 1*sy.dt;
    if (timer_microwait < 0) {
        timer_microwait = 30;
        seq_microprep = layer_sequence_create(layer, 0, 0, sql_microprep);
        state = st_microprep;
    }
}

st_microprep = function() {
    if (layer_sequence_get_headpos(seq_microprep) > 30) {
        room_goto(asset_get_index($"rmz_mg{format_int(microgame,3,0)}"));
        layer_sequence_destroy(seq_microstage);
        layer_sequence_destroy(seq_microprep);
        state = st_microstart;
    }
}

st_microstart = function() {
    seq_microprep = layer_sequence_create(layer, 0, 0, sql_microprep);
    layer_sequence_headpos(seq_microprep,30);
    state = st_microplay;
}

st_microplay = function() {
    if (layer_sequence_exists(layer,seq_microprep)) {
        if (layer_sequence_is_finished(seq_microprep)) {
            layer_sequence_destroy(seq_microprep);
        }  
    }
    //timer_microgame -= 1*sy.dt;
    //if (timer_microgame < 0) {
        //timer_microgame = 300;
        //state = st_microfinish;
    //}
}

st_microfinish = function() {
    room_goto(rmz_microstage);
    state = st_microreturn;
}

state = st_preinit;