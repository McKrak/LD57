varying vec2  v_Texcoord;
varying vec4  v_Colour;
varying vec4  v_LightProjPosition;
varying vec3  v_LightViewPosition;
varying vec3  v_LightViewNormal;

uniform bool		u_UseOrtho;
uniform float		u_Power;
uniform float		u_ShadowThreshold;
uniform vec3		u_LightColor;
uniform sampler2D	u_LightMask;
uniform sampler2D	u_ShadowMap;

const float SCALE_FACTOR = 256.0 * 256.0 * 256.0 - 1.0;
const vec3 SCALE_VECTOR = vec3(1.0, 256.0, 256.0 * 256.0) / SCALE_FACTOR * 255.0;
float unpack8BitVec3IntoFloat(vec3 valRGB)
{
	return dot(valRGB, SCALE_VECTOR);
}

void main() {
	
	if (abs(v_LightProjPosition.x) > v_LightProjPosition.w ||
		abs(v_LightProjPosition.y) > v_LightProjPosition.w ||
		abs(v_LightProjPosition.z) > v_LightProjPosition.w) {
		discard;
	}
	
    vec4 fragColor = v_Colour * texture2D(gm_BaseTexture, v_Texcoord);
	if (fragColor.a < 0.01) {
		discard;
	}
	
	vec3 normal			= normalize(gl_FrontFacing ? 
		-v_LightViewNormal : v_LightViewNormal);
	float illumination	= u_UseOrtho ? 
		normal.z	: dot(normal, normalize(v_LightViewPosition.xyz));
	float dist			= u_UseOrtho ? 
		1.0			: length(v_LightViewPosition.xyz) / 50.0;
	illumination *= u_Power / (dist*dist);
	if (illumination <= 0.0) {
		discard;
	}
	
	vec3 lightSpacePos		= v_LightProjPosition.xyz / v_LightProjPosition.w * 0.5 + 0.5;
	vec3 lightPosMirrored   = vec3(lightSpacePos.x,1.0 - lightSpacePos.y,lightSpacePos.z);
	
	vec3 packedShadowDepth	= texture2D(u_ShadowMap, lightSpacePos.xy).rgb;
	float shadowDepth		= unpack8BitVec3IntoFloat(packedShadowDepth);
	if (lightSpacePos.z > shadowDepth + u_ShadowThreshold) {
		discard;
	}
	
	vec3  maskColor				= texture2D(u_LightMask, lightPosMirrored.xy).rgb;
	float smoothIllumination	= smoothstep(0.15, 0.80, illumination);
	fragColor.rgb *= u_LightColor * maskColor * smoothIllumination;
	
	gl_FragColor = fragColor;
}