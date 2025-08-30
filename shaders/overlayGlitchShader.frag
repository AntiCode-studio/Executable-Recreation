

vec2 rotate(vec2 v, float a)
{
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	return m * v;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    vec2 mouseNormalized = iMouse.xy / iResolution.xy;
    
    vec2 resLuminance = min(maxResLuminance, vec2(iResolution));
    vec2 resChroma = min(maxResChroma, vec2(iResolution));
    
    vec2 uvLuminance = uv * (resLuminance / vec2(iResolution));
    vec2 uvChroma = uv * (resChroma / vec2(iResolution));
    
    vec3 result;
    
    if (uv.x > mouseNormalized.x)
    {
        float luminance = textureBicubic(iChannel1, uvLuminance).x;
        vec2 chroma = textureBicubic(iChannel1, uvChroma).yz;
        result = vec3(luminance, chroma) * yiq2rgb;
    }
    else
    {
        result = texture(iChannel0, uv).rgb;
    }
    
    fragColor = vec4(result, 1);
}