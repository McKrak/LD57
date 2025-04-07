load_microstage = -1;
pause = false;

level = 0;
life = 4;
spd = 1;
difficulty = 0;
microgame = 0;
micro_str = "";
micro_result = MGR_UNDECIDED;

seq_microstage = -1;
seq_microprep = -1;
seq_microlife = -1;
seq_micropause = -1;
seq_micropause_exit = -1;

music = audio_play_sound(snm_nightamb,0,true);


timer_microwait = 60;
timer_microresult = 60;
timer_microgame = 300;

st_preinit = function() {
    room_goto(rmz_microstage);
    state = st_init;
}

st_init = function() {
    texturegroup_load("microstage00", true);
    if (texturegroup_get_status("microstage00") == texturegroup_status_fetched) {
        seq_microstage = layer_sequence_create(layer,0,0,sqb_microstage);
        var _reslife = asset_get_index($"sql_microstage_life_{life}");
        if (sequence_exists(_reslife)) {
            seq_microlife = layer_sequence_create(layer, 0, 0, _reslife);
        }
        state = st_intro;
    }
}

st_intro = function() {
    
    state = st_microinit;
}

st_microinit = function() {
    //microgame = ++microgame mod 12;
    microgame = 6;
    //microgame = choose(1,2,3,4,5,6,7,8,9,10,11);
    micro_str = format_int(microgame,3,0);
    texturegroup_load($"mg{micro_str}");
    
    state = st_microwait;
}

st_microreturn = function() {
    seq_microstage = layer_sequence_create(layer,0,0,sqb_microstage);
    var _reslife = asset_get_index($"sql_microstage_life_{life}");
    if (sequence_exists(_reslife)) {
        seq_microlife = layer_sequence_create(layer, 0, 0, _reslife);
    }
    if (micro_result == MGR_WIN) {
        audio_play_sound(snj_microwin,0,false);
    } else {
        audio_play_sound(snj_microlose,0,false);
        life--;
    }
    state = st_microresult;
}

st_microresult = function() {
    timer_microresult -= 1*sy.dt;
    if (timer_microresult < 0) {
        if (micro_result == MGR_LOSE) {
            var _inst = instance_find(obp_microstage_life,instance_number(obp_microstage_life)-1);
            if (instance_exists(_inst)) {
                with (_inst) kill();
            }
        }
        timer_microresult = 60;
        state = st_microinit;
    }
}

st_microwait = function () {
    timer_microwait -= 1*sy.dt;
    if (timer_microwait < 0) {
        timer_microwait = 60;
        layer_sequence_destroy(seq_microstage);
        seq_microstage = layer_sequence_create(layer, 0, 0, sqb_microstage_prep);
        seq_microprep = layer_sequence_create(layer, 0, 0, sql_microprep);
        state = st_microprep;
    }
}

st_microprep = function() {
    if (layer_sequence_get_headpos(seq_microprep) > 20) {
        if (instance_exists(obv_3dcam)) {
            obv_3dcam.ortho_zoom = lerp(obv_3dcam.ortho_zoom, 5, .025*sy.dt);
        }
    }
    if (layer_sequence_get_headpos(seq_microprep) > 30) {
        obv_3dcam.ortho_zoom = 1;
        room_goto(asset_get_index($"rmz_mg{micro_str}"));
        layer_sequence_destroy(seq_microstage);
        layer_sequence_destroy(seq_microprep);
        layer_sequence_destroy(seq_microlife);
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
    audio_pause_sound(music);
    
    //timer_microgame -= 1*sy.dt;
    //if (timer_microgame < 0) {
        //timer_microgame = 300;
        //state = st_microfinish;
    //}
}

st_microfinish = function() {
    room_goto(rmz_microstage);
    texturegroup_unload($"mg{micro_str}");
    audio_resume_sound(music);
    state = st_microreturn;
}

state = st_preinit;