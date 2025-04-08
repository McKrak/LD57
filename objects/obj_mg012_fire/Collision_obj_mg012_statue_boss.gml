
if (state == st_move) {
    with (obj_mg012_statue_boss) {
        obj_mg012_statue_boss.hp--;
        obj_mg012_statue_boss.timer_hurt = 5;
    }
    state = st_explode;
}
