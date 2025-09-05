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
var blue;
function onBeatHit() {
    if (curBeat % 2 == 0 && FlxG.random.bool(5)) {
        FlxFlicker.flicker(lightbulbs,FlxG.random.float(0.2,0.6),FlxG.random.float(0.02,0.1),true);
    }
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
    blue = new FlxSprite(0,0).makeGraphic(1,1,FlxColor.BLUE);
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

    createLegs();
}

function createLegs() {
    blueScreenLegs = new FlxSprite();
    blueScreenLegs.frames = Paths.getSparrowAtlas('characters/unregistered/unregisteredguy');
    blueScreenLegs.animation.addByPrefix('i','unregisteredlegs legs',20);
    blueScreenLegs.animation.play('i');
    blueScreenLegs.scale.set(0.6,0.6);
    blueScreenLegs.updateHitbox();
    insert(members.indexOf(dad), blueScreenLegs);

    michiLegs = new FlxSprite();
    michiLegs.frames = Paths.getSparrowAtlas('characters/unregistered/michi3D');
    michiLegs.animation.addByPrefix('i','legs loop',20);
    michiLegs.animation.play('i');
    michiLegs.scale.set(0.6,0.6);
    michiLegs.updateHitbox();
    insert(members.indexOf(dad), michiLegs);

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
    if (strumLines.members[0].characters[1].visible == true) {
        blueScreenLegs.visible = true;
        blueScreenLegs.setPosition(strumLines.members[0].characters[1].x + 750, strumLines.members[0].characters[1].y + 160);
        if (strumLines.members[0].characters[1].animation.curAnim.name == 'idle') {
            strumLines.members[0].characters[1].animation.curAnim.curFrame = blueScreenLegs.animation.curAnim.curFrame;
        }
    }
    else {
        blueScreenLegs.visible = false;
    }

    if (strumLines.members[1].characters[1].visible == true) {
        michiLegs.visible = true;
        michiLegs.setPosition(strumLines.members[1].characters[1].x + 390, strumLines.members[1].characters[1].y + 215);
        if (strumLines.members[1].characters[1].animation.curAnim.name == 'idle') {
            strumLines.members[1].characters[1].animation.curAnim.curFrame = michiLegs.animation.curAnim.curFrame;
        }
    }
    else {
        michiLegs.visible = false;
    }
}

function runTruns() {
    zoomAllow = false;
    strumLines.members[0].characters[0].visible = false;
    strumLines.members[1].characters[0].visible = false;
    strumLines.members[0].characters[1].visible = true;
    strumLines.members[1].characters[1].visible = true;

    strumLines.members[0].characters[1].y = strumLines.members[1].characters[1].y;

    bg1.visible = false;
    nightmarelon.visible = false;
    bg.visible = false;
    tvInner.visible = false;
    bed.visible = false;
    tvLayer.visible = false;
    beanbag.visible = false;
    lightBeams.visible = false;
    lights.visible = false;
    lightbulbs.visible = false;
    objs.visible = false;
    blue.visible = false;

    for (i in 0...8) {
        objs[i].visible = false;
    }
}

function thirdPart() {
    zoomAllow = false;
    bg1.visible = true;
    nightmarelon.visible = true;
    bg.visible = true;
    tvInner.visible = true;
    bed.visible = true;
    tvLayer.visible = true;
    beanbag.visible = true;
    lightBeams.visible = true;
    lights.visible = true;
    lightbulbs.visible = true;
    objs.visible = true;
    blue.visible = true;

    for (i in 0...8) {
        objs[i].visible = true;
    }

    strumLines.members[0].characters[0].visible = false;
    strumLines.members[1].characters[0].visible = false;
    strumLines.members[0].characters[1].visible = false;
    strumLines.members[1].characters[1].visible = false;
    strumLines.members[0].characters[2].visible = true;
    strumLines.members[1].characters[2].visible = true;
}

function onPlayerMiss(event:NoteMissEvent) {
    flicker();
}
function flicker() {
    boyfriend.setColorTransform(0.5,0.5,1);
    FlxFlicker.flicker(boyfriend,1,0.05,true,true,(flicker)->{boyfriend.setColorTransform(1,1,1);});
}