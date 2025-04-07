// Inherit the parent event
event_inherited();

holding_tooth = noone;


st_init = function() {
    seq_swap = layer_sequence_create("Person", 0,0,squ_mg008_swap);
    state = st_fillteeth;
}

st_fillteeth = function() {
    var _tootharray = [];
    for (var i = 0; i < instance_number(obj_mg008_toothtarget); i++) {
        var _inst = instance_find(obj_mg008_toothtarget,i);
        _inst.index = i;
        array_push(_tootharray, _inst);
    }
    _tootharray = array_shuffle(_tootharray);
    var _fillteeth = 5;
    for (var i = 0; i < array_length(_tootharray); i++) {
        var _inst = _tootharray[i];
        if (i < _fillteeth) {
            var _newinst = instance_create_layer(_inst.x,_inst.y,"Person",obj_mg008_tooth);
            _newinst.image_xscale= _inst.image_xscale;
            _newinst.image_yscale= _inst.image_yscale;
            _newinst.image_angle= _inst.image_angle;
            _newinst.index = _inst.index;
            _newinst.attached = true;
            instance_destroy(_inst);
        } else {
            var _newinst = instance_create_layer(170+(48*_inst.index),300,"Grabbable",obj_mg008_tooth);
            _newinst.image_xscale= _inst.image_xscale;
            _newinst.image_yscale= _inst.image_yscale;
            _newinst.image_angle= _inst.image_angle;
            _newinst.index = _inst.index;
            _newinst.attached = false;
        }
        
    }

    state = st_play;
}

st_play = function() {
    var _hover = collision_point(obu_cursor.x,obu_cursor.y, obj_mg008_tooth,false,true);
    if (instance_exists(_hover)) {
        if (mouse_check_button(mb_left)) && (!_hover.attached) {
            holding_tooth = _hover;
            state = st_holding;
        }
    }
    if (instance_number(obj_mg008_toothtarget) == 0) {
        if (result == MGR_UNDECIDED) result = MGR_WIN;
    }
}

st_holding = function() {
    holding_tooth.x = obu_cursor.x;
    holding_tooth.y = obu_cursor.y;
    if (!mouse_check_button(mb_left)) {
        var _hover = collision_point(obu_cursor.x,obu_cursor.y, obj_mg008_toothtarget,false,true);
        if (instance_exists(_hover)) {
            if (_hover.index == holding_tooth.index) {
                print("GURT");
                holding_tooth.attached = true;
                holding_tooth.x = _hover.x;
                holding_tooth.y = _hover.y;
                holding_tooth.layer = layer_get_id("Person_Teeth");
                instance_destroy(_hover);
            }
        }
        holding_tooth = noone;
        state = st_play;
    }
}

st_finish = function() {
    
}

state = st_init;
