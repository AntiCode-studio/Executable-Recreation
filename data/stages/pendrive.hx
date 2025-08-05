
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import lime.app.Application;


importScript("data/huds/maniav1");
//intro sprites
var computerbg2:FlxSprite;
var computer:FlxSprite;
var computer2:FlxSprite;
var desk:FlxSprite;
var computerbg:FlxSprite;
var firstbgOffsets:Array<Float> = [0, 150];
var firstBGGroup:Array<FlxSprite> = [];
var jumpscare:FlxSprite;

//p2 sprites
var circle:FlxSprite;
var swirlsbg:FlxSprite;

//p3 sprites
var swirlsbg2:FlxSprite;
var fog:FlxSprite;




//shaders
var waveShader:FlxRuntimeShader;
var angrychromaticShader:FlxRuntimeShader;
var chromaticShader:FlxRuntimeShader;
var mosaicShader:FlxRuntimeShader;
var camGameShaders:Array<BitmapFilter> = [];
var iTimeShaders:Array<FlxRuntimeShader> = [];


//extra functionality
var camOffset:Float = 15;
var beatPerZoom:Int = 4;
var allowedToBop:Bool = true;
var baseCamOffsets:Array<Float> = [0,0];
var camZooming:Bool = false;

var tweenArray:Array<FlxTween> = [];

var countdowntext:FlxText;

//var numberGroup:FlxTypedGroup<FlxText>;
var numberArray:Array<FlxText> = [];


//add behind dad breaks camgame fade? so whatever
var fadeToBlack:FlxSprite;

var localTime:Float = 0;
function update(elapsed:Float) {
	localTime += elapsed;
	waveShader.iTime = localTime;
}
function onCountdown(event) event.cancel();
function postCreate() {
	introLength = 0;
	//shders
	waveShader = new CustomShader('wave');
	waveShader.speed = 0.0025;
	waveShader.intensity = 6;
	waveShader.bloom = 0;
	iTimeShaders.push(waveShader);

	boyfriend.alpha = 0;
	gf.alpha = 0;
	//fixes voices playing on first boot during loading in
	vocals.volume = 0;

	//swirlsbg = new FlxSprite(0,50).loadGraphic(Paths.image('bgs/penbg'));
	//insert(members.indexOf(dad),swirlsbg);
	swirlsbg.antialiasing = true;

	circle = new FlxSprite(-20).loadGraphic(Paths.image('bgs/circle'));
	insert(members.indexOf(dad),circle);
	circle.scale.x = 0.75;

	swirlsbg2 = new FlxSprite(0,50).loadGraphic(Paths.image('bgs/penbg2'));
	insert(members.indexOf(dad),swirlsbg2);
	swirlsbg2.antialiasing = true;
	swirlsbg2.visible = false;

	swirlsbg.shader = waveShader;
	swirlsbg2.shader = waveShader;

	fog = new FlxSprite(0,50).loadGraphic(Paths.image('bgs/fog3'));
	insert(members.indexOf(dad),fog);
	fog.scale.set(2,2);
	fog.antialiasing = true;
	fog.visible = false;

	computerbg2 = new FlxSprite().loadGraphic(Paths.image('bgs/bgthingreal'));
	insert(members.indexOf(dad),computerbg2);

	computer2 = new FlxSprite().loadGraphic(Paths.image('bgs/compute2'));
	insert(members.indexOf(dad),computer2);

	desk = new FlxSprite().loadGraphic(Paths.image('bgs/desk'));
	insert(members.indexOf(dad),desk);

	jumpscare = new FlxSprite();
	jumpscare.frames = Paths.getSparrowAtlas('bgs/jump');
	jumpscare.animation.addByPrefix('i','i',24);
	//jumpscare.animation.play('i');
	jumpscare.scale.set(0.6,0.6);
	jumpscare.visible = false;
	add(jumpscare);

	computer = new FlxSprite().loadGraphic(Paths.image('bgs/computer'));
	add(computer);

	computerbg = new FlxSprite().loadGraphic(Paths.image('bgs/frame'));
	add(computerbg);
	firstBGGroup = [computerbg2,computer2,desk,computer,computerbg];

	for (i in firstBGGroup) {
		i.x = -275;
		i.y = 75;
		i.antialiasing = true;
		i.scale.set(1.25, 1.25);
		i.updateHitbox();
	}



	chromaticShader = new CustomShader('chromAbb');
	chromaticShader.amount = 0;
	computer.shader = chromaticShader; 
	
	mosaicShader = new CustomShader('mosaic');
	mosaicShader.pixel = 0.1;

	//i made wave also a bloom shader because y not
	//waveShader = new CustomShader('wave');
	//waveShader.speed = 0.0025;
	//waveShader.intensity = 6;
	//waveShader.bloom = 0;
	//iTimeShaders.push(waveShader);
	//swirlsbg.shader = waveShader;
	//swirlsbg2.shader = waveShader;

	angrychromaticShader = new CustomShader('glitch2');
	angrychromaticShader.AMT = 0;
	angrychromaticShader.SPEED = 0.5;
	iTimeShaders.push(angrychromaticShader);




	countdowntext = new FlxText(975,675,0,'-10-',50);
	countdowntext.setFormat(Paths.font("sonic-1-hud-font.ttf"), 50, FlxColor.WHITE);
	//add(countdowntext);

	//making flxtext groups dont work?
	//numberGroup = new FlxTypedGroup<FlxText>();
	//game.addBehindDad(numberGroup);

	camGame.setFilters(camGameShaders);
	for (i in iTimeShaders) (i.iTime = 0.1);



	fadeToBlack = new FlxSprite().makeGraphic(Std.int(FlxG.width*2), Std.int(FlxG.height*2), FlxColor.BLACK);
	fadeToBlack.screenCenter();
	fadeToBlack.scrollFactor.set();
	fadeToBlack.alpha = 0;
	add(fadeToBlack);

	boyfriend.visible = false;

	//snapCam(dad.getMidpoint().x+ 150+ dad.cameraPosition[0]+ opponentCameraOffset[0],dad.getMidpoint().y- 100+ dad.cameraPosition[1]+ opponentCameraOffset[1]);

	//game.cpuControlled = true;
}
function onStrumCreation(event) if (event.player == 0) event.cancelAnimation();
function onSongStart() {
	doTweenZoom(0.5, 1.5, FlxEase.expoOut);
	camZooming = true;

}


/*function onUpdatePost(elapsed:Float) {
	for (i in iTimeShaders) (i.setFloat('iTime', i.getFloat('iTime') + elapsed));


	moveTheFuckingCamera(elapsed);


	// if (FlxG.keys.justPressed.TWO) {
	// 	game.setSongTime(Conductor.songPosition + 10000);
	// 	game.clearNotesBefore(Conductor.songPosition);
	// }
}



function onBeatHit() {

	//spawnNumber();
	//completely replace the games regular camlerps just so i can make my own bpz thing? eeeyes!
	if (game.curBeat >= 328 && game.curBeat < 484 && game.curBeat % 2 == 0) {
		spawnNumber();
	}
	if (game.curBeat % beatPerZoom == 0 && allowedToBop) {
		//debugPrint('booped');
		game.camGame.zoom += 0.015 * game.camZoomingMult;
		game.camHUD.zoom += 0.03 * game.camZoomingMult;
	}
}*/





function scriptStart(n, v1) {
	if (n == 'swapPhase') {
		switch (Std.parseInt(v1)) {
			case 0: //going into the screen
				var prevBop = allowedToBop;
				allowedToBop = false;
				tweenChrom(1.5,0.5,FlxEase.expoOut);
				tweenArray[6] = FlxTween.tween(camGame, {zoom: 0.525}, 0.2, {ease: FlxEase.sineInOut, onComplete: function(f:FlxTween) {

					camGame.addShader(mosaicShader);
					tweenMosaic(20,0.2, FlxEase.expoIn);
	
					baseCamOffsets[1] = -150;
					doTweenZoom(1.25,1.3,FlxEase.expoOut);
					for (i in firstBGGroup) {
						FlxTween.tween(i.scale, {x: 2, y: 2},1.3, {ease: FlxEase.expoOut});
					}
				}
				});
			
			case 1: //into the screen fully
				beatPerZoom = 2;
				tweenChrom(0,0.1,FlxEase.expoOut);
				tweenMosaic(0.1,0.5, FlxEase.expoOut,true);
				doTweenZoom(0.8,0.75,FlxEase.expoOut);
				waveShader.speed =0.02;
				for (i in firstBGGroup) i.alpha = 0;


			case 2: //trans out of finger wag
				if (tweenArray[50] != null) tweenArray[50].cancel();
				tweenArray[50] = FlxTween.tween(fadeToBlack, {alpha: 0},0.75, {ease: FlxEase.expoOut});
				tweenAngryChrom(0,0.5, FlxEase.sineOut,true);

				allowedToBop = true;
				doTweenZoom(0.65,0.75,FlxEase.expoOut);
				circle.visible = false;
				swirlsbg.visible = false;
				swirlsbg2.visible = true;
				fog.visible = true;
				waveShader.bloom =0;
			case 3: //trans into finger wag sprites
			camGame.addShader(angrychromaticShader);
				doTweenZoom(1.5,0.4,FlxEase.cubeOut);
				tweenArray[50] = FlxTween.tween(fadeToBlack, {alpha: 1},0.6, {ease: FlxEase.expoOut});
				tweenAngryChrom(0.4,0.4, FlxEase.expoOut);
		
			case 4: //turn bg more red
				tweenArray[10] = FlxTween.num(waveShader.bloom,0.5, 1.3, {ease: FlxEase.cubeOut, onComplete: function (f:FlxTween) {

				}}, function (f) {
					waveShader.bloom = f;
				});


				//shrink circle
			case 5:
				tweenArray[11] = FlxTween.tween(fog.scale, {x: 1.25, y: 1.25}, 15);
			case 6: //fade out 2.6
				camGame.addShader(mosaicShader);
				camGame.addShader(angrychromaticShader);
				doTweenZoom(2,2.6,FlxEase.sineIn);
				tweenArray[12] = FlxTween.tween(fadeToBlack, {alpha: 1},2.6, {ease: FlxEase.sineInOut});
				tweenArray[13] = FlxTween.tween(camHUD, {alpha: 0},2.6, {ease: FlxEase.sineInOut});
				tweenAngryChrom(0.4,2.6,FlxEase.sineInOut);
				tweenMosaic(40,2.6,FlxEase.sineInOut);
			case 7: //leave computer
				dad.visible = false;
				fadeToBlack.visible = false;
				swirlsbg.visible = false;
				swirlsbg2.visible = false;
				fog.visible = false;
				circle.visible = false;
				doTweenZoom(0.5,5.2, FlxEase.sineInOut);
				camGame.setFilters();
				camGame.setFilters();
				beatPerZoom = 11111111;
				
				for (i in firstBGGroup) {
					FlxTween.tween(i, {alpha: 1},2.6, {ease: FlxEase.sineInOut});
					FlxTween.tween(i.scale, {x: 1.25, y: 1.25},5.2, {ease: FlxEase.sineInOut});
				}
			case 8: //jumpscare
				jumpscare.visible = true;
				jumpscare.animation.play('i');
				camGame.shake(0.05,2);
			case 9: //crash
				Sys.exit(0);
				
		}

	}
	if (n == 'dotweenZoom') {
		var prevBop = allowedToBop;
		allowedToBop = false;

		if (tweenArray[0] != null) tweenArray[0].cancel();
		tweenArray[0] = FlxTween.tween(camGame, {zoom: Std.parseFloat(v1.split(',')[0])}, Std.parseFloat(v1.split(',')[1]), { ease: FlxEase.cubeOut, onComplete: function (f:FlxTween) {
			allowedToBop = prevBop;
		}});

	}
}


function spawnNumber() {

	var x = FlxG.random.int(600,1500);
	var y = FlxG.random.int(600,1100);
	var number = new FlxText(x,y,0,FlxG.random.int(1,10),120);
	number.setFormat(Paths.font("sonic-1-hud-font.ttf"), 120, FlxColor.WHITE);
	number.angle = FlxG.random.int(-5,5);
	number.alpha = 0;
	FlxTween.tween(number, {alpha: 1}, 1);
	FlxTween.circularMotion(number,number.x,number.y,10,0,FlxG.random.bool(50),2,true, {onComplete: function (f:FlxTween) {
		FlxTween.tween(number, {alpha: 0}, 2, {onComplete: function (f:FlxTween) {
			number.visible = false;
			number = null;
		}});
	}});
	insert(members.indexOf(dad),number);
	numberArray.push(number);

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


function tweenMosaic(value, time, ?ease:FlxEase = FlxEase.linear,?removeShader = false) {
	if (tweenArray[1] != null) tweenArray[1].cancel();

	tweenArray[1] = FlxTween.num(mosaicShader.pixel,value, time, {ease: ease, onComplete: function (f:FlxTween) {
		if (removeShader) camGameShaders.pop();
	}}, function (f) {
		mosaicShader.pixel=f;
	});
}

function tweenChrom(value, time, ?ease:FlxEase = FlxEase.linear,?removeShader = false) {
	if (tweenArray[2] != null) tweenArray[2].cancel();

	tweenArray[2] = FlxTween.num(chromaticShader.amount,value, time, {ease: ease, onComplete: function (f:FlxTween) {
		if (removeShader) camGameShaders.pop();
	}}, function (f) {
		chromaticShader.amount =f;
	});

}
function tweenAngryChrom(value, time, ?ease:FlxEase = FlxEase.linear,?removeShader = false) {
	if (tweenArray[3] != null) tweenArray[3].cancel();

	tweenArray[3] = FlxTween.num(angrychromaticShader.AMT,value, time, {ease: ease, onComplete: function (f:FlxTween) {
		if (removeShader) camGameShaders.pop();
	}}, function (f) {
		angrychromaticShader.AMT =f;
	});
}

//basically i completely went fuck the regular camera movement imma make a copy of it so i have more control
function moveTheFuckingCamera(elapsed:Float) {
	var dadCamDisplace:Array<Float> = [0., 0.0];
	var offsets:Array<Float> = [0., 0.];
	switch(dad.animation.curAnim.name) {
		case 'singUP':
			offsets = [0, -camOffset];
		case 'singDOWN':
			offsets = [0, camOffset];
		case 'singLEFT':
			offsets = [-camOffset, 0];
		case 'singRIGHT':
			offsets = [camOffset, 0];
	}


	dadCamDisplace = offsets;

	camFollow.x = dad.getMidpoint().x + 150 + dadCamDisplace[0] + dad.cameraPosition[0] + opponentCameraOffset[0] + baseCamOffsets[0];
	camFollow.y = dad.getMidpoint().y - 100 + dadCamDisplace[1] + dad.cameraPosition[1] + opponentCameraOffset[1] + baseCamOffsets[1];

	if (camZooming) {
		camGame.zoom = FlxMath.lerp(defaultCamZoom, camGame.camera.zoom, FlxMath.bound(1 - (elapsed * 3.125 * camZoomingDecay * playbackRate), 0, 1));
		camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, FlxMath.bound(1 - (elapsed * 3.125 * camZoomingDecay * playbackRate), 0, 1));
	}
}

function snapCam(x, y) {
	camFollow.x = x;
	camFollow.y = y;
	camGame.snapToTarget();
}

function opponentNoteHit() {
	camZooming = false;
}

//pause tweens
function onPause() {
	for (i in tweenArray) if (i != null) i.active = false;
}

function onResume() {
	for (i in tweenArray) if (i != null) i.active = true;
}


function onDestroy() {
	Application.current.window.title = "Friday Night Funkin': Psych Engine";
}