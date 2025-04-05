//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_AmbientColor;

void main() {
	
    vec4 fragColor = 1.0 * texture2D(gm_BaseTexture, v_vTexcoord);
	if (fragColor.a < 0.01) {
		discard;
	}
	
	fragColor.rgb *= u_AmbientColor;
	gl_FragColor = fragColor;
}
