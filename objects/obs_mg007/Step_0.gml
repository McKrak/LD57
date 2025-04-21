if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        if (instance_exists(obv_3dcam)) {
            obv_3dcam.xto = obj_mg007_guide.x;
            obv_3dcam.yto = obj_mg007_guide.y;
            obv_3dcam.x = obj_mg007_guide.x;
            obv_3dcam.y = obj_mg007_guide.y + 200;
        }
    }
}

// Inherit the parent event
event_inherited();

