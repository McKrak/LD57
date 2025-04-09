// Inherit the parent event
event_inherited();
time_bullet_spawn = 120;
time_boss_clear = 180;
timer_boss_clear = time_boss_clear;
timer_bullet_spawn = time_bullet_spawn;
spawnnum = [1,2,3,4];

seq_statue = layer_sequence_create("BGInst",480,280,squ_statue_liftoff);
layer_sequence_pause(seq_statue);


st_preboss = function() {
    timer_bullet_spawn -= 1*spd*sy.dt;
    if (timer_bullet_spawn < 0) {
        var _spawners = [];
        for (var i = 0; i < instance_number(obs_mg012_bulletspawner); i++) {
            var _inst = instance_find(obs_mg012_bulletspawner,i);
            if (instance_exists(_inst)) {
                array_push(_spawners, _inst);
            }
        }
        _spawners = array_shuffle(_spawners);
        var _stage = floor(240/time_bullet_spawn);
        for (var i = 0; i < _stage; i++) {
            instance_create_layer(_spawners[i].x,_spawners[i].y,"Bullets",obj_mg012_wall);
        }
        time_bullet_spawn -= 10;
        timer_bullet_spawn = time_bullet_spawn;
        if (time_bullet_spawn < 60) {
            state = st_boss_init;
        }
    }
}

st_boss_init = function() {
    if (layer_sequence_is_paused(seq_statue)) {
        layer_sequence_play(seq_statue);
    }
    if (layer_sequence_is_finished(seq_statue)) {
        layer_sequence_destroy(seq_statue);
        state = st_boss_arrive;
    }
}

st_boss_arrive = function() {
    if (instance_exists(obj_mg012_statue_boss)) {
        obj_mg012_statue_boss.state = obj_mg012_statue_boss.st_appear;
    }
    state = st_boss_fight;
}

st_boss_fight = function() {
    timer_bullet_spawn -= 1*sy.dt;
    if (timer_bullet_spawn < 0) {
        var _spawners = [];
        for (var i = 0; i < instance_number(obs_mg012_bulletspawner); i++) {
            var _inst = instance_find(obs_mg012_bulletspawner,i);
            if (instance_exists(_inst)) {
                array_push(_spawners, _inst);
            }
        }
        _spawners = array_shuffle(_spawners);
        var _stage = floor(2);
        for (var i = 0; i < _stage; i++) {
            instance_create_layer(_spawners[i].x,_spawners[i].y,"Bullets",obj_mg012_wall);
        }
        timer_bullet_spawn = 120;
    }
}

st_boss_clear = function() {
    if (audio_exists(playingsound)) {
        audio_stop_sound(playingsound);
    }
    timer_boss_clear -= 1*sy.dt;
    if (timer_boss_clear < 0) {
        time = -1;
    }
}

state = st_preboss;