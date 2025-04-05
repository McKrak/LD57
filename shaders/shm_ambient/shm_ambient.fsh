varying vec2 v_Texcoord;
varying vec4 v_Colour;
varying vec3 v_Pos;

uniform vec3 u_AmbientColor;

void main() {
	
    vec4 fragColor = v_Colour * texture2D(gm_BaseTexture, v_Texcoord);
	if (fragColor.a < 0.01) {
		discard;
	}
	
	fragColor.rgb *= u_AmbientColor;
	gl_FragColor = fragColor;
}