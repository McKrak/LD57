globalvar Vertex_Format;
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_color();
vertex_format_add_texcoord();
Vertex_Format = vertex_format_end();

function Vertex(_position, _texcoord, _color, _alpha) constructor {
	Position	= _position;
	Texcoord	= (_texcoord	!= undefined) ? _texcoord	: new Vec2(0, 0);
	Color		= (_color		!= undefined) ? _color		: c_white;
	Alpha		= (_alpha		!= undefined) ? _alpha		: 1.0;
	
	static ToBuffer = function(_vbuff, _normal) {
		static _zeroNorm = new Vec3(0, 0, 0);
		if (_normal == undefined) {
			_normal = _zeroNorm
		}
		
		vertex_position_3d(	_vbuff,	Position.X,	Position.Y,	Position.Z);
		vertex_normal(		_vbuff,	_normal.X,	_normal.Y,	_normal.Z);
		vertex_color(		_vbuff,	Color,		Alpha);
		vertex_texcoord(	_vbuff,	Texcoord.X,	Texcoord.Y);
	}
}