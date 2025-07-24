// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

uniform float desaturationAmount = 0.0; // - alpha
uniform float distortionTime = 0.0;
uniform float amplitude = 0.0;
uniform float frequency = 0.0;
uniform float bitch = 0.3;
uniform const float threshold = 0.3; // Midpoint between 0.5 and 0.3

float colorR = 1.0;
float colorG = 0.0;
float colorB = 0.0;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
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
    vec3 blackOrRed = grayscaleValue > bitch ? vec3(colorR, colorG, colorB) : vec3(0.0, 0.0, 0.0);

    // Mix desaturation and chromatic aberration effect with thresholding
    vec3 finalColor = mix(blackOrRed, col.rgb, desaturationAmount);

    fragColor = vec4(finalColor, texture(iChannel0, fragCoord / iResolution.xy).a);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}