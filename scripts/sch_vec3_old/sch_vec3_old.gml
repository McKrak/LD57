function Vec3_Dot(_vec3A, _vec3B) {
	return
		_vec3A.X * _vec3B.X +
		_vec3A.Y * _vec3B.Y +
		_vec3A.Z * _vec3B.Z;
}

function Vec3(_x, _y, _z) constructor {
	
	X = (_x != undefined) ? _x : 0.0;
	Y = (_y != undefined) ? _y : 0.0;
	Z = (_z != undefined) ? _z : 0.0;
	
	function GetLength() {
		return sqrt(X*X + Y*Y + Z*Z);
	}
	function GetColor() {
		return make_color_rgb(X*255, Y*255, Z*255);
	}
	function SetColor(_color) {
		X = color_get_red(_color)	/ 255;
		Y = color_get_green(_color)	/ 255;
		Z = color_get_blue(_color)	/ 255;
	}
	function Add(_vec3) {
		X += _vec3.X;
		Y += _vec3.Y;
		Z += _vec3.Z;
	}
	function Subtract(_vec3) {
		X -= _vec3.X;
		Y -= _vec3.Y;
		Z -= _vec3.Z;
	}
	function Multiply(_float) {
		X *= _float;
		Y *= _float;
		Z *= _float;
	}
	function Transform(_matrix, _scale) {
		var b0 = X, b1 = Y, b2 = Z, b3 = (_scale == undefined) ? 1.0 : _scale;
		
		X = _matrix[ 0]*b0 + _matrix[ 4]*b1 + _matrix[ 8]*b2 + _matrix[12]*b3;
		Y = _matrix[ 1]*b0 + _matrix[ 5]*b1 + _matrix[ 9]*b2 + _matrix[13]*b3;
		Z = _matrix[ 2]*b0 + _matrix[ 6]*b1 + _matrix[10]*b2 + _matrix[14]*b3;
		return
			_matrix[ 3]*b0 + _matrix[ 7]*b1 + _matrix[11]*b2 + _matrix[15]*b3;
	}
	function Normalize() {
		var _l = GetLength();
		X /= _l;
		Y /= _l;
		Z /= _l;
	}
	function Flip() {
		X = -X;
		Y = -Y;
		Z = -Z;
	}
	function Cross(_vec3A, _vec3B) {
		var _tempX = _vec3A.Y * _vec3B.Z - _vec3A.Z * _vec3B.Y,
			_tempY = _vec3A.Z * _vec3B.X - _vec3A.X * _vec3B.Z,
			_tempZ = _vec3A.X * _vec3B.Y - _vec3A.Y * _vec3B.X;
		X = _tempX;
		Y = _tempY;
		Z = _tempZ;
	}
	function FromTo(_vec3From, _vec3To) {
		X = _vec3To.X - _vec3From.X;
		Y = _vec3To.Y - _vec3From.Y;
		Z = _vec3To.Z - _vec3From.Z;
	}
	function Copy(_vec3) {
		X = _vec3.X;
		Y = _vec3.Y;
		Z = _vec3.Z;
	}
	
	function toString() {
		return "[ " +  string(X) + ", " + string(Y) + ", " + string(Z) + " ]";
	}
}