mdl = instance_create_layer(x,y,"Instances",obr_mesh,{
	model: "wallcandle",
	texture: spm_wallcandle,
	zrot: image_angle,
});
	
li[0] = Create_LightSpot(
	4, 8, 8,
	#ffddaa, sp_MaskFlashlight,
	new Vec3(x+24, y, z+32.6),
	new Vec3(x+24, y+24, z+32.6),
	new Vec3(0, 0, -1));
li[1] = Create_LightSpot(
	4, 10, 8,
	#ffddaa, sp_MaskFlashlight,
	new Vec3(x+24, y+24, z+32.6),
	new Vec3(x+24, y, z+32.6),
	new Vec3(0, 0, -1));
li[2] = Create_LightSpot(
	4, 10, 8,
	#ffddaa, sp_MaskFlashlight,
	new Vec3(x+24, y+24, z+48),
	new Vec3(x+24, y+24, z),
	new Vec3(0, 1, -1));



