if (instance_exists(d_obs_bdedit)) { 
	if (array_contains(d_obs_bdedit.selected,id)) {
		sel = true;
	} else {
		sel = false;
	}
}

if (x != data.x) 
|| (y != data.y) 
|| (z != data.z) 
|| (to_x != data.to_x)
|| (to_y != data.to_y)
|| (to_z != data.to_z)
|| (up_x != data.up_x)
|| (up_y != data.up_y)
|| (up_z != data.up_z)
{
	lit.SetPosition(new Vec3(x,y,z),new Vec3(to_x,to_y,to_z),new Vec3(up_x,up_y,up_z));
	data.x = x;
	data.y = y;
	data.z = z;
	data.to_x = to_x;
	data.to_y = to_y;
	data.to_z = to_z;
	data.up_x = up_x;
	data.up_y = up_y;
	data.up_z = up_z;
}

if (color != data.color)
|| (mask != data.spr_mask) {
	lit.SetColor(color,mask);
	data.color = color;
	data.spr_mask = mask;
}

if (size != data.size)
|| (quality != data.quality)
|| (light_power != data.light_power)
|| (is_orthographic != data.is_orthographic) {
	if (is_orthographic) {
		lit.SetAsDirectional(size,quality,light_power);
	} else {
		lit.SetAsSpot(size,quality,light_power);
	}
	
	data.size = size;
	data.quality = quality;
	data.light_power = light_power;
	data.is_orthographic = is_orthographic;
}