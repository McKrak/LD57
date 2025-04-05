function Create_LightDirectional(_size, _quality, _power, _color, _mask, _from, _to, _up) {
	var light = instance_create_depth(0, 0, 0, obr_light);
	light.SetAsDirectional(_size, _quality, _power);
	light.SetColor(_color, _mask);
	light.SetPosition(_from, _to, _up);
	
	return light;
}

function Create_LightSpot(_size, _quality, _power, _color, _mask, _from, _to, _up) {
	var light = instance_create_depth(0, 0, 0, obr_light);
	light.SetAsSpot(_size, _quality, _power);
	light.SetColor(_color, _mask);
	light.SetPosition(_from, _to, _up);
	
	return light;
}
function Create_WireMesh(_texture) {
	var mesh = instance_create_depth(0, 0, 0, obr_wireframe);
	mesh.Texture = _texture;
	
	return mesh;
}