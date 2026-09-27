import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import flixel.effects.FlxFlicker;


var camFRAMES:FlxCamera = new FlxCamera();

FlxG.cameras.add(camFRAMES, false);
camFRAMES.bgColor = FlxColor.TRANSPARENT;

introLength = 0;
vcr = new CustomShader('vcr');
aura = new CustomShader('Aura');
//camGame.addShader(vcr);
camFRAMES.addShader(vcr);
//camHUD.addShader(aura);
//camGame.addShader(aura);
waveShader = new CustomShader('wave');
waveShader.speed =0.005;
waveShader.intensity = 6;
waveShader.bloom =0;
importScript("data/huds/maniav3");
redpal = new CustomShader('Red');
redpal.bitch = 0.3;
redpal.desaturationAmount = 1;
camGame.addShader(redpal);
camFRAMES.addShader(redpal);
portVisible = false;
timeVisible = false;

glitch = new CustomShader('glitchA');

distort = new CustomShader('Distort');

camGame.addShader(distort);

brightnes = new CustomShader('shader');

//glitchExtraa = new CustomShader('glitchExtra');
//camGame.addShader(glitchExtraa);
//var camMania:FlxCamera;

var bgSpeed = -100;

var flicker:FlxFlicker;

function bgSpeedChange(values) {
    bgSpeed = values;
    clockBG.velocity.x = bgSpeed;
    clockBG1.velocity.x = bgSpeed;
}
var objs:Array<FlxSprite> = [];
function postCreate() {

    stageStart1.blend = 0;
    stageStart1.alpha = 0.5;
    // flicker = new FlxFlicker().flicker(stageStart1, 5000, 0.01, true, true);

    screen.visible = false;
    //FlxG.cameras.add(camMania, false);
    //camMania.bgColor.alpha = 0;
    //logo.camera = camHUD;
    //logo.screenCenter();
    //bgE.shader = waveShader;
    tressBG = new FlxBackdrop(Paths.image('stages/epilepsia/Rixa'), 1, 0);
    tressBG.y = tressBG.y + 50;
    tressBG.velocity.x = -100;
    tressBG.scale.set(2, 2);
    tressBG.alpha = 0;
    insert(members.indexOf(dad), tressBG);

    tressBGAlt = new FlxBackdrop(Paths.image('stages/epilepsia/RixaDarck'), 1, 0);
    tressBGAlt.y = tressBGAlt.y + 50;
    tressBGAlt.velocity.x = -100;
    tressBGAlt.scale.set(2, 2);
    tressBGAlt.visible = false;
    insert(members.indexOf(dad), tressBGAlt);

    sonicTress = new FlxSprite(-450, 200);
	sonicTress.frames = Paths.getSparrowAtlas('stages/epilepsia/sonicRun');
	sonicTress.animation.addByPrefix('idle','idle',24);
    sonicTress.animation.addByPrefix('preRun','trans',24);
    sonicTress.animation.addByPrefix('run1','run0',45);
    sonicTress.animation.addByPrefix('run2','run2',45);
    sonicTress.antialiasing = true;
	sonicTress.animation.play('idle');
    sonicTress.scale.set(1.5, 1.5);
    sonicTress.visible = false;
	add(sonicTress);

    clockBG = new FlxBackdrop(Paths.image('stages/epilepsia/clock1'));
    clockBG.y = clockBG.y + 50;
    clockBG.velocity.x = bgSpeed;
    clockBG.scale.set(1, 1);
    clockBG.antialiasing = true;
    clockBG.alpha = 0;
    clocksChanging('1');
    //clockBG.shader = waveShader;
    insert(members.indexOf(circle), clockBG);

    clockBG1 = new FlxBackdrop(Paths.image('stages/epilepsia/clock2'));
    clockBG1.y = clockBG1.y + 50;
    clockBG1.velocity.x = bgSpeed;
    clockBG1.scale.set(1, 1);
    clockBG1.antialiasing = true;
    clockBG1.alpha = clockBG.alpha;
    //clockBG1.shader = waveShader;
    insert(members.indexOf(circle), clockBG1);

    cincoBG.alpha = 0;
    quatroBG.alpha = 0;
    strumLines.members[0].characters[1].alpha = 0;
    strumLines.members[0].characters[1].camera = camHUD;
    strumLines.members[0].characters[1].screenCenter();

    img1.camera = camHUD;
    img2.camera = camHUD;
    img3.camera = camHUD;
    img1.visible = false;
    img2.visible = false;
    img3.visible = false;
    img1.screenCenter();
    img2.screenCenter();
    img3.screenCenter();

    cutImg1.camera = camFRAMES;
    cutImg2.camera = camFRAMES;
    cutImg3.camera = camFRAMES;
    cutImg4.camera = camFRAMES;
    cutImg1.screenCenter();
    cutImg2.screenCenter();
    cutImg3.screenCenter();
    cutImg4.screenCenter();
    cutImg1.setGraphicSize(1280);
    cutImg2.setGraphicSize(1280);
    cutImg3.setGraphicSize(1280);
    cutImg4.setGraphicSize(1280);
    cutImg1.visible = false;
    cutImg2.visible = false;
    cutImg3.visible = false;
    cutImg4.visible = false;

    count5.camera = camFRAMES;
    count5.screenCenter();
    count4.camera = camFRAMES;
    count4.screenCenter();
    count3.camera = camFRAMES;
    count3.screenCenter();
    count2.camera = camFRAMES;
    count2.screenCenter();
    count1.camera = camFRAMES;
    count1.screenCenter();

    count5.alpha = 0;
    count4.alpha = 0;
    count3.alpha = 0;
    count2.alpha = 0;
    count1.alpha = 0;

    for (i in 1...7){
        i = new FunkinSprite().loadGraphic(Paths.image('stages/epilepsia/bitch/pendrive' + i));
        i.zoomFactor = 0.2;
        i.scrollFactor.set(0,0);
	    add(i);
        i.setGraphicSize(1280);
        i.updateHitbox();
        i.screenCenter();
        i.visible = false;
        i.ID ++;
        i.alpha = 0;
        objs.push(i);
    }

    //trace(objs);

    new FlxTimer().start(0.1, (_) -> [
        randowm = FlxG.random.int(0,5),
        for (i in 0...6){
            //trace(randowm, i, objs[i]);
            if (randowm == i){
                objs[i].visible = true;
                //trace("eah");
            }else{
                objs[i].visible = false;
                //trace("bruh");
            }
        }
    ], 0);

}
var randowm;
function imageFlash(image, show){
    trace(image, show);
    switch(image){
        case '1':
            if(show == ' true'){
                cutImg1.visible = true;
                trace('eha');
            }else{
                cutImg1.visible = false;
                trace('nuh');
            }
        case '2':
            if(show == ' true'){
                cutImg2.visible = true;
            }else{
                cutImg2.visible = false;
            }
        case '3':
            if(show == ' true'){
                cutImg3.visible = true;
            }else{
                cutImg3.visible = false;
            }
        case '4':
            if(show == ' true'){
                cutImg4.visible = true;
            }else{
                cutImg4.visible = false;
                camFRAMES.setFilters();
            }

    }
}

function clocksChanging(onoff) {
    if(onoff == '1'){
        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            clockBG.visible = false;
            clockBG1.visible = true;
            clocksChanging('2');
        });
    }else{
        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            clockBG.visible = true;
            clockBG1.visible = false;
            clocksChanging('1');
            //remove(clockBG);
            //remove(clockBG1);
            //insert(members.indexOf(circle), clockBG);
            //insert(members.indexOf(circle), clockBG1);
            
        });
    }
}

camHUD.alpha = 0;
var tweenArray:Array<FlxTween> = [];

function onSongStart() {
    //doTweenZoom(2, 23 ,FlxEase.expoIn);
    boyfriend.visible = false;
}

counting = 48;
countdowntext = new FlxText(580,200,0,'-'+counting+'-',50);
countdowntext.setFormat(Paths.font("sonic-1-hud-font.ttf"), 50, FlxColor.RED, FlxTextAlign.CENTER);
countdowntext.camera = camHUD;
add(countdowntext);

function startTimer(onoff) {
    if(onoff == '1'){
        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            counting -= 1;
            countdowntext.text = '-'+counting+'-';
            if (counting >= 3){
                startTimer('1');
            }else{
                startTimer('0');
            }
            
        });
    }else{
        new FlxTimer().start(0.01, function(tmr:FlxTimer)
            {
                counting += 1;
                countdowntext.text = '-'+counting+'-';
                if (counting <= 258){
                    startTimer('0');
                }else{
                    startTimer('1');
                }
                
            });
    }
}

function doTweenZoom(zoom, time, ?ease:FlxEase = FlxEase.linear) {
	if (tweenArray[0] != null) tweenArray[0].cancel();
	allowedToBop = false;
	defaultCamZoom = zoom;
	tweenArray[0] = FlxTween.tween(camGame, {zoom: zoom}, time, { ease: ease, onComplete: function(f:FlxTween) {
			allowedToBop = true;
		}
	});
}
var localTime:Float = 0;
function update(elapsed:Float) {
    clockBG1.alpha = clockBG.alpha;
	localTime += elapsed;
	vcr.iTime = localTime;
    aura.iTime = localTime;
    waveShader.iTime = localTime;
    glitch.iTime = localTime;
    redpal.iTime = localTime;
    //glitchExtraa.iTime = localTime;
}
function onPause() {
	for (i in tweenArray) if (i != null) i.active = false;
}

function onResume() {
	for (i in tweenArray) if (i != null) i.active = true;
}

function arrowsCool(){
    for (strum in strumLines.members[1].members) {
        trace(strum.ID);
        switch(strum.ID){
            case 0, 1:
                FlxTween.tween(strum, {x: strum.x - 75}, 1.5, {ease: FlxEase.quintInOut});
            case 2, 3:
                FlxTween.tween(strum, {x: strum.x + 75}, 1.5, {ease: FlxEase.quintInOut});
        }
    }
}

function stepMania(par) {
    switch (Std.parseInt(par)) {
        case 0:
            camHUD.alpha = 1;
            // flicker.stopFlickering();
            stageStart.visible=false;
            stageStart1.alpha = 0;
            camGame.setFilters();
            //camGame.addShader(brightnes);
            //doTweenZoom(0.8, 1 ,FlxEase.expoOut);
            startTimer('1');
            //camGame.addShader(vcr);
            //camGame.addShader(glitchExtraa);
        case 1:
            arrowsCool();
            //glitchExtraa.GlitchAmount = 0.01;
            bgB.alpha = 0;
            clockBG.alpha = 1;
            //camGame.addShader(brightnes);
            camGame.addShader(distort);
            camGame.addShader(aura);
            
        case 2:
            tweenArray[0] = FlxTween.tween(redpal, {bitch: 0, desaturationAmount: 0}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
                }
            });
        case 3:
            clockBG.alpha = 0;
            //doTweenZoom(2, 3 ,FlxEase.expoInOut);
            redpal.bitch = 0.1;
            redpal.desaturationAmount = 1;
            camGame.addShader(distort);
            camGame.addShader(redpal);
            tweenArray[0] = FlxTween.tween(countdowntext, {y: 50}, 3, { ease: FlxEase.expoInOut, onComplete: function(f:FlxTween) {
            }
                });
            tweenArray[1] = FlxTween.tween(redpal, {bitch: 0, desaturationAmount: 0}, 3, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
                }
            });
            
        case 4:
            camGame.addShader(distort);
            //doTweenZoom(0.6, 0.1 ,FlxEase.expoOut);
            camGame.setFilters();
            camGame.addShader(aura);
            cincoBG.alpha = 1;
            for (i=>option in objs) {
                option.alpha = 0;
            }
            FlxTween.tween(count5, {alpha: 0}, 0.5);
            cincoBG.color = 0xFFFFFF;
        case 5:
            camGame.setFilters();
            camGame.addShader(aura);
            stageStart.visible=false;
            stageStart1.visible=false;
            cincoBG.alpha = 0;
            quatroBG.alpha = 1;
            for (i=>option in objs) {
                option.alpha = 0;
            }
        case 6:
            tweenArray[0] = FlxTween.tween(camGame, {alpha: 0}, 2, { ease: FlxEase.expoInOut, onComplete: function(f:FlxTween) {
            }
            });
            strumLines.members[0].characters[1].scale.x = 0.8;
            strumLines.members[0].characters[1].scale.y = 0.8;
            tweenArray[1] = FlxTween.tween(strumLines.members[0].characters[1], {alpha: 1}, 1, { ease: FlxEase.expoInOut, onComplete: function(f:FlxTween) {
            }
            });
        case 7:
            camGame.addShader(distort);
            camGame.alpha = 1;
            strumLines.members[0].characters[1].alpha = 0;
            camGame.setFilters();
            camGame.addShader(aura);
            quatroBG.alpha = 0;
        case 8:
            strumLines.members[0].characters[0].alpha = 0;
            tressBG.alpha = 1;
            sonicTress.visible = true;
            //doTweenZoom(0.95, 0.1 ,FlxEase.expoOut);
            FlxTween.tween(count3, {alpha: 0}, 0.5);
        case 9:
            tressBG.velocity.x = -1500;
            tressBGAlt.velocity.x = -1500;
            tressBGAlt.visible = true;
        case 10:
            tweenArray[0] = FlxTween.tween(bgB, {alpha: 1}, 0.7, { ease: FlxEase.expoOut, onComplete: function(f:FlxTween) {
            }
            });
            tweenArray[1] = FlxTween.tween(clockBG, {alpha: 0}, 0.7, { ease: FlxEase.expoOut, onComplete: function(f:FlxTween) {
            }
            });
        case 11:
            camGame.addShader(distort);
            camGame.addShader(brightnes);
            camGame.addShader(glitch);
            for (i=>option in objs) {
                option.alpha = 1;
            }
            cincoBG.color = 0xFF0000;
        case 12:
            camGame.addShader(distort);
            camGame.zoom = 2;
            stageStart.visible=true;
            stageStart1.visible=true;
            camGame.setFilters();
            //camGame.addShader(brightnes);
            camGame.addShader(vcr);
            camGame.addShader(aura);
            doTweenZoom(0.6, 3 ,FlxEase.expoOut);
        case 13:
            redpal.bitch = 0.1;
            redpal.desaturationAmount = 1;
            camGame.addShader(redpal);
            tweenArray[1] = FlxTween.tween(redpal, {bitch: 0, desaturationAmount: 0}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
                }
            });
            for (i=>option in objs) {
                FlxTween.tween(option, {alpha: 1}, 0.7);
            }
            FlxTween.tween(count4, {alpha: 0}, 0.5);
        case 14:
            camGame.addShader(brightnes);
        case 15:
            tweenArray[1] = FlxTween.tween(strumLines.members[0].characters[1].scale, {x: 1, y: 1}, 17, { ease: FlxEase.expoIn, onComplete: function(f:FlxTween) {
            }
            });
        case 16:
            tweenArray[2] = FlxTween.tween(sonicTress, {x: -100}, 1, { ease: FlxEase.expoIn, onComplete: function(f:FlxTween) {
                sonicTress.animation.play('run1');
                sonicTress.x = 0;
            }
            });
            new FlxTimer().start(0.5, function(tmr:FlxTimer)
            {
                sonicTress.animation.play('preRun');
            });
            new FlxTimer().start(2, function(tmr:FlxTimer)
            {
                sonicTress.animation.play('run2');
                
            });
        case 17:
            for (i=>option in objs) {
                FlxTween.tween(option, {alpha: 1}, 0.7);
            }
        case 18:
            img1.visible = true;
            img2.visible = false;
            img3.visible = false;
        case 19:
            img1.visible = false;
            img2.visible = false;
            img3.visible = false;
        case 20:
            img1.visible = false;
            img2.visible = true;
            img3.visible = false;
        case 21:
            img1.visible = false;
            img2.visible = false;
            img3.visible = true;
        case 22:
            //tweenArray[10] = FlxTween.tween(camHUD, {alpha: 0}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
            //}
            //});
            tweenArray[9] = FlxTween.tween(tressBG, {alpha: 0}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
            }
            });
            tweenArray[8] = FlxTween.tween(tressBGAlt, {alpha: 0}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
            }
            });
            tweenArray[7] = FlxTween.tween(sonicTress, {alpha: 0}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
            }
            });
        case 23:
            tweenArray[10] = FlxTween.tween(camHUD, {alpha: 1}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
            }
            });
            doTweenZoom(0.7, 1 ,FlxEase.expoOut);
        case 24:
            FlxTween.tween(count4, {alpha: 1}, 0.5);
        case 25:
            FlxTween.tween(count3, {alpha: 1}, 0.5);
        case 26:
            FlxTween.tween(count5, {alpha: 1}, 0.5);
    }
}