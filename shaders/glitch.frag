// https://www.shadertoy.com/view/XtyXzW

//ported by my good friend cold_vee
//although cleaned up and added more to it by data
#pragma header

vec2 uv = openfl_TextureCoordv.xy;
uniform float time;
uniform float prob;
uniform float vignetteIntensity;

uniform float size;
uniform float grid;
uniform float blocks;

uniform float glitchScale;


#define PI 3.14159265359
#define PHI (1.618033988749895)

vec3 tex2D(sampler2D _tex,vec2 _p)
{
    vec3 col=flixel_texture2D(_tex,_p).xyz;
    if(0.5<abs(_p.x-0.5)){
        col=vec3(.1);
    }
    return col;
}



// --------------------------------------------------------
// Glitch core
// --------------------------------------------------------

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec2 glitchCoord(vec2 p, vec2 gridSize) {
	vec2 coord = floor(p / gridSize) * gridSize;;
    coord += (gridSize / 2.0);
    return coord;
}

struct GlitchSeed {
    vec2 seed;
    float prob;
};
    
float fBox2d(vec2 p, vec2 b) {
  vec2 d = abs(p) - b;
  return min(max(d.x, d.y), 0.0) + length(max(d, 0.0));
}

GlitchSeed glitchSeed(vec2 p, float speed) {
    float seedTime = floor(time * speed);
    vec2 seed = vec2(
        1.0 + mod(seedTime / 100.0, 100.0),
        1.0 + mod(seedTime, 100.0)
    ) / 100.0;
    seed += p; 
    return GlitchSeed(seed, prob);
}

float shouldApply(GlitchSeed seed) {
    return floor(
        mix(mix(rand(seed.seed), 1.0, seed.prob - 0.5),0.0,(1.0 - seed.prob) * 0.5) + 0.5
    );
}


// --------------------------------------------------------
// Glitch effects
// --------------------------------------------------------

// Swap

vec4 swapCoords(vec2 seed, vec2 groupSize, vec2 subGrid, vec2 blockSize) {
    vec2 rand2 = vec2(rand(seed), rand(seed+0.1));
    vec2 range = subGrid - (blockSize - 1.0);
    vec2 coord = floor(rand2 * range) / subGrid / 2;
    vec2 bottomLeft = coord * groupSize;
    vec2 realBlockSize = (groupSize / subGrid) * blockSize;
    vec2 topRight = bottomLeft + realBlockSize;
    topRight -= groupSize / 2.0;
    bottomLeft -= groupSize / 2.0;
    return vec4(bottomLeft, topRight);
}

float isInBlock(vec2 pos, vec4 block) {
    vec2 a = sign(pos - block.xy);
    vec2 b = sign(block.zw - pos);
    return min(sign(a.x + a.y + b.x + b.y - 3.0), 0.0);
}

vec2 moveDiff(vec2 pos, vec4 swapA, vec4 swapB) {
    vec2 diff = swapB.xy - swapA.xy;
	swapA.a = 1;
	swapB.a = 1;
    return diff * isInBlock(pos, swapA);
}

void swapBlocks(inout vec2 xy, vec2 groupSize, vec2 subGrid, vec2 blockSize, vec2 seed, float apply) {
    
    vec2 groupOffset = glitchCoord(xy, groupSize);
    vec2 pos = xy - groupOffset;
    
    vec2 seedA = seed * groupOffset;
    vec2 seedB = seed * (groupOffset + 0.1);
    
    vec4 swapA = swapCoords(seedA, groupSize, subGrid, blockSize);
    vec4 swapB = swapCoords(seedB, groupSize, subGrid, blockSize);
	swapA.a = 1;
	swapB.a = 1;
    
    vec2 newPos = pos;
    newPos += moveDiff(pos, swapA, swapB) * apply;
    newPos += moveDiff(pos, swapB, swapA) * apply;
    pos = newPos;
    
    xy = pos + groupOffset;
}


// Static


// --------------------------------------------------------
// Glitch compositions
// --------------------------------------------------------

void glitchSwap(inout vec2 p) {
    vec2 pp = p;
    
    float scale = glitchScale;
    float speed = 5.0;
    
    vec2 groupSize;
    vec2 subGrid;
    vec2 blockSize;    
    GlitchSeed seed;
    float apply;
    
    groupSize = vec2(0.6 + size) * scale;
    subGrid = vec2(2 + grid);
    blockSize = vec2(1 + blocks);

    seed = glitchSeed(glitchCoord(p, groupSize), speed);
    apply = shouldApply(seed);
    swapBlocks(p, groupSize, subGrid, blockSize, seed.seed, apply);
    
    groupSize = vec2(0.8 + size) * scale;
    subGrid = vec2(6 + grid);
    blockSize = vec2(2 + blocks);
    
    seed = glitchSeed(glitchCoord(p, groupSize), speed);
    apply = shouldApply(seed);
    swapBlocks(p, groupSize, subGrid, blockSize, seed.seed, apply);

    groupSize = vec2(0.2 + size) * scale;
    subGrid = vec2(6 + grid);
    blockSize = vec2(6 + blocks);
    
    seed = glitchSeed(glitchCoord(p, groupSize), speed);
    float apply2 = shouldApply(seed);
    swapBlocks(p, groupSize, subGrid, blockSize, (seed.seed + 1.0), apply * apply2);
    swapBlocks(p, groupSize, subGrid, blockSize, (seed.seed + 2.0), apply * apply2);
    swapBlocks(p, groupSize, subGrid, blockSize, (seed.seed + 3.0), apply * apply2);
    swapBlocks(p, groupSize, subGrid, blockSize, (seed.seed + 4.0), apply * apply2);
    swapBlocks(p, groupSize, subGrid, blockSize, (seed.seed + 5.0), apply * apply2);
    
    groupSize = vec2(1.2, 0.2) * scale;
    subGrid = vec2(9,2);
    blockSize = vec2(3,1);
    
    seed = glitchSeed(glitchCoord(p, groupSize), speed);
    apply = shouldApply(seed);
    swapBlocks(p, groupSize, subGrid, blockSize, seed.seed, apply);
}

float random (float2 uv){return frac(sin(dot(uv,float2(12.9898,78.233)))*43758.5453123);}

void main() {
    vec2 p = openfl_TextureCoordv.xy;
    glitchSwap(p);

    vec3 color = flixel_texture2D(bitmap, p).rgb;

    vec4 basecolor = flixel_texture2D(bitmap, openfl_TextureCoordv);

    float amount = clamp((0.5 * sin(time * PI) + vignetteIntensity),0.0,1.0);

    //discard black
	if (color == vec3(0, 0, 0)) discard;

    //applies glitch
    if (basecolor.a > 0) {
        basecolor.rgb = mix(color.rgb, basecolor.rgb, amount);
    }
    else {
       basecolor.rgb = color.rgb;
    }

    //inverts the color
    if (mod(time,4)/4 < 0.5 && openfl_TextureCoordv.x > 0.5) {
        basecolor.xyz = vec3(1, 1, 1) - basecolor.xyz;
    }

    gl_FragColor = basecolor;
}