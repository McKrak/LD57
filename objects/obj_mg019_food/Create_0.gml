if (instance_exists(obs_mg019)) {
    type = obs_mg019.type;
}
spr_face = spr_mg019_steak_face;
face_exp = 0;

switch(type) {
    case 0:
        sprite_index = spr_mg019_steak;
        spr_face = spr_mg019_steak_face;
    break;
    case 1:
        sprite_index = spr_mg019_orange;
        spr_face = spr_mg019_orange_face;
    break;
    case 2:
        sprite_index = spr_mg019_banana;
        spr_face = spr_mg019_banana_face;
    break;
}