attribute vec3 in_Position;					// (x,y,z)
attribute vec3 in_Normal;					// (x,y,z) 
attribute vec4 in_Colour;                   // (r,g,b,a)
attribute vec2 in_TextureCoord;             // (u,v)
attribute vec4 in_Bone;						// (b0,b1,b2,b3)
attribute vec4 in_Weight;					// (w0,w1,w2,w3)

varying vec2  v_Texcoord;
varying vec4  v_Colour;
varying vec4  v_LightProjPosition;
varying vec3  v_LightViewPosition;
varying vec3  v_LightViewNormal;

uniform mat4 u_LightWorldViewMatrix;
uniform mat4 u_LightProjMatrix;
// Uniforms - Passed in in draw call
uniform mat4 u_bonematrices[192];	// Bone transforms

void main() {
// Summation of bone matrices multiplied by bone weight
	mat4 m = mat4(0.0);
	for (int i = 0; i < 4; i++) {
		m += u_bonematrices[int(in_Bone[i])] * in_Weight[i];
	}
	
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	object_space_pos = m * object_space_pos;	// Matrix MUST be left operand
	
	vec4 lightViewPos	= u_LightWorldViewMatrix * object_space_pos;
	vec4 lightProjPos	= u_LightProjMatrix * lightViewPos;
	vec3 lightViewNrm	= mat3(u_LightWorldViewMatrix) * in_Normal;
	
    gl_Position	= gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
    v_Colour			= in_Colour;
    v_Texcoord			= in_TextureCoord;
	v_LightProjPosition	= lightProjPos;
	v_LightViewPosition	= vec3(lightViewPos);
	v_LightViewNormal	= lightViewNrm;
}