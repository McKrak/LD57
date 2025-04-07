// Inherit the parent event
event_inherited();

if (nightmare) {
    layer_background_index(layer_background_get_id("Background"), 1);
}

seq_handshake_intro = layer_sequence_create(layer,0,0,squ_handshake_intro);
fx_blur = layer_get_fx("EF_BLUR");
blurlevel = 0;
if (fx_blur != -1) {
    fx_set_parameter(fx_blur,"g_RecursiveBlurRadius",0);
}


st_intro = function() {
    if (layer_sequence_get_headpos(seq_handshake_intro) > 30) {
        state = st_zoomin;
    }
}

st_zoomin = function() {
    obv_3dcam.ortho_zoom = lerp(obv_3dcam.ortho_zoom, 5.5, .1);
    //obv_3dcam.align_x = lerp(obv_3dcam.align_x,1,.1);
    obv_3dcam.x = lerp(obv_3dcam.x, 340, .15);
    obv_3dcam.y = lerp(obv_3dcam.y, 280,.15);
    if (fx_blur != -1) {
        blurlevel = lerp(blurlevel, 16,.1);
        fx_set_parameter(fx_blur,"g_RecursiveBlurRadius",blurlevel);
    }
    if (obv_3dcam.ortho_zoom > 5.4) {
        state = st_play; 
        instance_create_layer(420,280,layer,obj_mg003_monke_hand);
        instance_create_layer(256,280,layer,obj_mg003_fuzzy_hand);
        layer_sequence_destroy(seq_handshake_intro);
    }
    
}

st_play = function() {
    if (result == MGR_LOSE) {
        state = st_lose;
        if (audio_exists(playingsound)) {
            audio_stop_sound(playingsound);
        }
        audio_play_sound(snf_chord,0,false);
    }
}

st_lose = function() {
    obv_3dcam.ortho_zoom = 1;
    obv_3dcam.x = 0;
    obv_3dcam.y = 0;
    obv_3dcam.align_x = 0;
    obv_3dcam.align_y = 0;
    state = st_funnylose;
}

st_funnylose = function() {
    
}

state = st_intro;