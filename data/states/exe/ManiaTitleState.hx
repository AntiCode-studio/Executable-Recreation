import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;
var transitioning:Bool = true;
menuShader = new CustomShader('menuShader');
scrollTest = new CustomShader('scroll');
function create() {
    FlxG.sound.playMusic(Paths.music('EXEcellence'), 1, true);
    Conductor.changeBPM(123);

	if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
		FlxG.sound.music.play();
	}

    blackP = new FlxSprite();
    blackP.makeGraphic(1280, 720, FlxColor.BLACK);
    blackP.updateHitbox();
    blackP.screenCenter();
    blackP.shader = menuShader;
    blackP.scrollFactor.set(0,0);
    add(blackP);

    port1 = new FlxBackdrop(Paths.image('menus/title/portalets'));
    port1.repeatAxes = FlxAxes.X;
    port1.scale.set(0.8,0.8);
    port1.updateHitbox();
    port1.velocity.set(-60, 0);
    port1.alpha = 0;
    port1.scrollFactor.set(0,0);
    add(port1);
    port2 = new FlxBackdrop(Paths.image('menus/title/portalets'));
    port2.repeatAxes = FlxAxes.X;
    port2.scale.set(0.8,0.8);
    port2.updateHitbox();
    port2.velocity.set(30, 0);
    port2.y += 270;
    port2.alpha = 0;
    port2.scrollFactor.set(0,0);
    add(port2);
    port3 = new FlxBackdrop(Paths.image('menus/title/portalets'));
    port3.repeatAxes = FlxAxes.X;
    port3.scale.set(0.8,0.8);
    port3.updateHitbox();
    port3.velocity.set(-20, 0);
    port3.y += 540;
    port3.alpha = 0;
    port3.scrollFactor.set(0,0);
    add(port3);
    //backdrop.shader = scrollTest;

    bgB = new FlxSprite(-700, 0);
    bgB.makeGraphic(1400, 1400, FlxColor.BLACK);
    add(bgB);
    bgB.scale.set(3, 3);
    bgB.scrollFactor.set(0,0);
    bgB.alpha = 0.5;

    backdrop = new FlxBackdrop(Paths.image('menus/title/card'));
    backdrop.repeatAxes = FlxAxes.Y;
    backdrop.scale.set(0.755,0.755);
    backdrop.updateHitbox();
    backdrop.x += 450;
    add(backdrop);
    //backdrop.shader = scrollTest;

    whiteLine = new FlxSprite();
    whiteLine.makeGraphic(10, 720, FlxColor.WHITE);
    whiteLine.updateHitbox();
    whiteLine.screenCenter();
    whiteLine.scrollFactor.set(0,0);
    whiteLine.x -= 190;
    add(whiteLine);
    
    port = new FlxSprite();
    port.loadGraphic(Paths.image('menus/title/port'));
    port.scale.set(0.7,0.7);
    port.shader = scrollTest;
    //add(port);

    logo = new FlxSprite();
    logo.loadGraphic(Paths.image('menus/title/logo'));
    logo.updateHitbox();
    logo.screenCenter();
    logo.angle -= 2;
    add(logo);
    FlxTween.tween(logo, {angle: 2}, 2, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});

    press = new FlxSprite(10, 340);
    press.frames = Paths.getSparrowAtlas('menus/title/pressEnter');
    press.animation.addByPrefix('idle', 'idle', 15, true);
    press.animation.addByPrefix('press', 'press', 15, false);
    press.animation.play('idle');
    press.alpha = 0;
    press.updateHitbox();
    //add(press);

    press2 = new FlxSprite(25, 450);
    press2.loadGraphic(Paths.image('menus/title/press'));
    press2.scale.set(0.4,0.4);
    press2.alpha = 0;
    press2.updateHitbox();
    add(press2);

    bgt = new FlxSprite(-700, 0);
    bgt.makeGraphic(1400, 1400, FlxColor.BLACK);
    add(bgt);
    bgt.scale.set(3, 3);
    bgt.scrollFactor.set(0,0);
    bgt.alpha = 1;

    titleCut = new FlxSprite();
    titleCut.frames = Paths.getSparrowAtlas('menus/title/LogoDraw');
    titleCut.animation.addByPrefix('anim', 'draw', 15, false);
    titleCut.scale.set(0.6, 0.6);
    titleCut.screenCenter();
    add(titleCut);
    titleCut.visible = false;
}
var localTime:Float = 0;
function update(elapsed:Float) {
    localTime += elapsed;
    menuShader.iTime = localTime;
    scrollTest.iTime = localTime;
    if (controls.ACCEPT) {
		if (!transitioning){
            press.animation.play('press');
            FlxTween.tween(FlxG.camera, {'scroll.y': 1000}, 2, {ease: FlxEase.quintInOut});
            FlxTween.tween(bgt, {'alpha': 1}, 1.4, {ease: FlxEase.quintInOut});
            transitioning = true;
			FlxG.sound.play(Paths.sound("confirmMenu"), 0.7);
			new FlxTimer().start(1.4, (_) -> [
                FlxG.switchState(new MainMenuState())
            ]);
		};
	}
}
var tweenFinished = false;
function stepHit(curStep:Int) {
    if(!tweenFinished){
        switch (curStep) {
            case 15:
                titleCut.visible = true;
                FlxTween.tween(titleCut.scale, {y: 1, x: 1}, 2, {ease: FlxEase.quintInOut});
                titleCut.animation.play('anim');
            case 30: 
                titleCut.visible = false;
                bgt.alpha = 0;
                FlxG.camera.flash(FlxColor.WHITE, 1);
                transitioning = false;
                backdrop.velocity.set(0, -30);
                logo.scale.y = 1.2;
                logo.scale.x = 1.2;
                FlxTween.tween(logo.scale, {y: 1, x: 1}, 1, {ease: FlxEase.quintOut});
            case 40: 
                FlxTween.tween(logo, {y: 120, x: -320, 'scale.x': 0.4, 'scale.y': 0.4}, 2, {ease: FlxEase.quintInOut});
            case 50:
                FlxTween.tween(press, {alpha: 1}, 2, {ease: FlxEase.quintInOut});
                FlxTween.tween(press2, {alpha: 1}, 2, {ease: FlxEase.quintInOut});
            case 120:
                FlxTween.tween(port1, {alpha: 0.6}, 5, {ease: FlxEase.quintInOut});
                FlxTween.tween(port2, {alpha: 0.6}, 5, {ease: FlxEase.quintInOut});
                FlxTween.tween(port3, {alpha: 0.6}, 5, {ease: FlxEase.quintInOut});
                tweenFinished = true;
    }
    }
    
}