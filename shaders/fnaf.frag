// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

uniform float dist = 0.3;

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 v_vTexcoord = fragCoord / iResolution.xy;
    vec4 v_vColour = vec4(1.0); 

    vec2 coordinates;
    float pixelDistanceX;
    float pixelDistanceY;
    float offset;
    float dir;

    pixelDistanceX = abs(v_vTexcoord.x - 0.5);
    pixelDistanceY = abs(v_vTexcoord.y - 0.5);
    
    offset = pixelDistanceX * dist * pixelDistanceY;

    if (v_vTexcoord.y <= 0.5)
        dir = 1.0;
    else
        dir = -1.0;

    coordinates = vec2(v_vTexcoord.x, v_vTexcoord.y + pixelDistanceX * (offset * 30.0 * dir));
    
    vec4 color = texture(iChannel0, coordinates);
    fragColor = v_vColour * color;
  
  
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}