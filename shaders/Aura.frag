//SHADERTOY PORT FIX
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
#define time iTime
//SHADERTOY PORT FIX

// Inner outline shader for Match2 game cell.
// Based on shader created by @remonvv
// https://www.shadertoy.com/view/MdjfRK
//
// Thanks to t.me/ru_cocos2dx@satan_black for help


float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898,12.1414))) * 83758.5453);
}

float noise(vec2 n) {
    const vec2 d = vec2(.0, 1.0);
    vec2 b = floor(n);
    vec2 f = mix(vec2(0.0), vec2(1.0), fract(n));
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);   
}

vec3 ramp(float t) {
	return t <= .5 ? vec3( 1. - t * 1.4, .2, 1.05 ) / t : vec3( .3 * (1. - t) * 2., .2, 1.05 ) / t;
}

float fire(vec2 n) {
    return noise(n) + noise(n * 2.1) * .6 + noise(n * 5.4) * .42;
}

/*
vec3 getLine(vec2 fc, mat2 mtx, float shift){
    float t = iTime;
    vec2 uv = (fc / iResolution.xy) * mtx;
    
    uv.x += uv.y < .5 ? 23.0 + t * .35 : -11.0 + t * .3;    
    uv.y = abs(uv.y - shift);
    uv *= 10.0;
        
    float q = fire(uv - t * .013) / 2.0;
    vec2 r = vec2(fire(uv + q / 2.0 + t - uv.x - uv.y), fire(uv + q - t));
    vec3 color = vec3(1.0 / (pow(vec3(0.5, 0.0, .1) + 1.61, vec3(4.0))));
    
    float grad = pow((r.y + r.y) * max(.0, uv.y) + .1, 4.0);
    color = ramp(grad);
    color /= (1.50 + max(vec3(0), color));
    return color;
}

void mainImage( ) {
	vec2 uv = fragCoord / iResolution.xy;
    fragColor = vec4(getLine(fragCoord, mat2(1., 1., 0., 1.), 1.), 1.);
    fragColor += vec4(getLine(fragCoord, mat2(1., 1., 1., 0.), 1.), 1.);
    fragColor += vec4(getLine(fragCoord, mat2(1., 1., 0., 1.), 0.), 1.);
    fragColor += vec4(getLine(fragCoord, mat2(1., 1., 1., 0.), 0.), 1.);
    if(fragColor.r <= .05 && fragColor.g <= .05 && fragColor.b <= .05 ){
    	fragColor = texture(iChannel0, uv);
    } else {
        fragColor += texture(iChannel0, uv);
    }
}
*/

vec3 getLine(vec3 col, vec2 fc, mat2 mtx, float shift){
    float t = iTime;
    vec2 uv = (fc / iResolution.xy) * mtx;
    
    uv.x += uv.y < .5 ? 23.0 + t * .35 : -11.0 + t * .3;    
    uv.y = abs(uv.y - shift);
    uv *= 5.0;
    
    float q = fire(uv - t * .013) / 2.0;
    vec2 r = vec2(fire(uv + q / 2.0 + t - uv.x - uv.y), fire(uv + q - t));
    vec3 color = vec3(1.0 / (pow(vec3(0.5, 0.0, .1) + 1.61, vec3(4.0))));
    
    float grad = pow((r.y + r.y) * max(.0, uv.y) + .1, 4.0);
    color = ramp(grad);
    color /= (1.50 + max(vec3(0), color));
    
    if(color.b < .00000005)
        color = vec3(.0);
    
    return mix(col, color, color.b);
}

void mainImage() {
    vec4 img = texture( iChannel0, fragCoord/iResolution.xy );
    vec4 img2 = texture( iChannel0, fragCoord/iResolution.xy );
    vec2 uv = fragCoord / iResolution.xy;
    vec3 color = vec3(0.);
    color = getLine(color, fragCoord, mat2(1., 1., 0., 1.), 1.02);
    color = getLine(color, fragCoord, mat2(1., 1., 1., 0.), 1.02);
    color = getLine(color, fragCoord, mat2(1., 1., 0., 1.), -0.02);
    color = getLine(color, fragCoord, mat2(1., 1., 1., 0.), -0.02);

    fragColor = img2 + img * vec4(color, 0.0);
}