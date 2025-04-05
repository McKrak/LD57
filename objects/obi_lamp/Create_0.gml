mdl = instance_create_layer(x,y,"Instances",obr_mesh,{
	model: "lamp",
	texture: spm_lamp,
});
li[0] = Create_LightDirectional(
	4, 2, 80,
	#90ffa7, sp_MaskFlashlight,
	new Vec3(x+24, y+24, z+64),
	new Vec3(x+24, y+24, z),
	new Vec3(1, 1, 1));
mdl2 = instance_create_layer(x,y,"Instances",obr_mesh,{
	model: "lamp_rod",
	texture: spm_lamp,
});