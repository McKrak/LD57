attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_Texcoord;
varying vec4 v_Colour;

void main() {
	
    vec4 objectSpacePos = vec4( in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * objectSpacePos;

    v_Colour	= in_Colour;
    v_Texcoord	= in_TextureCoord;
}