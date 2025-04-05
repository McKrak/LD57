meshRotationX +=
	keyboard_check(ord("W")) - 
	keyboard_check(ord("S"));
meshRotationY += 
	keyboard_check(ord("D")) - 
	keyboard_check(ord("A"));
meshRotationZ += 
	keyboard_check(ord("E")) - 
	keyboard_check(ord("Q"));
meshRotationX = clamp(meshRotationX, -180, 180);

mesh.xrot = meshRotationX;
mesh.yrot = meshRotationY;
mesh.zrot = meshRotationZ;
mesh.Update();

if (keyboard_check_pressed(vk_space)) {
	var _light = instance_create_depth(0, 0, 0, obr_light);
	if (random(1) > 0.5)	_light.SetAsDirectional(choose(1, 2, 4), 2, 1);
	else					_light.SetAsSpot(choose(0.125, 0.25, 0.5, 1, 2), 8, random_range(20, 100));
	_light.SetColor(
		make_color_rgb(irandom(255), irandom(255), irandom(255)), 
		choose(sp_MaskDefaultl, sp_MaskFlashlight));
	_light.SetPosition(
		new Vec3(
			choose(-1, 1) * random_range(150, 400),
			choose(-1, 1) * random_range(150, 400),
			choose(-1, 1) * random_range(150, 400)),
		new Vec3(0, -50, 0),
		new Vec3(0, 1, 0));
}
if (keyboard_check_pressed(vk_backspace)) {
	var _count = instance_number(obr_light);
	if (_count > 0) {
		var	_num	= irandom(_count-1),
			_id		= instance_find(obr_light, _num);
		instance_destroy(_id);
	}
}

//var timeStep = delta_time * 60 / 1000000;

//mainInst.step(timeStep);