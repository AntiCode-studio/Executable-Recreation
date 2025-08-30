#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float desaturationAmount; // - alpha  = 0.0
float distortionTime = 0.0;
float amplitude = 0.0;
float frequency = 0.0;
uniform float threshold; // Midpoint between 0.5 and 0.3 (default is 0.3)
uniform float colorR; // = 1.0
uniform float colorG; // = 0.0
uniform float colorB; // = 0.0

void main(){
	vec2 uv = fragCoord.xy / iResolution.xy; 
	// Pincushion distortion
	vec2 st = uv - 0.5;
	float theta = atan(st.x, st.y);
	float radius = sqrt(dot(st, st));
	radius *= 1.0 + -0.5 * pow(radius, 2.0);
	
	// Adjust UV for pincushion distortion
	vec2 distortedUV = vec2(0.5 + sin(theta) * radius, 0.5 + cos(theta) * radius);

	// Chromatic aberration
	vec4 col;
	col.r = texture(iChannel0, vec2(distortedUV.x + ((uv.x + 0.5) / 500.0), uv.y)).r;
	col.g = texture(iChannel0, vec2(distortedUV.x, uv.y)).g;
	col.b = texture(iChannel0, vec2(distortedUV.x - ((uv.x + 0.5) / 500.0), uv.y)).b;
	col.a = texture(iChannel0, vec2(distortedUV.x - ((uv.x + 0.5) / 500.0), uv.y)).a;

	// Sine wave distortion
	vec2 sineWaveUV = vec2(uv.x + sin((uv.y * frequency) + distortionTime) * amplitude, uv.y);
	vec4 desatTexture = texture(iChannel0, sineWaveUV);
	float grayscaleValue = dot(desatTexture.xyz, vec3(.2126, .7152, .0722));

	// Thresholding to black or red
	vec3 blackOrRed = grayscaleValue > threshold ? vec3(colorR, colorG, colorB) : vec3(0.0, 0.0, 0.0);

	// Mix desaturation and chromatic aberration effect with thresholding
	vec3 finalColor = mix(blackOrRed, col.rgb, desaturationAmount);

	fragColor = vec4(finalColor, col.a);
}