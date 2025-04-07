// Inherit the parent event
event_inherited();
for (var i = 0; i < 3 + floor((obs_microsys.difficulty * random_range(1,3))); i++) {
    var _inst = instance_create_layer(irandom_range(256,room_width-320),irandom_range(128,room_height-128),layer,obj_mg002_window);
    _inst.ad_type = i;
    _inst.image_xscale = random_range(2,4.5);
    _inst.image_yscale = random_range(1.5,3);
}
window_hovered = noone;
//st_dragging = function() {
    //if (instance_exists(window_hovered) && mouse_check_button(mb_left)) {
        //window_hovered.x = obv_3dcam.cursor_x;
        //window_hovered.y = obv_3dcam.cursor_y;
    //} else {
        //window_hovered = noone;
        //state = st_idle;
    //}
//}
//
//st_idle = function() {
    //var _hover = 
//}