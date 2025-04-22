load_microstage = -1;
pause = false;

level = 0;
life_init = 4;
life = life_init;
spd = 1;
difficulty = 0;
microgame = 0;
micro_str = "";
micro_result = MGR_UNDECIDED;
micro_playstyle = 0;
micro_playlist_file = json_parse(file_read_all_text($"{ROOT_DIR}/PlaylistData/microstage00.rpl"));
micro_playlist_init = [];
micro_playlist_len = array_length(micro_playlist_init);
micro_playlist = array_shuffle(micro_playlist_init);
playlist_ind = 0;

seq_microstage = -1;
seq_micronum = -1;
seq_microprep = -1;
seq_microlife = -1;
seq_micropause = -1;
seq_micropause_exit = -1;
seq_results_fade = -1;
seq_results = -1;
seqinst_results = -1;
seq_micropause_prompt = -1;

init_playlist = function() {
    
    micro_playlist_init = micro_playlist_file.microlist;
    micro_playlist_len = array_length(micro_playlist_init) + 1;
    micro_playlist = array_shuffle(micro_playlist_init);
    array_push(micro_playlist, micro_playlist_file.boss);
    playlist_ind = 0;
}

music = audio_play_sound(snm_nightamb,0,true);

time_microwait = 60;
timer_microwait = time_microwait;
time_microresult = 60;
timer_microresult = time_microresult;
time_gameover_wait = 180;
timer_gameover_wait = time_gameover_wait;

st_preinit = function() {
    room_goto(rmz_microstage);
    state = st_init;
}

st_init = function() {
    life = life_init;
    level = 0;
    micro_result = MGR_UNDECIDED;
    spd = 1;
    difficulty = 0;
    
    timer_gameover_wait = time_gameover_wait;
    timer_microwait = time_microwait;
    timer_microresult = time_microresult;
    layer_sequence_destroy(seq_microstage);
    layer_sequence_destroy(seq_micronum);
    layer_sequence_destroy(seq_microprep);
    layer_sequence_destroy(seq_microlife);
    layer_sequence_destroy(seq_results);
    layer_sequence_destroy(seq_results_fade);
    if (!layer_sequence_exists(layer, seq_micropause_prompt)) {
        seq_micropause_prompt = layer_sequence_create(layer, 0,0, sql_pause_prompt);
    }
    init_playlist();
    
    texturegroup_load("microstage00", true);
    if (texturegroup_get_status("microstage00") == texturegroup_status_fetched) || (os_get_config() == "NewConfig1"){
        seq_microstage = layer_sequence_create(layer,0,0,sqb_microstage);
        var _reslife = asset_get_index($"sql_microstage_life_{life}");
        if (sequence_exists(_reslife)) {
            seq_micronum = layer_sequence_create(layer,0,0,sql_microstage_num);
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
    microgame = 18;
    //microgame = choose(1,2,3,4,5,6,7,8,9,10,11);
    
    //if (playlist_ind >= micro_playlist_len) {
        //init_playlist();
    //}
    //microgame = micro_playlist[playlist_ind].index;
    //micro_playstyle = micro_playlist[playlist_ind].cont_type;
    //playlist_ind++;

    
    micro_str = format_int(microgame,3,0);
    texturegroup_load($"mg{micro_str}");
    
    state = st_microwait;
}

st_microreturn = function() {
    if (!layer_sequence_exists(layer, seq_micropause_prompt)) {
        seq_micropause_prompt = layer_sequence_create(layer, 0,0, sql_pause_prompt);
    }
    layer_sequence_headpos(seq_micropause_prompt,25);
    seq_microstage = layer_sequence_create(layer,0,0,sqb_microstage);
    var _reslife = asset_get_index($"sql_microstage_life_{life}");
    if (sequence_exists(_reslife)) {
        seq_micronum = layer_sequence_create(layer,0,0,sql_microstage_num);
        seq_microlife = layer_sequence_create(layer, 0, 0, _reslife);
    }
    if (micro_result == MGR_WIN) {
        level++;
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
        if (life < 1) {
            state = st_gameover_lose;
            audio_play_sound(snj_lose,0,0);
        } else state = st_microinit;
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
        layer_sequence_destroy(seq_micropause_prompt);
        layer_sequence_destroy(seq_microstage);
        layer_sequence_destroy(seq_microprep);
        layer_sequence_destroy(seq_microlife);
        layer_sequence_destroy(seq_micronum);
        state = st_microstart;
    }
}

st_microstart = function() {
    seq_microprep = layer_sequence_create(layer, 0, 0, sql_microprep);
    layer_sequence_headpos(seq_microprep,30);
    if (!layer_sequence_exists(layer, seq_micropause_prompt)) {
        seq_micropause_prompt = layer_sequence_create(layer, 0,0, sql_pause_prompt);
    }
    layer_sequence_headpos(seq_micropause_prompt,25);
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


st_gameover_lose = function() {
    pause = false;
    if (layer_sequence_exists(layer,seq_micropause_prompt)) {
        layer_sequence_destroy(seq_micropause_prompt);
    }
    timer_gameover_wait -= 1*sy.dt;
    if (timer_gameover_wait < 0) {
        seq_results_fade = layer_sequence_create(layer,0,0,sql_microstage_result_fade);
        layer_sequence_destroy(seq_micronum);
        state = st_gameover_results_fade;
    }
}

st_gameover_results_fade = function() {
    pause = false;
    if (layer_sequence_is_finished(seq_results_fade)) {
        seq_results = layer_sequence_create("UI_TOP",0,0,sql_microstage_result);
        state = st_gameover_results_menu_init;
    }
}

st_gameover_results_menu_init = function() {
    pause = false;
    if (layer_sequence_exists("UI_TOP", seq_results)) {
        state = st_gameover_results;
    }
}

st_gameover_results = function() {
    pause = false;
    window_mouse_set_locked(false);
}

act_restart = function() {
    state = st_init;
}

state = st_preinit;