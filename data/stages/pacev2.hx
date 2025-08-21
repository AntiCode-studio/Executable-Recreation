import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;
import flixel.addons.effects.FlxTrail;

var isRun = false;
var vignetteFade = 0;
aura = new CustomShader('Aura');
snowfall = new CustomShader('GlitchShaderA');

wave = new CustomShader('wave');
var isRun = false;

public var dadTrail:FlxTrail;

function paceRun(trueOrFalse:Bool) {
    trace(trueOrFalse);
    if(trueOrFalse =="false"){
        paceLegs.visible = false;
        strumLines.members[0].characters[0].x = 400;
        strumLines.members[0].characters[0].y = 50;
        strumLines.members[1].characters[0].x = 300;
        strumLines.members[1].characters[0].y = 100;
        fgtree.visible = false;
        paceSky.visible = false;
        pacefloor.visible = false;
        sun.visible = false;
        sun2.visible = false;
        isRun = false;
        dadTrail.visible = true;
    }else{
        paceLegs.visible = true;
        //strumLines.members[0].characters[1].visible = true;
        //strumLines.members[0].characters[0].visible = false;
        strumLines.members[0].characters[0].x = 738;
        strumLines.members[0].characters[0].y = 103;
        strumLines.members[1].characters[0].x = 392;
        strumLines.members[1].characters[0].y = 121;
        fgtree.visible = true;
        paceSky.visible = true;
        pacefloor.visible = true;
        sun.visible = true;
        sun2.visible = true;
        isRun = true;
        dadTrail.visible = false;

        strumLines.members[0].characters[0].scale.set(0.6, 0.6);
    }
    
}

function phaceChange(phace:Bool) {
    trace(phace);
    if(phace == "true"){
        floor.visible = true;
        bg1.visible = true;
        bg.visible = true;
        floorp3.visible = false;
        bg1p3.visible = false;
        bgp3.visible = false;
    }else {
        floor.visible = false;
        bg1.visible = false;
        bg.visible = false;
        floorp3.visible = true;
        bg1p3.visible = true;
        bgp3.visible = true;
    }
    if (phace == 'final'){
        dadTrail.visible = false;
        isRun = true;
        bgF.visible = true;
        //shadowFake.visible = true;
        ostrov.visible = true;
        //shadowBig.visible = true;
    }
    if (phace == 'final2'){
        for (i in [strumLines.members[3].characters[0], strumLines.members[3].characters[1], strumLines.members[3].characters[3], strumLines.members[3].characters[4], strumLines.members[3].characters[2]]){
            remove(i);
            insert(members.indexOf(shadowBig), i);
            i.visible = true;
        }

        strumLines.members[3].characters[0].x -= 800;
        strumLines.members[3].characters[0].y += 400;
        strumLines.members[3].characters[0].angle = -10;
        strumLines.members[3].characters[0].scale.set(1.2, 1.2);
        strumLines.members[3].characters[0].scrollFactor.set(0.8, 0.8);

        strumLines.members[3].characters[1].x += 1000;
        strumLines.members[3].characters[1].y += 1000;
        strumLines.members[3].characters[1].angle = 5;
        strumLines.members[3].characters[1].scale.set(2, 2);
        strumLines.members[3].characters[1].scrollFactor.set(1.2, 1.2);

        strumLines.members[3].characters[2].x += 100;
        strumLines.members[3].characters[2].y += 600;
        strumLines.members[3].characters[2].angle = 2;
        strumLines.members[3].characters[2].scale.set(0.8, 0.8);
        strumLines.members[3].characters[2].scrollFactor.set(0.6, 0.6);

        strumLines.members[3].characters[3].x += 900;
        strumLines.members[3].characters[3].y += 100;
        strumLines.members[3].characters[3].angle = -2;
        strumLines.members[3].characters[3].scale.set(0.9, 0.9);
        strumLines.members[3].characters[3].scrollFactor.set(0.7, 0.7);

        strumLines.members[3].characters[4].x -= 1000;
        strumLines.members[3].characters[4].y += 900;
        strumLines.members[3].characters[4].angle = 4;
        strumLines.members[3].characters[4].scale.set(0.6, 0.6);
        strumLines.members[3].characters[4].scrollFactor.set(0.4, 0.4);

        dadTrail.visible = false;
        isRun = true;
        bgF.visible = true;
        //shadowFake.visible = true;
        ostrov.visible = true;
        shadowBig.visible = true;
    }
    if (phace == 'final3'){

        dadTrail.visible = false;
        isRun = true;
        bgF.visible = true;
        shadowFake.visible = true;
        ostrov.visible = true;
        shadowBig.visible = true;
    }
    if (phace == 'end'){

        glitchTween = FlxTween.tween(snowfall, {glitchAmount: 1}, 10);
        FlxTween.tween(camGame, {alpha: 0}, 10);
    }
}

function dark(blabla) {
    trace(blabla);
    if(blabla == '0'){
        
        bgB.alpha = 1;
    }
    if(blabla == '0.5'){
        
        paceFall2.visible = true;
        paceFall.visible = true;
        FlxTween.tween(paceFall, {y: 120}, 5, {ease: FlxEase.backOut});
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
        strumLines.members[4].characters[0].visible = true;

        dadTrail.visible = false;

        s2.visible = true;

        remove(strumLines.members[1].characters[0]);
        insert(members.indexOf(strumLines.members[4].characters[0]), strumLines.members[1].characters[0]);

        strumLines.members[1].characters[0].alpha = 0.6;
    }
    if(blabla == '6'){
        floor.visible = false;
        bg1.visible = false;
        bg.visible = false;
        strumLines.members[1].characters[0].visible = false;
    }
    if(blabla == '7'){
        floor.visible = true;
        bg1.visible = true;
        bg.visible = true;
        strumLines.members[1].characters[0].visible = true;
    }
    if(blabla == '10'){
        camGame.visible = false;
        camHUD.visible = false;
    }
    if(blabla == '5.5'){
        strumLines.members[0].characters[0].visible = true;
        strumLines.members[4].characters[0].visible = false;

        strumLines.members[1].characters[0].alpha = 1;

        s2.visible = false;

        remove(strumLines.members[1].characters[0]);
        insert(members.indexOf(strumLines.members[0].characters[0]), strumLines.members[1].characters[0]);

        remove(strumLines.members[0].characters[0]);
        insert(members.indexOf(strumLines.members[1].characters[0]), strumLines.members[0].characters[0]);
    }
}

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

function postCreate() {

    for (i in [strumLines.members[3].characters[0], strumLines.members[3].characters[1], strumLines.members[3].characters[3], strumLines.members[3].characters[4], strumLines.members[3].characters[2], strumLines.members[4].characters[0]]){
        i.visible = false;
    }
    
    importScript("data/huds/maniav1");

    dadTrail = new FlxTrail(dad, null, 4, 10, 0.3, 0.069);
    dadTrail.beforeCache = dad.beforeTrailCache;
    dadTrail.afterCache = () -> {
		dad.afterTrailCache();
        dadTrail.members[0].x += FlxG.random.float(-1, 4);
		dadTrail.members[0].y += FlxG.random.float(-1, 4);
	}
    insert(members.indexOf(dad), dadTrail);

    camGame.addShader(aura);
    snowfall.glitchAmount = 0.0001;
    camGame.addShader(snowfall);
    camHUD.addShader(snowfall);

    wave.frequency = 0;
    wave.amplitude = 0;

    bg1.shader = wave;
    bg1p3.shader = wave;

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

    fgtree = new FlxBackdrop(Paths.image('stages/pace/v2/p2/trees'), 1, 0);
    fgtree.velocity.set(-1050 - 650, 0);
    fgtree.scale.set(0.6, 0.6);
    add(fgtree);
    fgtree.y = 300 - 500;

    paceSky = new FlxBackdrop(Paths.image('stages/pace/v2/p2/bg'), 1, 0);
    paceSky.scale.set(0.6, 0.6);
    paceSky.velocity.set(-650 - 650, 0);
    insert(members.indexOf(gf), paceSky);
    paceSky.y = 220 - 500;

    sun = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	//insert(members.indexOf(gf),sun);
    sun2 = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	//insert(members.indexOf(gf),sun2);

    pacefloor = new FlxBackdrop(Paths.image('stages/pace/v2/p2/floor'), 1, 0);
    pacefloor.scale.set(0.6, 0.6);
    pacefloor.velocity.set(-850 - 650, 0);
    insert(members.indexOf(gf), pacefloor);
    pacefloor.y = 300 - 500;

    fgtree.visible = false;
    paceSky.visible = false;
    pacefloor.visible = false;
    sun.visible = false;
    sun2.visible = false;

    floorp3.visible = false;
    bg1p3.visible = false;
    bgp3.visible = false;

    blackP = new FlxSprite();
    blackP.makeGraphic(1400, 1400, FlxColor.BLACK);
    blackP.updateHitbox();
    blackP.screenCenter();
    add(blackP);
    blackP.camera = camHUD;
    blackP.visible = false;

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

    bgB = new FlxSprite(-700, 0);
    bgB.makeGraphic(1400, 1400, FlxColor.WHITE);
    bgB.color = 0x000008;
    add(bgB);
    bgB.scale.set(3, 3);
    bgB.alpha = 0;
    bgB.blend = BlendMode.DARKEN;

    paceFall = new FlxSprite();
    paceFall.frames = Paths.getSparrowAtlas('stages/pace/v2/falling');
    paceFall.animation.addByPrefix('idle', 'idle', 5, true);
    paceFall.animation.play('idle');
    paceFall.scale.set(0.2, 0.2);
    //paceFall.camera = camHUD;
    paceFall.scrollFactor.set(0,0);
    paceFall.updateHitbox();
    paceFall.screenCenter();
    paceFall.y = -600;
    add(paceFall);
    paceFall.visible = false;

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
    //add(paceFall2);

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

    s2 = new FlxSprite();
    s2.frames = Paths.getSparrowAtlas('stages/pace/v2/p3/S2');
    s2.animation.addByPrefix('idle', 'S2 S', 10, true);
    s2.scale.set(1, 1);
    s2.screenCenter();
    insert(members.indexOf(gf), s2);
    s2.animation.play('idle');
    s2.x += 200;
    s2.y += 200;
    s2.visible = false;

    bgF = new FlxSprite(-700, 0);
    bgF.makeGraphic(1400, 1400, FlxColor.BLACK);
    bgF.scrollFactor.set(0,0);
    insert(members.indexOf(gf), bgF);
    bgF.scale.set(3, 3);
    bgF.visible = false;
    
    shadowBig = new FlxSprite(-800,-300).loadGraphic(Paths.image('stages/pace/v2/finale/shadow big'));
    shadowBig.scale.set(1, 1);
    shadowBig.updateHitbox();
    insert(members.indexOf(gf), shadowBig);
    shadowBig.visible = false;

    ostrov = new FlxSprite(shadowBig.x,shadowBig.y).loadGraphic(Paths.image('stages/pace/v2/finale/flor'));
    ostrov.scale.set(shadowBig.scale.x, shadowBig.scale.y);
    ostrov.updateHitbox();
    insert(members.indexOf(gf), ostrov);
    ostrov.visible = false;

    shadowFake = new FlxSprite(shadowBig.x,shadowBig.y).loadGraphic(Paths.image('stages/pace/v2/finale/shadow'));
    shadowFake.scale.set(shadowBig.scale.x, shadowBig.scale.y);
    shadowFake.updateHitbox();
    insert(members.indexOf(gf), shadowFake);
    shadowFake.visible = false;
    
}
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
function create() {
    vignette = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/vignette'));
    vignette.camera = camHUD;
    vignette.screenCenter();
	insert(members.indexOf(strumLines),vignette);
}
var localTime:Float = 0;

var wavePar1:Float = 0;
var wavePar2:Float = 0;

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
function update(elapsed:Float) {
    sun.angle -= 0.04;
    sun2.angle += 0.04;
    wave.frequency = FlxMath.lerp(wave.frequency, wavePar1, 0.15);
    wave.amplitude = FlxMath.lerp(wave.amplitude, wavePar2, 0.15);

    localTime += elapsed;
    aura.iTime = localTime;
    snowfall.iTime = localTime;
    wave.iTime = localTime;
    var shadowScale = 0.6 + PlayState.instance.defaultCamZoom - camGame.zoom;
    vignette.alpha = FlxMath.lerp(vignette.alpha, vignetteFade, 0.15);
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

function waveShader(frequencyFu:Float = 8.0, amplitudeFu:Float = 0.1) {
    wavePar1 = frequencyFu;
    wavePar2 = amplitudeFu;

    trace(wavePar1, wavePar2);
}
var glitchTween:FlxTween;
function shaderAnim() {
    snowfall.glitchAmount = 1;
    if(glitchTween != null) {
		glitchTween.cancel();
	}
    glitchTween = FlxTween.tween(snowfall, {glitchAmount: 0.0001}, 0.5);
}