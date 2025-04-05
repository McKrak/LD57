if instance_exists(follow) && (follow != 14) { 
	if (follows_index) {
		for (var i = 0; i < instance_number(follow); i++;) {
			var current_follow = instance_find(follow,i);
			if (current_follow.index == view) {
				follow = current_follow;
			}
		}
	}
	
	if follows_x hori_to = follow.x;
	if follows_y vert_to = follow.y;
}

x += (hori_to - x) / lag_speed;
y += (vert_to - y) / lag_speed;


camw = w_to*max(1,global.res_ratio_width);
camh = h_to*max(1,global.res_ratio_height);

switch (x_align) {
	case 0: x_pos = x; break;
	case 1: x_pos = x-camw/2; break;
	case 2: x_pos = x-camw; break;
}
switch (y_align) {
	case 0: y_pos = y; break;
	case 1: y_pos = y-camh/2; break;
	case 2: y_pos = y-camh; break;
}
//camera_set_view_pos(view_camera[view],min(max(0,x-camw/2),room_width-camw),min(max(0,y-camh/2),room_height-camh));

camera_set_view_pos(view_camera[view],x_pos,y_pos);

camera_set_view_size(view_camera[view],camw,camh);