holding = instance_create_layer(x+16,y-24,"Instances_Behind",choose(obj_mg020_boxb,obj_mg020_boxh,obj_mg020_boxs,obj_mg020_boxv));
holding.phy_active = false;

function throw_box() {
    if (instance_exists(holding)) { 
        with (holding) {
            phy_active = true;
            physics_apply_impulse(x+sprite_width*image_xscale/2-1,y-sprite_height*image_yscale/2-1,50,-35);
        }
    }
}
//with (_throw) physics_apply_impulse(x+sprite_width*image_xscale/2-1,y-sprite_height*image_yscale/2-1,50,-35);