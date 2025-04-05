varying vec2  v_Texcoord;
varying float v_LightZ;
varying float v_LightW;

const float SCALE_FACTOR = 256.0 * 256.0 * 256.0 - 1.0;
vec3 packFloatInto8BitVec3(float val01)
{
	float zeroTo24Bit = val01 * SCALE_FACTOR;
	return floor(
		vec3(
			mod(zeroTo24Bit, 256.0),
			mod(zeroTo24Bit / 256.0, 256.0),
			zeroTo24Bit / 256.0 / 256.0
			)
		) / 255.0;
}

void main() {
	
	vec4 fragColor = texture2D(gm_BaseTexture, v_Texcoord);
	if (fragColor.a < 0.01) {
		discard;
	}
	
	float depth = v_LightZ / v_LightW * 0.5 + 0.5;
	vec3 packedDepth = packFloatInto8BitVec3(depth);
	gl_FragColor = vec4(packedDepth, 1.0);
}