import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;

aura = new CustomShader('Aura');
var noteOffsets = [0,0];
public var noteMoveAmt = 150;

snowfall = new CustomShader('GlitchShaderA');
var paceSky:FlxBackdrop;
var pacefloor:FlxBackdrop;
var fgtree:FlxBackdrop;
function postCreate() {
    camGame.addShader(aura);
    snowfall.glitchAmount = 0.0001;
    camGame.addShader(snowfall);
    camHUD.addShader(snowfall);
}
var isRun = false;
function cutseneRun(part) {
    if(part == '0'){  
        remove(blackP);
        remove(paceCutG);
        insert(members.indexOf(strumLines), blackP);
        insert(members.indexOf(strumLines), paceCutG);
        blackP.visible = true;
        paceCutG.visible = true;
    }
    if(part == '1'){  
        paceCutG.animation.play('pre-scared');
    }
    if(part == '2'){  
        blackP.visible = false;
        paceCutG.visible = false;
    }
}
function paceBGcolor(par) {
    if(par == 'red'){
        fgtree.color = 0xff0000;
        paceSky.color = 0xff0000;
        pacefloor.color = 0xff0000;
    }
    if(par == 'black'){
        fgtree.color = 0x141414;
        paceSky.color = 0x141414;
        pacefloor.color = 0x141414;
    }
    if(par == 'white'){
        fgtree.color = 0xffffff;
        paceSky.color = 0xffffff;
        pacefloor.color = 0xffffff;
    }
    
}
function paceRun(trueOrFalse:Bool) {
    trace(trueOrFalse);
    if(trueOrFalse =="false"){
        insert(members.indexOf(gf), backDrop);
        paceLegs.visible = false;
        backDrop.visible = false;
        fgtree.visible = false;
        paceSky.visible = false;
        pacefloor.visible = false;
        sun.visible = false;
        sun2.visible = false;
        isRun = false;
    }else{
        //strumLines.members[0].characters[1].visible = true;
        //strumLines.members[0].characters[0].visible = false;
        remove(backDrop);
        paceLegs.visible = true;
        backDrop.visible = true;
        prlBG.alpha = 0;
        redBG.alpha = 0;
        redBG2.alpha = 0;
        redFog.alpha = 0;
        redFog2.alpha = 0;
        fgtree.visible = true;
        paceSky.visible = true;
        pacefloor.visible = true;
        sun.visible = true;
        sun2.visible = true;
        isRun = true;

        strumLines.members[0].characters[0].scale.set(0.6, 0.6);
    }
    
}
function dark(blabla) {
    trace(blabla);
    if(blabla == '0'){
        
        bgB.alpha = 1;
    }
    if(blabla == '0.5'){
        FlxTween.tween(paceFall, {y: -20}, 5, {ease: FlxEase.backOut});
        FlxTween.tween(paceFall2, {y: 0}, 5, {ease: FlxEase.backOut});
    }
    if(blabla == '1'){
        bgB.alpha = 0;
        paceFall2.visible = false;
        paceFall.visible = false;
    }
    if(blabla == '3'){
        paceFall2.animation.play('pre-scared');
        paceFall.animation.play('pre-scared');
    }
    if(blabla == '4'){
        paceFall2.animation.play('scared');
        paceFall.animation.play('scared');
    }
    if(blabla == '5'){
        strumLines.members[0].characters[0].visible = false;
        strumLines.members[3].characters[0].visible = true;
    }
    if(blabla == '10'){
        camGame.visible = false;
        camHUD.visible = false;
    }
}
function bgSet(bgSetFun:Int) {
    if(bgSetFun == '0' || bgSetFun == 0){
        prlBG.alpha     = 1;
        redBG.alpha     = 0;
        redBG2.alpha    = 0;
        redFog.alpha    = 0;
        redFog2.alpha   = 0;
    }else if(bgSetFun == '0.5' || bgSetFun == 0.5){
        blackP.visible = false;
        prlBG.alpha     = 1;
        redBG.alpha     = 0;
        redBG2.alpha    = 0;
        redFog.alpha    = 0;
        redFog2.alpha   = 0;
    }else if(bgSetFun == '1' || bgSetFun == 1){
        prlBG.alpha     = 0;
        redBG.alpha     = 1;
        redBG2.alpha    = 0;
        redFog.alpha    = 0;
    }else if(bgSetFun == '2' || bgSetFun == 2){
        prlBG.alpha     = 0;
        redBG.alpha     = 1;
        redBG2.alpha    = 1;
        redFog.alpha    = 1;
        redFog2.alpha   = 1;
    }else if(bgSetFun == '3' || bgSetFun == 3){
        prlBG.alpha     = 1;
        redBG.alpha     = 1;
        redBG2.alpha    = 1;
        redFog.alpha    = 1;
        redFog2.alpha   = 1;
    }
}

function layerChange() {
    remove(strumLines.members[1].characters[0]); // Временно убираем paceFall2
    insert(members.indexOf(strumLines.members[2].characters[0]), strumLines.members[1].characters[0]);
}

function create() {
    strumLines.members[0].characters[0].visible = true;
    strumLines.members[3].characters[0].visible = false;
    gradiRed = FlxGradient.createGradientFlxSprite(1, 1080, [FlxColor.BLACK, FlxColor.PURPLE]);
    gradiRed.scale.x = FlxG.width + 1300;
    gradiRed.scale.y ++;
	gradiRed.updateHitbox();
    gradiRed.screenCenter();
    //gradiRed.blend = BlendMode.DARKEN;
	gradiRed.active = true;
    //gradiRed.shader = skyset;
	gradiRed.scrollFactor.set(0, 0);
	//add(gradiRed);
    insert(members.indexOf(gf), gradiRed);

    paceSky = new FlxBackdrop(Paths.image('stages/pace/v1/prun/pacesky'), 1, 0);
    paceSky.scale.set(2, 2);
    paceSky.velocity.set(-650 - 100, 0);
    insert(members.indexOf(gf), paceSky);
    paceSky.y = 200;

    sun = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	insert(members.indexOf(gf),sun);
    sun2 = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	insert(members.indexOf(gf),sun2);

    backDrop = new FlxBackdrop(Paths.image('menus/qube'));
    //backDrop.velocity.set(-150, 50);
    backDrop.scale.set(1, 1);
    insert(members.indexOf(prlBG), backDrop);
    backDrop.blend = BlendMode.DARKEN;

    pacefloor = new FlxBackdrop(Paths.image('stages/pace/v1/prun/floor'), 1, 0);
    pacefloor.scale.set(1.5, 1.5);
    pacefloor.velocity.set(-850 - 100, 0);
    insert(members.indexOf(gf), pacefloor);
    pacefloor.y = 1000;

    paceLegs = new FlxSprite(700, 100);
    paceLegs.frames = Paths.getSparrowAtlas('stages/pace/v1/prun/stanky-leg');
    paceLegs.animation.addByPrefix('idle', 'stanky-leg idle', 15, true);
    paceLegs.animation.play('idle');
    paceLegs.updateHitbox();
    paceLegs.screenCenter();
    paceLegs.scale.set(0.6, 0.6);
    paceLegs.y += 400;
    paceLegs.x += 110;
    insert(members.indexOf(boyfriend), paceLegs);
    paceLegs.visible = false;

    fgtree = new FlxBackdrop(Paths.image('stages/pace/v1/prun/fgtree'), 1, 0);
    fgtree.scale.set(1.3, 3);
    fgtree.velocity.set(-1050 - 100, 0);
    add(fgtree);
    fgtree.y = 300;
    
    redFog2.visible = false;
    fgtree.visible = false;
    paceSky.visible = false;
    pacefloor.visible = false;
    sun.visible = false;
    sun2.visible = false;

    paceFall = new FlxSprite();
    paceFall.frames = Paths.getSparrowAtlas('stages/pace/v1/paceFalling');
    paceFall.animation.addByPrefix('idle', 'idle', 5, true);
    paceFall.animation.addByPrefix('pre-scared', 'pre-scared', 5, false);
    paceFall.animation.addByPrefix('scared', 'scared', 5, true);
    paceFall.updateHitbox();
    paceFall.screenCenter();
    paceFall.y = -600;
    paceFall.animation.play('idle');
    paceFall.scale.set(0.6, 0.6);
    paceFall.camera = camHUD;
    add(paceFall);
    paceFall.visible = true;

    paceFall2 = new FlxSprite();
    paceFall2.frames = Paths.getSparrowAtlas('stages/pace/v1/pacecut');
    paceFall2.animation.addByPrefix('idle', 'pacecut shake', 5, true);
    paceFall2.animation.addByPrefix('pre-scared', 'pacecut look', 10, false);

    // Разворачиваем кадры анимации 'pre-scared' в обратном порядке
    var anim = paceFall2.animation.getByName('pre-scared');
    if (anim != null) {
        anim.frames.reverse(); // <- Вот это развернёт анимацию
    }

    paceFall2.scale.set(0.3, 0.3);
    paceFall2.updateHitbox();
    paceFall2.screenCenter();
    paceFall2.y = -600;
    paceFall2.animation.play('idle');
    paceFall2.camera = camHUD;
    paceFall2.angle = 180;
    paceFall2.visible = false;
    add(paceFall2);

    bgB = new FlxSprite(-700, 0);
    bgB.makeGraphic(1400, 1400, FlxColor.WHITE);
    bgB.color = 0x000008;
    add(bgB);
    bgB.scale.set(3, 3);
    bgB.alpha = 0;
    bgB.blend = BlendMode.DARKEN;

    vignette = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/vignette'));
    vignette.camera = camHUD;
    vignette.screenCenter();
	insert(members.indexOf(strumLines),vignette);

    redFog.updateHitbox();
    redFog2.updateHitbox();
    redFog.screenCenter();
    redFog2.screenCenter();

    blackP = new FlxSprite();
    blackP.makeGraphic(1400, 1400, FlxColor.BLACK);
    blackP.updateHitbox();
    blackP.screenCenter();
    add(blackP);
    blackP.camera = camHUD;

    paceCutG = new FlxSprite();
    paceCutG.frames = Paths.getSparrowAtlas('stages/pace/v1/pacecut');
    paceCutG.animation.addByPrefix('idle', 'pacecut shake', 5, true);
    paceCutG.animation.addByPrefix('pre-scared', 'pacecut look', 10, false);

    // Разворачиваем кадры анимации 'pre-scared' в обратном порядке
    var anim = paceCutG.animation.getByName('pre-scared');
    if (anim != null) {
        anim.frames.reverse(); // <- Вот это развернёт анимацию
    }

    paceCutG.scale.set(0.3, 0.3);
    paceCutG.updateHitbox();
    paceCutG.screenCenter();
    paceCutG.animation.play('idle');
    paceCutG.camera = camHUD;
    paceCutG.visible = false;
    add(paceCutG);

    bgSet(0);

    cut1bg = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/cut1bg'));
    cut1bg.visible = false;
    cut1bg.screenCenter();
    cut1bg.camera = camHUD;
    add(cut1bg);

    cut1floor = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/cut1floor'));
    cut1floor.visible = false;
    cut1floor.screenCenter();
    cut1floor.camera = camHUD;
    add(cut1floor);

    paceCut = new FlxSprite();
    paceCut.frames = Paths.getSparrowAtlas('stages/pace/v1/prun/pace-falling');
    paceCut.animation.addByPrefix('falling', 'pace-falling falling', 10, false);
    var anim2 = paceCut.animation.getByName('falling');
    if (anim2 != null) {
        anim2.frames.reverse(); // <- Вот это развернёт анимацию
    }
    paceCut.camera = camHUD;
    paceCut.scale.set(0.6, 0.6);
    paceCut.screenCenter();
    add(paceCut);
    paceCut.visible = false;

    paceCut2 = new FlxSprite();
    paceCut2.frames = Paths.getSparrowAtlas('stages/pace/v1/prun/pace');
    paceCut2.animation.addByPrefix('falling', 'pace fallin', 10, false);
    var anim2 = paceCut2.animation.getByName('falling');
    if (anim2 != null) {
        anim2.frames.reverse(); // <- Вот это развернёт анимацию
    }
    paceCut2.camera = camHUD;
    paceCut2.scale.set(0.6, 0.6);
    paceCut2.screenCenter();
    add(paceCut2);
    paceCut2.visible = false;

    //camHUD.alpha = 0;
}
//    	cameraNotePoint.x = FlxMath.lerp(cameraNotePoint.x, noteOffsets[0], camFollowRate); 
//	cameraNotePoint.y = FlxMath.lerp(cameraNotePoint.y, noteOffsets[1], camFollowRate); 
var localTime:Float = 0;
var vignetteFade = 0;

function cutsene() {
    trace('hi');
    paceCut.visible = true;
    paceCut.animation.play('falling');
    cut1bg.visible = true;
    cut1floor.visible = true;
    new FlxTimer().start(0.7, function(tmr:FlxTimer)
    {
        paceCut.visible = false;
        cut1bg.visible = true;
        cut1bg.color = 0x797979;
        cut1floor.visible = false;
        paceCut2.visible = true;
        paceCut2.animation.play('falling');
    });
    new FlxTimer().start(1.5, function(tmr:FlxTimer)
    {
        paceCut.visible = false;
        cut1bg.visible = false;
        cut1bg.color = 0x797979;
        cut1floor.visible = false;
        paceCut2.visible = false;
        paceCut2.animation.play('falling');
    });
}

function update(elapsed:Float) {
    localTime += elapsed;
    aura.iTime = localTime;
    backDrop.angle -= 0.04;
    snowfall.iTime = localTime;

    vignette.alpha = FlxMath.lerp(vignette.alpha, vignetteFade, 0.15);

    sun.angle -= 0.04;
    sun2.angle += 0.04;

    redFog2.angle -= 0.04;
    redFog.angle += 0.04;
    backDrop.velocity.set(FlxMath.lerp(backDrop.velocity.x, noteOffsets[0], 0.04), FlxMath.lerp(backDrop.velocity.y, noteOffsets[1], 0.04));
    for (i in strumLines.members[curCameraTarget].characters){
        switch(i.getAnimName()){
            case "singLEFT" | "singLEFT-alt":
                noteOffsets = [-noteMoveAmt, 0];
            case "singDOWN" | "singDOWN-alt":
                noteOffsets = [0, noteMoveAmt];
            case "singUP" | "singUP-alt":
                noteOffsets = [0, -noteMoveAmt];
            case "singRIGHT" | "singRIGHT-alt":
                noteOffsets = [noteMoveAmt, 0];
            case "idle":
                noteOffsets = [10, -10];
        }
    }

    var shadowScale = 1 + PlayState.instance.defaultCamZoom - camGame.zoom;

    if (!isRun){
        strumLines.members[0].characters[0].scale.set(shadowScale, shadowScale);
        if(strumLines.members[curCameraTarget].characters[curCameraTarget] == strumLines.members[0].characters[0]){
            camGame.zoom = FlxMath.lerp(camGame.zoom, 1.2, 0.05);
            vignetteFade = 1;
        }else {
            vignetteFade = 0;
        }
    }
    
}
var glitchTween:FlxTween;
function shaderAnim() {
    snowfall.glitchAmount = 1;
    if(glitchTween != null) {
		glitchTween.cancel();
	}
    glitchTween = FlxTween.tween(snowfall, {glitchAmount: 0.0001}, 0.5);
}