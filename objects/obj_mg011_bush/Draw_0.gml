draw_self();
var _eyespr = 1;
if (instance_exists(obs_microgame)) {
    if obs_microgame.result == MGR_WIN _eyespr = 0;
}
draw_sprite_ext(eyeimage,_eyespr,x,y-96,image_xscale,image_yscale,image_angle,image_blend,image_alpha);