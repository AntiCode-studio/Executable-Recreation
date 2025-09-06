import funkin.backend.shaders.FunkinShader;
import funkin.backend.utils.AudioAnalyzer;
import openfl.display.BitmapData;
import openfl.display3D.Context3DTextureFilter;

var analyzer:AudioAnalyzer;
var lastTime:Float;
var cache:Array<Float>;

var sprite:FlxSprite;
var bitmap:BitmapData;
var realBars:Int = 128;
var bars:Int = realBars * 3;

function postCreate() {
	var camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
	camera.bgColor = 0;

	analyzer = new AudioAnalyzer(FlxG.sound.music, 4096);

	sprite = new FlxSprite().makeGraphic(realBars, 1, FlxColor.BLACK, false, 'spectraasdasca');
	sprite.graphic.destroyOnNoUse = false;
	sprite.graphic.persist = false;
	sprite.antialiasing = true;
	bitmap = sprite.graphic.bitmap;


	sprite.cameras = [camera];
	sprite.shader = new FunkinShader("
#pragma header
#define realBars " + realBars + "
#define bars " + bars + "

float getRealAmp(float x) {
	vec4 p = texture2D(bitmap, vec2((x + 0.5) / openfl_TextureSize.x, 0.5));
	int idx = int(mod(x, 3.0));
	if (idx == 0) return p.r;
	else if (idx == 1) return p.g;
	else if (idx == 2) return p.b;
	return 0.0;
}

float getAmp(float x) {
	float i = floor(x);
	float a0 = getRealAmp(i);
	float a1 = getRealAmp(ceil(x));
	return a0 + (a1 - a0) * (x - i);
}

void main(void) {
	float amp = max(getAmp(openfl_TextureCoordv.x * realBars), 0.008);

	float v = pow(amp - abs(openfl_TextureCoordv.y - 0.5), 0.01) * abs(mod(openfl_TextureCoordv.x * bars, 2.0) - 1.0);

	vec4 color = vec4(max(min(v, 1.0), 0.0));
	gl_FragColor = applyFlixelEffects(color);
}
");
	sprite.shader.data.bitmap.filter = Context3DTextureFilter.NEAREST;

	sprite.setGraphicSize(1024, 256);
	sprite.updateHitbox();
	sprite.screenCenter();
	sprite.x = Math.floor(sprite.x);
	sprite.y = Math.floor(sprite.y);
	add(sprite);
}

function onStartSong() FlxG.cameras.add(sprite.cameras[0], false);

function update(elapsed:Float) {
	if (analyzer != null && analyzer.sound.playing) {
		var time = analyzer.sound.time;
		if (lastTime != time)
			cache = analyzer.getLevels(lastTime = time, bars, cache, CoolUtil.getFPSRatio(0.3), -70, -20, 50, 20000);
	}
	else {
		if (cache == null) cache = [];
		cache.resize(bars);
	}

	var i = bars, k = 0;
	while (i > 0) bitmap.setPixel(k++, 0, FlxColor.fromRGBFloat(cache[--i], cache[--i], cache[--i]));
}