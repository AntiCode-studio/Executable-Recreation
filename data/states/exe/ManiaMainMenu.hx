import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;
import flixel.util.FlxCollision;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;

var transitioning:Bool = true;
menuShader = new CustomShader('menuShader');

var optionShit:Array<String> = CoolUtil.coolTextFile(Paths.txt("config/menuItems"));

var canClick:Bool = true;
var usingMouse:Bool = true;
var curSelected:Int = 0;

function create() {

    if (FlxG.sound.music == null){
        FlxG.sound.playMusic(Paths.music('EXEcellence'), 1, true);
        Conductor.changeBPM(123);
    } 

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

    bgB = new FlxSprite(-700, 0);
    bgB.makeGraphic(1400, 1400, FlxColor.BLACK);
    add(bgB);
    bgB.scale.set(3, 3);
    bgB.scrollFactor.set(0,0);
    bgB.alpha = 0.2;

    bgArt = new FlxSprite();
    bgArt.loadGraphic(Paths.image('menus/main/bg'));
    bgArt.scale.set(0.42,0.42);
    bgArt.updateHitbox();
    bgArt.screenCenter();
    bgArt.alpha = 0.1;
    bgArt.scrollFactor.set(0,0);
    add(bgArt);

    backdrop = new FlxBackdrop(Paths.image('menus/main/checker'));
    backdrop.updateHitbox();
    backdrop.velocity.set(0, -30);
    backdrop.blend = BlendMode.SUBTRACT;
    add(backdrop);

    spiral = new FlxSprite(0, 0);
    spiral.frames = Paths.getSparrowAtlas('menus/main/spiral');
    spiral.animation.addByPrefix('idle', 'spiral', 5, true);
    spiral.animation.play('idle');
    spiral.scale.set(0.55,0.55);
    spiral.updateHitbox();
    spiral.screenCenter();
    spiral.scrollFactor.set(0.6,0.6);
    add(spiral);

    stripes = new FlxSprite(0, 0);
    stripes.loadGraphic(Paths.image('menus/main/stripes'));
    stripes.scale.set(0.55,0.55);
    stripes.updateHitbox();
    stripes.screenCenter();
    stripes.scrollFactor.set(0,0);
    stripes.alpha = 0;
    stripes.x = 0;
    stripes.y = 300;
    add(stripes);

    three1 = new FlxSprite(0, 0);
    three1.frames = Paths.getSparrowAtlas('menus/main/assets1');
    three1.animation.addByPrefix('idle', 'treeL', 5, true);
    three1.animation.play('idle');
    three1.scale.set(0.5,0.5);
    three1.updateHitbox();
    three1.screenCenter();
    three1.scrollFactor.set(0.85,0.85);
    three1.x = -40;
    add(three1);
    FlxTween.tween(three1, {y: three1.y + 50}, 8, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});

    three2 = new FlxSprite(0, 0);
    three2.frames = Paths.getSparrowAtlas('menus/main/assets1');
    three2.animation.addByPrefix('idle', 'treeR', 5, true);
    three2.animation.play('idle');
    three2.scale.set(0.4,0.4);
    three2.updateHitbox();
    three2.screenCenter();
    three2.scrollFactor.set(0.85,0.85);
    three2.x = 1000;
    add(three2);
    FlxTween.tween(three2, {y: three2.y - 50}, 8, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});

    splash = new FlxSprite(0, 0);
    splash.frames = Paths.getSparrowAtlas('menus/main/splash');
    splash.animation.addByPrefix('idle', 'splat', 5, true);
    splash.animation.play('idle');
    splash.scale.set(0.4,0.4);
    splash.updateHitbox();
    splash.screenCenter();
    splash.scrollFactor.set(0.75,0.75);
    splash.y -= 80;
    splash.x += 40;
    add(splash);

    menuItems = new FlxGroup();
	add(menuItems);

    menuTvs = new FlxGroup();
	add(menuTvs);

    menuHitbox = new FlxGroup();
	add(menuHitbox);

    for (i=>option in optionShit)
	{
        
        tvs = new FlxSprite(0, 0);
		tvs.frames = Paths.getFrames('menus/main/tvs');
		tvs.animation.addByPrefix('idle', option + "_i", 5);
		tvs.animation.addByPrefix('selected', option + "_selected", 5);
		tvs.animation.play('idle');
		tvs.ID = i;
        tvs.scale.x = 0.4;
		tvs.scale.y = 0.4;
        tvs.updateHitbox();
		menuItems.add(tvs);
		tvs.scrollFactor.set(0.9, 0.9);

        switch (i)
		{
			case 0:
				tvs.setPosition(0, 0);
			case 1:
				tvs.setPosition(0, 40);
			case 2:
				tvs.setPosition(0, 30);
			case 3:
				tvs.setPosition(20, 40);
			case 4:
				tvs.setPosition(0, 40);
		}

        menuItem = new FlxSprite(0, 0);
		menuItem.frames = Paths.getFrames('menus/main/display');
		menuItem.animation.addByPrefix('idle', option + "_i", 5);
		menuItem.animation.addByPrefix('selected', option + "_selected", 5);
		menuItem.animation.play('idle');
		menuItem.ID = i;
        menuItem.scale.x = 0.4;
		menuItem.scale.y = 0.4;
        menuItem.updateHitbox();
		menuTvs.add(menuItem);
		menuItem.scrollFactor.set(tvs.scrollFactor.x, tvs.scrollFactor.y);

        switch (i)
		{
			case 0:
				menuItem.setPosition(tvs.x, tvs.y);
			case 1:
				menuItem.setPosition(tvs.x, tvs.y);
			case 2:
				menuItem.setPosition(tvs.x, tvs.y);
			case 3:
				menuItem.setPosition(tvs.x, tvs.y);
			case 4:
				menuItem.setPosition(tvs.x, tvs.y);
		}

        bgH = new FlxSprite(0, 0);
        bgH.ID = i;
        bgH.makeGraphic(100, 100, FlxColor.WHITE);
        menuHitbox.add(bgH);
        bgH.scale.set(1, 1);
        bgH.scrollFactor.set(0.9, 0.9);
        bgH.alpha = 0.01;

        switch (i)
		{
			case 0:
                bgH.scale.set(4.2, 3);
                bgH.updateHitbox();
                bgH.color = 0xff0000;
				bgH.setPosition(tvs.x + 230, tvs.y + 160);
			case 1:
				bgH.scale.set(2.5, 2);
                bgH.updateHitbox();
                bgH.color = 0x00e1ff;
				bgH.setPosition(tvs.x + 695, tvs.y + 150);
			case 2:
                bgH.scale.set(3, 2.5);
                bgH.updateHitbox();
                bgH.color = 0xe5ff00;
				bgH.setPosition(tvs.x + 50, tvs.y + 460);
			case 3:
                bgH.scale.set(1.3, 2.2);
                bgH.updateHitbox();
                bgH.color = 0x2bff00;
				bgH.setPosition(tvs.x + 590, tvs.y + 430);
			case 4:
                bgH.scale.set(5, 4);
                bgH.updateHitbox();
                bgH.color = 0x8400ff;
				bgH.setPosition(tvs.x + 760, tvs.y + 360);
		}
	}

    title = new FlxSprite(0, 0);
    title.frames = Paths.getSparrowAtlas('menus/main/assets1');
    title.animation.addByPrefix('idle', 'title', 5, true);
    title.animation.play('idle');
    title.scale.set(0.4,0.4);
    title.updateHitbox();
    title.screenCenter();
    title.scrollFactor.set(0.95,0.95);
    add(title);
    FlxTween.tween(title, {y: title.y - 10}, 4, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});

    FlxG.camera.scroll.set(-10, -1000);

    FlxTween.tween(FlxG.camera.scroll, {x: 10}, 8, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});
    FlxTween.tween(FlxG.camera, {'scroll.y': -10}, 2, {ease: FlxEase.quintInOut, onComplete: function(f:FlxTween) {
        transitioning = false;
        FlxTween.tween(FlxG.camera.scroll, {y: 10}, 6, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});
        FlxTween.tween(stripes, {alpha: 1}, 2, {ease: FlxEase.quintInOut});
    }});

    bgt = new FlxSprite(-700, 0);
    bgt.makeGraphic(1400, 1400, FlxColor.BLACK);
    add(bgt);
    bgt.scale.set(3, 3);
    bgt.scrollFactor.set(0,0);
    bgt.alpha = 1;
    FlxTween.tween(bgt, {'alpha': 0}, 1.4, {ease: FlxEase.quintInOut});

    // Создаем основной куб (курсор)
    cursorCube = new FlxSprite();
    cursorCube.makeGraphic(10, 10, FlxColor.BLACK);
    //cursorCube.scale.set(0.6, 0.6);
    cursorCube.alpha = 0.01;
    cursorCube.screenCenter();
    add(cursorCube);
}
var localTime:Float = 0;

function update(elapsed:Float) {

    if (FlxG.keys.justPressed.SEVEN) {
		openSubState(new EditorPicker());
	}

	if (FlxG.keys.justPressed.TAB) {
		openSubState(new ModSwitchMenu());
	}
    localTime += elapsed;
    menuShader.iTime = localTime;

    cursorCube.x = FlxG.mouse.x - cursorCube.width / 2;
    cursorCube.y = FlxG.mouse.y - cursorCube.height / 2;
    if (controls.BACK) {
		if (!transitioning){
			FlxG.sound.play(Paths.sound("cancelMenu"), 0.7);
			FlxG.switchState(new TitleState());
		};
	}
    menuHitbox.forEach(function(spr:FlxSprite)
	{
        //trace(FlxCollision.pixelPerfectCheck(cursorCube, spr, 1));
        //trace(menuHitbox.ID);
        if(usingMouse)
		{
			if(!FlxCollision.pixelPerfectCheck(cursorCube, spr, 1)){
                //spr.animation.play('idle');
                //trace();
                menuItems.members[spr.ID].animation.play('idle');
                menuTvs.members[curSelected].animation.play('idle');
            }
				
		}
	
		if (FlxCollision.pixelPerfectCheck(cursorCube, spr, 1))
		{
			if(canClick)
			{
				curSelected = spr.ID;
                //FlxG.sound.play(Paths.sound("scrollMenu"), 0.1);
				usingMouse = true;
                menuItems.members[curSelected].animation.play('selected');
                menuTvs.members[curSelected].animation.play('selected');
			}
				
			if(FlxG.mouse.pressed && canClick)
			{
				switch (optionShit[curSelected]) {
					default: 
						selectSomething();
				}
			}
        }
        spr.updateHitbox();
    });
    
        
}

function selectSomething()
{
	canSelect = true;
	transitioning = true;
	FlxG.sound.play(Paths.sound('confirmMenu'));

	
	canClick = false;

	menuHitbox.forEach(function(spr:FlxSprite)
	{
		if (curSelected != spr.ID)
		{
			FlxTween.tween(spr, {alpha: 0}, 1.3, {
				ease: FlxEase.quadOut,
				onComplete: function(twn:FlxTween)
				{
					spr.kill();
				}
			});
		}
		else
		{
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				goToState();
			});
		}
	});
}
function goToState()
{
	var daChoice:String = optionShit[curSelected];
	switch (daChoice)
	{
		case 'mania':
			FlxG.switchState(new FreeplayState());
			trace("Story Menu Selected");
		case 'locked':
			FlxG.switchState(new FreeplayState());
			trace("Awards Menu Selected");
		case 'options':
			FlxG.switchState(new OptionsMenu());
			trace("Options Menu Selected");
		case 'credits':
			FlxG.switchState(new CreditsMain());
			trace("Credits Menu Selected");
        case 'gallery':
			FlxG.switchState(new ModState('exe/ManiaGalleryState'));
			trace("Gallery Menu Selected");
	}		
}