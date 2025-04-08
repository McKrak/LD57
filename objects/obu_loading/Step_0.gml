image_angle-=5;
if (texturegroup_get_status(global.load) == texturegroup_status_fetched) {
    room_goto(global.toroom);
}