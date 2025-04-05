attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec4 in_Bone;						// (b0,b1,b2,b3)
attribute vec4 in_Weight;					// (w0,w1,w2,w3)

varying vec2  v_Texcoord;
varying float v_LightZ;
varying float v_LightW;

uniform mat4 u_LightSpaceMatrix;
uniform mat4 u_bonematrices[192];	// Bone transforms

void main() {
// Summation of bone matrices multiplied by bone weight
	mat4 m = mat4(0.0);
	for (int i = 0; i < 4; i++) {
		m += u_bonematrices[int(in_Bone[i])] * in_Weight[i];
	}
	
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	object_space_pos = m * object_space_pos;	// Matrix MUST be left operand
	
	vec4 lightSpacePos	= u_LightSpaceMatrix * object_space_pos;
	lightSpacePos.y *= -1.0;
	
	gl_Position = lightSpacePos;
	
    v_Texcoord		= in_TextureCoord;
	v_LightZ		= lightSpacePos.z;
	v_LightW		= lightSpacePos.w;
}