// Inherit the parent event
event_inherited();
seq_handshake_intro = layer_sequence_create(layer,0,0,squ_handshake_intro);

st_intro = function() {
    if (layer_sequence_get_headpos(seq_handshake_intro) > 30) {
        state = st_zoomin;
    }
}

st_zoomin = function() {
    obv_3dcam.ortho_zoom = lerp(obv_3dcam.ortho_zoom, 5, .1);
    //obv_3dcam.align_x = lerp(obv_3dcam.align_x,1,.1);
    obv_3dcam.x = lerp(obv_3dcam.x, 340, .1);
    obv_3dcam.y = lerp(obv_3dcam.y, 320,.1);
    if (obv_3dcam.ortho_zoom > 4.9) {
        state = st_play;
        layer_sequence_destroy(seq_handshake_intro);
    }
}

st_play = function() {
    
}

state = st_intro;