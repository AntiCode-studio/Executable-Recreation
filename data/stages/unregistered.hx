import openfl.display.BlendMode;
import flixel.effects.FlxFlicker;

importScript("data/huds/maniav3");
//importScript("data/scripts/cameraTweks");

portVisible = false;
var forcedMosaic:Bool = true;

mosaicShader = new CustomShader('mosaic');
mosaicShader.pixel = 0.000000001;

glitchShader = new CustomShader('glitch');
/*glitchShader.prob = 0;
glitchShader.vignetteIntensity = 0;
glitchShader.size = 0;
glitchShader.grid = 0;
glitchShader.blocks = 0;
glitchShader.glitchScale = 0;

glitchShader.prob = 0.2;
glitchShader.vignetteIntensity = 2.5;
glitchShader.size = 0.125;
glitchShader.grid = 1.5;
glitchShader.blocks = 0.2;
glitchShader.glitchScale = 0.1;*/

var objs:Array<FlxSprite> = [];
function generChar() {

    for (i in 1...9) {
        b = new FlxSprite(0,0);
        b.frames = Paths.getSparrowAtlas('stages/unregistered/bgAssets');
        b.animation.addByPrefix('idle', 'obj' + i, 15, false);
        b.animation.play('idle');
        insert(members.indexOf(tvInner), b);
        objs.push(b);
    }
}
function extraGlitch() {
    mosaicShader.pixel = 100;
}
function postCreate() {

    bg1.animation.play('idle');
    nightmarelon.animation.play('idle');
    bg.animation.play('idle');
    bed.animation.play('idle');
    beanbag.animation.play('idle');
    tvInner.animation.play('idle');
    tvLayer.animation.play('idle');
    beanbag.animation.play('idle');
    lightBeams.animation.play('idle');
    lights.animation.play('idle');
    lightbulbs.animation.play('idle');
    var blue = new FlxSprite(0,0).makeGraphic(1,1,FlxColor.BLUE);
    blue.scale.set(lightbulbs.width,lightbulbs.height);
    blue.updateHitbox();
    blue.alpha = 0.2;
    blue.blend = BlendMode.ADD;
    blue.scrollFactor(0,0);
    add(blue);
    generChar();

    dad.shader = mosaicShader;
    gf.visible = false;


    nightmarelon.y = 200;

    //camGame.addShader(glitchShader);
    //camHUD.addShader(glitchShader);

    strumLines.members[0].characters[1].visible = false;
    strumLines.members[0].characters[2].visible = false;

    strumLines.members[1].characters[1].visible = false;
    strumLines.members[1].characters[2].visible = false;
}

function stepHit(curStep:Int) {
    if(curStep % 16 == 0){
        if (forcedMosaic){
            mosaicShader.pixel = 10;
        }
        if (FlxG.random.bool(30)) {
            if (nightmarelon.y == -200) {
                FlxTween.tween(nightmarelon, {y: 0},5);
            }
            else if (nightmarelon.y == 0){
                FlxTween.tween(nightmarelon, {y: 200},5);
            }

        }
        
    }
}
var localTimer = 0;
function postUpdate(elapsed:Float) {
    localTimer += elapsed;
    glitchShader.time = localTimer;
    if (forcedMosaic){
        //mosaicShader.pixel = FlxMath.lerp(mosaicShader.pixel,0.001,0.03 * 60 * elapsed);
        mosaicShader.pixel = FlxMath.lerp(mosaicShader.pixel, 0.001, 0.03 * 60 * elapsed);
    }
}

function onPlayerMiss(event:NoteMissEvent) {
    flicker();
}
function flicker() {
    boyfriend.setColorTransform(0.5,0.5,1);
    FlxFlicker.flicker(boyfriend,1,0.05,true,true,(flicker)->{boyfriend.setColorTransform(1,1,1);});
}