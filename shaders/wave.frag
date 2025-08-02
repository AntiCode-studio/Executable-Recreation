// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

uniform float frequency = 8.0;
uniform float amplitude = 0.1;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 texCoord = fragCoord.xy / iResolution.xy;
    
    vec2 pulse = sin(iTime - frequency * texCoord);
    float dist = 2.0 * length(texCoord.y - 0.5);
    
    vec2 newCoord = texCoord + amplitude * vec2(0.0, pulse.x); // y-axis only; 
    
    vec2 interpCoord = mix(newCoord, texCoord, dist);
	
	fragColor = texture(iChannel0, interpCoord);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}