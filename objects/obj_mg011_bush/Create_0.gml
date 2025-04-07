eyeimage = spr_mg011_face;

if (instance_exists(obs_microgame)) {
    if (obs_microgame.nightmare) {
        sprite_index = spr_mg011_bush_nightmare;
        eyeimage = spr_mg011_face_nightmare;
    }
}