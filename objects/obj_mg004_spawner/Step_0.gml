if (!obs_microsys.pause) {
    if (ingredients_left > 0) {
        time -= 1*sy.dt;
        if (time < 0) {
            time = cooldown;
            var _spr = spr_mg004_bread;
            if (ingredients_left != 1) && (ingredients_left != times) {
                _spr = choose(spr_mg004_bacon,spr_mg004_cheese,spr_mg004_egg,spr_mg004_lettuce,spr_mg004_patty);
            }
            ingredients_left--;
            instance_create_layer(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),layer,obj_mg004_ingredient, {
                draw_spr: _spr,
                image_xscale: .2,
                image_yscale: .2
            });
        }
    }
}