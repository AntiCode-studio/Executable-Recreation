import openfl.display.BlendMode;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween.FlxTweenType;

importScript("data/huds/maniav3");
//importScript("data/scripts/cameraTweks");

portVisible = false;
var forcedMosaic:Bool = true;
introLength = 0;
mosaicShader = new CustomShader('mosaic');
mosaicShader.pixel = 0.000000001;

glitchShader = new CustomShader('glitch');
snowfall = new CustomShader('GlitchShaderA');
bg3dGlitch = new CustomShader('GlitchShaderA');
bgparglitch = new CustomShader('GlitchShaderA');
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

var part;

var colorShader = new CustomShader('adjustColor');
colorShader.brightness = 0;
colorShader.hue = 0;
colorShader.contrast = 0;
colorShader.saturation = 0;

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
function beatHit(curBeat:Int) {
    if(part== 1||part ==3){
        if (curBeat % 2 == 0 && FlxG.random.bool(5)) {
            FlxFlicker.flicker(lightbulbs,FlxG.random.float(0.2,0.6),FlxG.random.float(0.02,0.1),true);
        }
    }
    
}

function glitchpart1() {
    strumLines.members[0].characters[0].shader = bgparglitch;
    FlxTween.tween(bgparglitch, {glitchAmount: 0.5}, 1);
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

    snowfall.glitchAmount = 0.0001;
    camGame.addShader(snowfall);
    camGame.addShader(colorShader);

    part = 1;

    tvInner.shader = bgparglitch;
    bgparglitch.glitchAmount = 0.0001;
}

function createLegs() {
    dsky = new FunkinSprite().loadGraphic(Paths.image('stages/unregistered/3dsky'));
    dsky.scale.set(3,3);
    dsky.scrollFactor.set(0.5,0.5);
    dsky.updateHitbox();
    dsky.screenCenter();
    dsky.zoomFactor = 0.5;
	insert(members.indexOf(dad),dsky);
    dsky.visible = false;
    bg3dGlitch.glitchAmount = 0.1;
    dsky.shader = bg3dGlitch;

    floor = new FlxSprite();
	floor.frames = Paths.getSparrowAtlas('stages/unregistered/floorAnimation');
	floor.animation.addByPrefix('i','floor',10);
	floor.animation.play('i');
	floor.scale.set(2.2,2.2);
    insert(members.indexOf(dad),floor);
    floor.visible = false;

    trees1 = new FlxBackdrop(Paths.image('stages/unregistered/trees1'), 1, 0);
    trees1.scale.set(2,2);
    trees1.velocity.set(-2000, 0);
    trees1.y -= 100;
    trees1.scrollFactor.set(0.8,0.8);
	insert(members.indexOf(dad),trees1);
    trees1.visible = false;

    trees2 = new FlxBackdrop(Paths.image('stages/unregistered/trees2'), 1, 0);
    trees2.scale.set(2.7,2.7);
    trees2.velocity.set(-2550, 0);
    trees2.y += 200;
    trees2.scrollFactor.set(1.2,1.2);
	add(trees2);
    trees2.visible = false;

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
function glitchTrans() {
    FlxTween.tween(snowfall, {glitchAmount: 5}, 3);
    FlxTween.tween(camGame, {alpha: 0}, 3);
}
function glitchTrans1() {
    snowfall.glitchAmount = 10;
    FlxTween.tween(snowfall, {glitchAmount: 0.00001}, 1);
}
function stepHit(curStep:Int) {
    if(curStep % 16 == 0){
        if (forcedMosaic){
            mosaicShader.pixel = 10;
        }
        if (FlxG.random.bool(30)) {
            if (nightmarelon.y == 200) {
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
    bg3dGlitch.iTime = localTimer;
    snowfall.iTime = localTimer;
    bgparglitch.iTime = localTimer;
    if (forcedMosaic){
        //mosaicShader.pixel = FlxMath.lerp(mosaicShader.pixel,0.001,0.03 * 60 * elapsed);
        mosaicShader.pixel = FlxMath.lerp(mosaicShader.pixel, 0.001, 0.03 * 60 * elapsed);
    }
    if (strumLines.members[0].characters[1].visible == true) {
        blueScreenLegs.visible = true;
        blueScreenLegs.setPosition(strumLines.members[0].characters[1].x - 700, strumLines.members[0].characters[1].y + 70);
        if (strumLines.members[0].characters[1].animation.curAnim.name == 'idle') {
            strumLines.members[0].characters[1].animation.curAnim.curFrame = blueScreenLegs.animation.curAnim.curFrame;
        }
    }
    else {
        blueScreenLegs.visible = false;
    }

    if (strumLines.members[1].characters[1].visible == true) {
        michiLegs.visible = true;
        michiLegs.setPosition(strumLines.members[1].characters[1].x - 140, strumLines.members[1].characters[1].y + 90);
        if (strumLines.members[1].characters[1].animation.curAnim.name == 'idle') {
            strumLines.members[1].characters[1].animation.curAnim.curFrame = michiLegs.animation.curAnim.curFrame;
        }
    }
    else {
        michiLegs.visible = false;
    }
}

function runTruns() {
    part = 2;
    zoomAllow = false;
    colorShader.contrast = 100;
    strumLines.members[0].characters[0].visible = false;
    strumLines.members[1].characters[0].visible = false;
    strumLines.members[0].characters[1].visible = true;
    strumLines.members[1].characters[1].visible = true;

    strumLines.members[1].characters[1].y += 250;

    strumLines.members[0].characters[1].y = strumLines.members[1].characters[1].y;

    dsky.visible = true;
    floor.visible = true;
    trees1.visible = true;
    trees2.visible = true;

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
    colorShader.contrast = 0;
    part = 3;
    bgparglitch.glitchAmount = 0.0001;
    camGame.alpha = 1;
    snowfall.glitchAmount = 0.00001;
    dsky.visible = false;
    floor.visible = false;
    trees1.visible = false;
    trees2.visible = false;

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
    for (t in 0...7) {
    //    trace(t);
        FlxTween.tween(objs[t], {angle: FlxG.random.float(-10,10), y:FlxG.random.float(-150,-200)}, FlxG.random.float(5,10), {ease: FlxEase.expoInOut, type: FlxTweenType.PINGPONG});
    }

    strumLines.members[0].characters[0].visible = false;
    strumLines.members[1].characters[0].visible = false;
    strumLines.members[0].characters[1].visible = false;
    strumLines.members[1].characters[1].visible = false;
    strumLines.members[0].characters[2].visible = true;
    strumLines.members[1].characters[2].visible = true;

    strumLines.members[1].characters[2].angle -= 2;
    strumLines.members[0].characters[2].angle += 2;
    strumLines.members[1].characters[2].y -= 250;
    strumLines.members[0].characters[2].y = strumLines.members[1].characters[2].y - 50;
    strumLines.members[0].characters[2].x -= 150;
    trace(strumLines.members[1].characters[2].y);
    FlxTween.tween(strumLines.members[1].characters[2], {angle: 2, y:180}, 4, {ease: FlxEase.expoInOut, type: FlxTweenType.PINGPONG});
    FlxTween.tween(strumLines.members[0].characters[2], {angle: -2, y:60}, 4, {ease: FlxEase.expoInOut, type: FlxTweenType.PINGPONG});

    remove(strumLines.members[0].characters[2]);
    insert(members.indexOf(strumLines.members[1].characters[2]), strumLines.members[0].characters[2]);
}

function onPlayerMiss(event:NoteMissEvent) {
    flicker();
}
function flicker() {
    if(part == 1){
        strumLines.members[1].characters[0].setColorTransform(0.5,0.5,1);
        FlxFlicker.flicker(strumLines.members[1].characters[0],1,0.05,true,true,(flicker)->{strumLines.members[1].characters[0].setColorTransform(1,1,1);});
    }else if (part == 2){
        strumLines.members[1].characters[1].setColorTransform(0.5,0.5,1);
        FlxFlicker.flicker(strumLines.members[1].characters[1],1,0.05,true,true,(flicker)->{strumLines.members[1].characters[1].setColorTransform(1,1,1);});
        michiLegs.setColorTransform(0.5,0.5,1);
        FlxFlicker.flicker(michiLegs,1,0.05,true,true,(flicker)->{michiLegs.setColorTransform(1,1,1);});
    }else if (part == 3){
        strumLines.members[1].characters[2].setColorTransform(0.5,0.5,1);
        FlxFlicker.flicker(strumLines.members[1].characters[2],1,0.05,true,true,(flicker)->{strumLines.members[1].characters[2].setColorTransform(1,1,1);});
    }
}