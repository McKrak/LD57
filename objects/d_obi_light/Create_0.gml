nodetype = 3;
sel = false;

lit = Create_LightDirectional(size,quality,light_power,color,mask,
new Vec3(x,y,z),new Vec3(to_x,to_y,to_z),new Vec3(up_x,up_y,up_z));

data = {
	x: x,
	y: y,
	z: z,
	to_x: to_x,
	to_y: to_y,
	to_z: to_z,
	up_x: up_x,
	up_y: up_y,
	up_z: up_z,
	color: color,
	spr_mask: mask,
	size: size,
	quality: quality,
	light_power: light_power,
	is_orthographic: is_orthographic,
}