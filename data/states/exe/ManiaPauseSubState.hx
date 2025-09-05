import funkin.ui.FunkinText;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.system.framerate.Framerate;
import openfl.display.BlendMode;

var pauseCam = new FlxCamera();
var pauseCam2 = new FlxCamera();

var scroll, confirm, cancel, enter:FlxSound;

var blackboxDown = new FlxSprite();
var blackboxUp = new FlxSprite();

var texts:Array<FlxText> = [];

var grpMenuShit:FlxTypedGroup<Alphabet>;
var pitchSound;
function create(event) {
    //FlxTween.tween(Framerate.offset, {y: 60}, .5, {ease: FlxEase.cubeOut});

	// cancel default pause menu!!
	event.cancel();

	cameras = [];

    confirm = FlxG.sound.load(Paths.sound('confirmMenu'), .3);
    cancel = FlxG.sound.load(Paths.sound('cancelMenu'), .3);
    scroll = FlxG.sound.load(Paths.sound('scrollMenu'), .15);

	//pitchSound = FlxG.random.float(-5, 5);
	//trace(pitchSound);
	//pauseSound = FlxG.sound.load(Paths.sound('menu/new/pause'), .15);
	//pauseSound.pitch = pitchSound;
	//pauseSound.play();

    FlxG.cameras.add(pauseCam, false);
    pauseCam.bgColor = 0x94000000;
    pauseCam.alpha = 0;
    FlxTween.tween(pauseCam, {alpha: 1, zoom: 1}, .5, {ease: FlxEase.cubeOut});

	FlxG.cameras.add(pauseCam2, false);
    pauseCam2.bgColor = 0x000000000;
    pauseCam2.alpha = 1;
	glitch = new CustomShader('anotherGlitchShader');
    //pauseCam.addShader(glitch);

	bg = new FlxSprite(0, 0);
    bg.frames = Paths.getSparrowAtlas('menus/pause/bg');
    bg.animation.addByPrefix('idle', 'frame', 16, true);
    bg.animation.play('idle');
    bg.scale.set(2,2);
    bg.updateHitbox();
    bg.screenCenter();
	bg.blend = BlendMode.DARKEN;
    add(bg);
	FlxTween.tween(bg, {"scale.x": 1.2, "scale.y": 1.2, alpha: 0.1}, 0.5, {ease: FlxEase.cubeOut});

	glitch.vertJerkOpt     = 0.0;
	glitch.vertMovementOpt = 0.0;
	glitch.bottomStaticOpt = 0.0;
	glitch.scalinesOpt     = 0.0;
	glitch.rgbOffsetOpt    = 0.0;
	glitch.horzFuzzOpt     = 0.0;

	FlxTween.tween(glitch, {vertJerkOpt: 0.2, vertMovementOpt: 0.5, bottomStaticOpt: 0.3, scalinesOpt: 0.5, rgbOffsetOpt: 0.2, horzFuzzOpt: 0.2}, 1, {ease: FlxEase.backOut});

	trace(PlayState.SONG.meta.displayName);

	if(PlayState.SONG.meta.displayName == 'burger'){
		puseArt = new FlxSprite(0, 0);
    	puseArt.loadGraphic(Paths.image('menus/pause/characters/' + PlayState.SONG.meta.displayName), false, 100, 100); // Замените на свой спрайт
    	puseArt.scale.set(0.55, 0.55);
    	puseArt.updateHitbox();
    	puseArt.screenCenter();
		puseArt.x += 120;
		puseArt.y += 50;
    	puseArt.visible = true;
		if(curStep < 639){
			puseArt.color = 0x000000;
		}
		add(puseArt);
	}
	

	grpMenuShit = new FlxTypedGroup();
	add(grpMenuShit);

    var i:Float = 2;
	for(e in menuItems) {
		text = new FlxText(320, (22 * 2) + (i * 9 * 6) + 280, 0, e, 8, false);
        //FlxTween.tween(text, {x: 350}, .5, {ease: FlxEase.backOut});
        text.setFormat(Paths.font("joystix monospace.otf"), 150, FlxColor.WHITE, FlxText.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		confText(text);
		grpMenuShit.add(text);
		texts.push(text);
		i++;
	}

    hand = new FlxSprite().loadGraphic(Paths.image('menus/pause/pixel'));
	hand.scale.set(2, 2);
	hand.updateHitbox();
	add(hand);

	pause = new FlxSprite(320, 400);
    //pause.loadGraphic(Paths.image('menus/pause/pause texta'), false, 100, 100); // Замените на свой спрайт
    //pause.scale.set(3.5, 3.5);
    //pause.updateHitbox();
    ////pause.screenCenter();
    //pause.visible = true;
    //add(pause);
	pause.frames = Paths.getSparrowAtlas('menus/pause/pause texta');
	pause.animation.addByPrefix('idle', "pixel", 1.5, true);
	pause.animation.play('idle');
	pause.scale.set(3.5, 3.5);
	pause.updateHitbox();
	//pause.screenCenter();
	pause.visible = true;
	add(pause);

	logo = new FlxSprite(0, 0);
    logo.loadGraphic(Paths.image('menus/title/logoCompres'), false, 100, 100); // Замените на свой спрайт
    logo.scale.set(0.3, 0.3);
    logo.updateHitbox();
    logo.screenCenter();
	logo.x -= 250;
	logo.y -= 170;
    logo.visible = true;
	add(logo);

	cameras = [pauseCam];
}

function confText(text) {
	text.scale.set(0.2, 0.2);
	text.updateHitbox();
	text.borderStyle = FlxTextBorderStyle.OUTLINE;
}

function destroy() FlxG.cameras.remove(pauseCam);

var canDoShit = true;
var time:Float = 0;
function update(elapsed) {
	time += elapsed;

    glitch.iTime = time;

	var curText = texts[curSelected];
	hand.setPosition(curText.x - 30, curText.y + (text.height - hand.height) - 8);
	//hand.x -= hand.x % 6;
	//hand.y -= hand.y % 6;

	if (!canDoShit) return;
	var oldSec = curSelected;
	if (controls.DOWN_P) changeSelection(1, false);
	if (controls.UP_P) changeSelection(-1);

	if (controls.ACCEPT) {
		var option = menuItems[curSelected];

        if (option == "Exit to menu") cancel.play();
        else confirm.play();

        //FlxTween.tween(Framerate.offset, {y: 0}, .5, {ease: FlxEase.cubeOut});
		if (option == "Resume" || option == "Restart Song") {
			canDoShit = false;
            FlxTween.tween(pauseCam, {alpha: 0}, .5, {ease: FlxEase.cubeOut});
			FlxTween.tween(glitch, {vertJerkOpt: 1, vertMovementOpt: 1, bottomStaticOpt: 1, scalinesOpt: 1, rgbOffsetOpt: 1, horzFuzzOpt: 1}, .5, {ease: FlxEase.cubeOut});
            new FlxTimer().start(.65, function(tmr:FlxTimer){
                selectOption();
            });
		}else if (option == "Exit to menu" || option == "Change Options"){
            canDoShit = false;
            selectOption();
        }else selectOption();
	}
}

function changeSelection(change){
	scroll.stop();
    scroll.play();

	curSelected += change;

	if (curSelected < 0) curSelected = menuItems.length - 1;
	if (curSelected >= menuItems.length) curSelected = 0;
	//trace(curSelected);
	//trace(menuItems.length);
}