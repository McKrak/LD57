if (state == st_move) {
    state = st_explode;
    with (instance_nearest(x,y,obj_mg012_wall)) {
        instance_destroy();
    }
}