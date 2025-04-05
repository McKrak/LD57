var _pathdata = host.dest;
if (is_array(host.dest)) {
    if (host.type == NODE_SPACE) {
        for (var i = 0; i < array_length(host.dest); i++) {
            for (var j = 1; j < array_length(host.dest[i]); j++)
            {
                var _target = inst_find(d_obi_boardspace,"index",host.dest[i][j])
                if (instance_exists(_target)) {
                    draw_arrow(x,y,_target.x,_target.y,32);
                }
            }
        }
    } else if (host.type == NODE_PJ_SPACE) {
        for (var i = 0; i < array_length(dest); i++) {
            if (dest[i] != -1) {
                var _dest = dest[i];
                if (_dest != undefined) && (is_struct(_dest)) {
                    if (_dest[$ "type"] == NODE_PJ_SPACE) {
                        var _inst = _dest[$ "inst"];
                        if (instance_exists(_inst)) {
                            var _dir = point_direction(x,y,_inst.x,_inst.y);
                            var _dist = point_distance(x,y,_inst.x,_inst.y);
                            if (!d_sy.picturemode) || (image_index != 13) {
                                draw_sprite_ext(d_spu_spacearrow,0,x,y,_dist/sprite_get_width(d_spu_spacearrow),1,_dir,c_white,0.65);
                            }
                        }
                    }
                }
            }
        }
    }
}


if (!d_sy.picturemode) {
    draw_self();
}


//if (instance_exists(obv_3dcam)) {
	//if (obv_3dcam.is_orthographic) {
		//draw_self();
		//mdl.do_draw = false;
	//} else {
		//if (instance_exists(mdl)) {
			//mdl.do_draw = true;
		//}
	//}
//}
