function shader_push(shd = undefined) {
    array_push(global.shader_stack,shd);
    if (shd == undefined) {
        shader_reset();
    } else shader_set(shd);
}

function shader_pop() {
    array_pop(global.shader_stack);
    var _last = array_last(global.shader_stack);
    if (_last == undefined) shader_reset();
        else shader_set(_last);
}