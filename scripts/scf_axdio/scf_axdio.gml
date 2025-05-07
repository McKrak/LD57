global.audio_groups = {};
{
    var _axgrp = undefined;
    var i = 0;
    _axgrp = audio_group_name(i);
    while (_axgrp != "<undefined>") {
        struct_set(global.audio_groups,_axgrp,i);
        _axgrp = audio_group_name(++i);
    }
}

function audiogroup_load(axgrp) {
    if (is_string(axgrp)) {
        var _axind = global.audio_groups[$ axgrp];
        if (is_real(_axind)) {
            audio_group_load(_axind);
        }
    } else {
        audio_group_load(axgrp);
    }
    
}

function audiogroup_unload(axgrp) {
    if (is_string(axgrp)) {
        var _axind = global.audio_groups[$ axgrp];
        if (is_real(_axind)) {
            audio_group_unload(_axind);
        }
    } else {
        audio_group_unload(axgrp);
    }

}