#define ext_shader_reset
array_pop(global.shader_stack);
var _last = array_last(global.shader_stack);
if (_last == undefined) shader_reset();
    else shader_set(_last);
return 0.0;