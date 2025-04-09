// Inherit the parent event
event_inherited();

if (nightmare) {
    layer_background_index(layer_background_get_id("Background"), 1);
    layer_set_visible("EF_NIGHTMARE", true);
}

quote = "___ ____ ___ ____ ________ ____, ____ __ ___ ____ _____!! >:(";
displayquote = string_replace_all(quote, "_", " ");
target = "thefilehasbeentamperedwiththisisallyourfault";
original = "the file has been tampered with, this is all your fault!! >:(";
prompt = "";
promptkey = "";
typepos = 0;
targetpos = 0;
targetkey = "?";

seq_typewriter = -1;
seq_result = -1;




try {
    var _quotesdir = "quotes";
    if (nightmare) _quotesdir = "nquotes";
    var _quotefile = file_read_all_text($"{ROOT_DIR}/MicroGame/mg010/quotes.rpl");
    var _quotejson = json_parse(_quotefile);
    var _quotenum = array_length(_quotejson[$ _quotesdir]);
    var _chosenquote = irandom_range(0,_quotenum-1);
    
    quote = _quotejson[$ _quotesdir][_chosenquote].text;
    displayquote = string_replace_all(quote, "_", " ");
    target = _quotejson[$ _quotesdir][_chosenquote].redact;
    original = _quotejson[$ _quotesdir][_chosenquote].fulltext;
} catch (_err) {
    print(_err);
}

print(typepos);
targetkey = string_char_at(target,++targetpos);
typepos = string_pos_ext(targetkey,original,typepos);



st_init = function() {
    seq_typewriter = layer_sequence_create(layer, 320,180,squ_typewriter);
    //seqinst_typewriter = layer_sequence_get_instance(seq_typewriter);
    state = st_play;
}

st_setupkeys = function() {
    //var _keys = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
    //for (var i = 0; i < array_length(_keys); i++) {
            //var _track = sequence_track_get(seqinst_typewriter.activeTracks, _keys[i]);
            //var _inst = _track.instanceID;
            //_inst.key = _keys[i];
        //}
    state = st_play;
}

st_play = function() {
    if (instance_exists(obv_3dcam)) {
        var _inst = collision_point(obv_3dcam.cursor_x,obv_3dcam.cursor_y,obj_typewriter_key,true,true);
        if (instance_exists(_inst)) {
            if (mouse_check_button_pressed(mb_left)) {
                audio_play_sound(snf_typewriter,0,0);
                prompt += _inst.key;
                quote = string_replace(quote, "_", string(_inst.key));
                displayquote = string_replace_all(quote, "_", " ");
                if (_inst.key == targetkey) {
                    targetkey = string_char_at(target,++targetpos);
                    typepos = string_pos_ext(targetkey,original,typepos+1);
                    print(targetkey);
                    if (prompt == target) && (result == MGR_UNDECIDED) {
                        result = MGR_WIN
                        audio_play_sound(snf_typebell,0,0);
                        seq_result = layer_sequence_create("Result", 0,0,squ_result);
                        state = st_finish;
                    }
                } else if (result == MGR_UNDECIDED) {
                    targetkey = string_char_at(target,++targetpos);
                    typepos = string_pos_ext(targetkey,original,typepos+1);
                    result = MGR_LOSE;
                    state = st_finish;
                }
            }
        }
    }
}

st_finish = function() {
    
}

state = st_init;