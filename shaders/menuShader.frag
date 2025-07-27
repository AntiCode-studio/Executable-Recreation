// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

//subscribe to pewdiepie

vec2 rot(vec2 uv, float r) {
    float sinX = sin (r);
    float cosX = cos (r);
    float sinY = sin (r);
    mat2 rotationMatrix = mat2( cosX, -sinX, sinY, cosX);
    return uv *rotationMatrix;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float s = 7.;		//stripes
    float st = 0.2;		//stripe thickness

    vec2 uv = rot(fragCoord/iResolution.xy, -0.2+sin(iTime)*0.05);

    float osc = sin(uv.x*(uv.x+.5)*15.)*0.2;
    uv.y += osc * sin(iTime+uv.x*2.);
    uv.y = fract(uv.y*s);
    
    vec3 bg = vec3(.0,.0,.0);
    vec3 fg = vec3(1,.05,.4);
    
    float mask = smoothstep(0.5, 0.55, uv.y);
    mask += smoothstep(0.5+st,0.55+st, 1.-uv.y);
    
    vec3 col = mask*bg + (1.-mask)*fg;

    // Output to screen
    fragColor = vec4(col, texture(iChannel0, fragCoord / iResolution.xy).a);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}