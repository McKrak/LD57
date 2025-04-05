	var _pathdata = host.path;
	if (is_array(host.path)) {
		if (host.type == NODE_SPACE) {
			for (var i = 0; i < array_length(host.path); i++) {
				for (var j = 1; j < array_length(host.path[i]); j++)
				{
					var _target = inst_find(d_obi_boardspace,"index",host.path[i][j])
					if (instance_exists(_target)) {
						draw_arrow(x,y,_target.x,_target.y,32);
					}
				}
			}
		} else if (host.type == NODE_PJ_SPACE) {
			for (var i = 0; i < array_length(host.path); i++) {
				if ((host.path[i]) != -1) {
					var _dest = host.host.content[$ host.path[i]];
					if (_dest != undefined) {
						var _dir = point_direction(x,y,_dest.x,_dest.y);
						var _dist = point_distance(x,y,_dest.x,_dest.y)
						draw_sprite_ext(d_spu_spacearrow,0,x,y,_dist/sprite_get_width(d_spu_spacearrow),1,_dir,c_white,1);
					}
				}
			}
		}
	}

if (instance_exists(obv_3dcam)) {
	if (obv_3dcam.is_orthographic) {
		draw_self();
		mdl.do_draw = false;
	} else {
		if (instance_exists(mdl)) {
			mdl.do_draw = true;
		}
	}
}
