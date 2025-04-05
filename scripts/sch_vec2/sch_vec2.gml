function Vec2_Dot(_vec2A, _vec2B) {
	return
		_vec2A.X * _vec2B.X +
		_vec2A.Y * _vec2B.Y;
}
function Vec2_PseudoCross(_vec2A, _vec2B) {
	return
		_vec2A.X * _vec2B.Y -
		_vec2A.Y * _vec2B.X;
}

function Vec2(_x, _y) constructor {
	
	X = (_x != undefined) ? _x : 0.0;
	Y = (_y != undefined) ? _y : 0.0;
	
	function GetLength() {
		return sqrt(X*X + Y*Y);
	}
	function Add(_vec2) {
		X += _vec2.X;
		Y += _vec2.Y;
	}
	function Subtract(_vec2) {
		X -= _vec2.X;
		Y -= _vec2.Y;
	}
	function Multiply(_float) {
		X *= _float;
		Y *= _float;
	}
	function Normalize() {
		var _l = GetLength();
		X /= _l;
		Y /= _l;
	}
	function Flip() {
		X = -X;
		Y = -Y;
		Z = -Z;
	}
	function WorldToView(_view, _vec3) {
		var _camera = view_camera[_view];
		
		static _point = new Vec3(0, 0, 0);
		_point.Copy(_vec3);
		_point.Transform(matrix_multiply(
			camera_get_view_mat(_camera),
			camera_get_proj_mat(_camera)));
		
		X = view_xport[_view] + view_wport[_view] * (+_point.X/_point.Z*0.5 + 0.5);
		Y = view_yport[_view] + view_hport[_view] * (-_point.Y/_point.Z*0.5 + 0.5);
	}
	function FromTo(_vec2From, _vec2To) {
		X = _vec3To.X - _vec3From.X;
		Y = _vec3To.Y - _vec3From.Y;
	}
	function Copy(_vec2) {
		X = _vec2.X;
		Y = _vec2.Y;
	}
	
	function toString() {
		return "[ " +  string(X) + ", " + string(Y) + " ]";
	}
}