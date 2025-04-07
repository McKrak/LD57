// Inherit the parent event
event_inherited();

st_reload = function() {
    if (refreshes_required == 0) {
        result = MGR_LOSE;
    }
    obj_mg009_window_inside.image_index = 1;
    state = st_reloading;
}

st_reloading = function() {
    image_angle-=4*sy.dt;
}

st_error = function() {
    
}

st_permerror = function() {
    
}

st_reloaded = function() {
    refreshes_required--;
    if (refreshes_required == 0) {
        state = st_fixed;
        obj_mg009_window_inside.image_index = 2;
    } else if (refreshes_required < 0) {
        state = st_permerror;
        obj_mg009_window_inside.image_index = 0;
    } else {
        state = st_error;
        obj_mg009_window_inside.image_index = 0;
    }
}

st_fixed = function() {
    if (result == MGR_UNDECIDED) {
        result = MGR_WIN;
    }
}

st_secretlose = function() {
    if (state != st_permerror) {
        result = MGR_LOSE;
        instance_destroy(obj_mg009_refresh);
        instance_destroy(obj_mg009_topbar);
        instance_destroy(obj_mg009_window_inside);
    }
}

state = st_error;

refreshes_required = irandom_range(2,ceil(5/spd));
