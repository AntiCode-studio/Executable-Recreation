import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
introLength = 0;
vcr = new CustomShader('vcr');
aura = new CustomShader('Aura');
camGame.addShader(vcr);
camHUD.addShader(aura);
camGame.addShader(aura);
waveShader = new CustomShader('wave');
waveShader.speed =0.005;
waveShader.intensity = 6;
waveShader.bloom =0;
importScript("data/huds/maniav2");
redpal = new CustomShader('Red');
redpal.bitch = 0.3;
redpal.desaturationAmount = 1;
camGame.addShader(redpal);

glitch = new CustomShader('glitchA');

distort = new CustomShader('Distort');

camGame.addShader(distort);

brightnes = new CustomShader('shader');

//glitchExtraa = new CustomShader('glitchExtra');
//camGame.addShader(glitchExtraa);
//var camMania:FlxCamera;

function postCreate() {
    screen.visible = false;
    //FlxG.cameras.add(camMania, false);
    //camMania.bgColor.alpha = 0;
    logo.camera = camHUD;
    logo.screenCenter();
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

    clockBG = new FlxBackdrop(Paths.image('stages/epilepsia/clock1'), 1, 0);
    clockBG.y = clockBG.y + 50;
    clockBG.velocity.x = -100;
    clockBG.scale.set(2, 2);
    clockBG.antialiasing = true;
    clockBG.alpha = 0;
    clocksChanging('1');
    clockBG.shader = waveShader;
    insert(members.indexOf(bgB), clockBG);

    clockBG1 = new FlxBackdrop(Paths.image('stages/epilepsia/clock2'), 1, 0);
    clockBG1.y = clockBG1.y + 50;
    clockBG1.velocity.x = -100;
    clockBG1.scale.set(2, 2);
    clockBG1.antialiasing = true;
    clockBG1.alpha = clockBG.alpha;
    clockBG1.shader = waveShader;
    insert(members.indexOf(clockBG), clockBG1);

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
    img1.screnCenter();
    img2.screnCenter();
    img3.screnCenter();
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
        });
    }
}

camHUD.alpha = 0;
var tweenArray:Array<FlxTween> = [];

function onSongStart() {
    doTweenZoom(2, 23 ,FlxEase.expoIn);
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
function stepMania(par) {
    switch (Std.parseInt(par)) {
        case 0:
            camHUD.alpha = 1;
            stageStart.visible=false;
            camGame.setFilters();
            //camGame.addShader(brightnes);
            doTweenZoom(0.8, 1 ,FlxEase.expoOut);
            startTimer('1');
            //camGame.addShader(vcr);
            //camGame.addShader(glitchExtraa);
        case 1:
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
            doTweenZoom(2, 3 ,FlxEase.expoInOut);
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
            doTweenZoom(0.6, 0.1 ,FlxEase.expoOut);
            camGame.setFilters();
            camGame.addShader(aura);
            cincoBG.alpha = 1;
        case 5:
            camGame.setFilters();
            camGame.addShader(aura);
            stageStart.visible=false;
            cincoBG.alpha = 0;
            quatroBG.alpha = 1;
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
            doTweenZoom(0.95, 0.1 ,FlxEase.expoOut);
        case 9:
            tressBG.velocity.x = -1500;
            tressBGAlt.velocity.x = -1500;
            tressBGAlt.visible = true;
        case 10:
            tweenArray[0] = FlxTween.tween(bgB, {alpha: 1}, 0.7, { ease: FlxEase.expoOut, onComplete: function(f:FlxTween) {
            }
            });
        case 11:
            camGame.addShader(distort);
            camGame.addShader(brightnes);
            camGame.addShader(glitch);
        case 12:
            camGame.addShader(distort);
            camGame.zoom = 2;
            stageStart.visible=true;
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
            tweenArray[5] = FlxTween.tween(logo, {alpha: 1}, 2, { ease: FlxEase.expoIn, onComplete: function(f:FlxTween) {
                new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        tweenArray[5] = FlxTween.tween(logo, {alpha: 0}, 2, { ease: FlxEase.expoIn, onComplete: function(f:FlxTween) {
                        }
                        });
                    });
            }
            });
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
            tweenArray[10] = FlxTween.tween(camHUD, {alpha: 0}, 1, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
            }
            });
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
        //case 24:
        //    tweenArray[5] = FlxTween.tween(glitchExtraa, {GlitchAmount: 50}, 3, { ease: FlxEase.linear, onComplete: function(f:FlxTween) {
        //    }
        //    });
    }
}