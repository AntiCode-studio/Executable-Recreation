// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

uniform sampler2D tex1;

uniform float resX;
uniform float resY;
uniform float viewportX;
uniform float viewportY;
uniform float iTime;
uniform float dist;
uniform float intensity;
uniform float red,green,blue,alpha;

#define doAlpha tex1
#define fragCoord (gl_FragCoord.xy-vec2(viewportX,viewportY))
#define fragColor gl_FragColor 

void mainImage() {
  vec2 resolution = iResolution.xy;
  vec2 uv = fragCoord / resolution;

  vec4 texColor = texture(iChannel0, uv);

  if (texColor.a > 0.0) {
      float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));

      vec3 black = vec3(0.0, 0.0, 0.0);
      vec3 red = vec3(red, green, blue);

      vec3 finalColor = mix(black, red, step(dist, gray));

      vec4 Color1 = texture(doAlpha, uv);
      finalColor = mix(finalColor, Color1.rgb, intensity);  

      fragColor = vec4(finalColor, texture(iChannel0, fragCoord / iResolution.xy).a);
  } else {
      fragColor = texColor;
  }
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}