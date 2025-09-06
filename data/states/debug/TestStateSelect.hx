import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxCollision;
import flixel.tweens.FlxTween.FlxTweenType;

var transitioning:Bool = false;
var rotationTime:Float = 0;
var rotationInterval:Float = 5; // секунды
var curSelected:Int = 0;
public var options:Array<Editor> = [
	{
		name: "Wave Forms Test",
		exist: true,
		state: 'WaveFormTestState'
	},
	{
		name: "Deltarune Fight Bg Test....",
		exist: true,
		state: 'DeltaruneFightBgTest'
	},
	{
		name: "locked Test",
		exist: false,
		state: null
	}
];
var canClick:Bool = true;

function create() {

    FlxG.sound.playMusic(Paths.music('Mania Mood'), 1, true);
    Conductor.changeBPM(166);
    if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
    	FlxG.sound.music.play();
    }
    backdrop = new FlxBackdrop(Paths.image('editors/bgs/debugBg'));
    backdrop.updateHitbox();
    backdrop.velocity.set(60/2, -10/2);
    backdrop.alpha = 0.6;
    backdrop.rotation = -20;
	backdrop.zoom = 1.5;
    add(backdrop);

	grpSongs = new FlxTypedGroup<Alphabet>();
	add(grpSongs);

	for (i in 0...options.length)
	{
		var songText:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].name, "bold");
		songText.isMenuItem = true;
		songText.targetY = i;
		grpSongs.add(songText);

		// songText.x += 40;
		// DON'T PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		// songText.screenCenter(X);
	}

	bluescreen = new FlxSprite(0, 0);
    bluescreen.frames = Paths.getSparrowAtlas('editors/debug/bluescreenDebug');
    bluescreen.animation.addByPrefix('idle', 'idle', 20, true);
	bluescreen.animation.addByPrefix('animation', 'animation', 10, true);
	bluescreen.animation.addByPrefix('loop', 'loop', 10, true);
    bluescreen.animation.play('idle');
    bluescreen.scale.set(0.4,0.4);
    bluescreen.updateHitbox();
    bluescreen.screenCenter();
    add(bluescreen);
	bluescreen.y += 220;
	bluescreen.x += 500;

	changeSelection();

	FlxTween.tween(backdrop, {zoom: 1}, 5, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});

}
function changeSelection(change:Int = 0)
{
	bluescreen.animation.play('idle');
	FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
	curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);
}
function update(elapsed:Float) {
	if (!transitioning){
		if (controls.UP_P)
		{
			changeSelection(-1);
		}
		if (controls.DOWN_P)
		{
			changeSelection(1);
		}
		if(FlxG.mouse.wheel != 0)
		{
			changeSelection(-FlxG.mouse.wheel, false);
		}
		for (num => item in grpSongs.members)
		{
			item.targetY = num - curSelected;
			item.alpha = 0.6;
			if (item.targetY == 0)
				item.alpha = 1;
		}

		if (controls.ACCEPT)
		{
			if(options[curSelected].exist){
				FlxG.switchState(new ModState('debug/' + options[curSelected].state));
			}else {
				FlxG.sound.play(Paths.sound("cancelMenu"), 0.7);
				bluescreen.animation.play('animation');
				FlxG.camera.shake(0.01, 0.1);
			}
		}
		if (controls.BACK) {

			FlxG.sound.play(Paths.sound("cancelMenu"), 0.7);
    	    FlxG.sound.playMusic(Paths.music('EXEcellence'), 1, true);
    	    Conductor.changeBPM(123);
			FlxG.switchState(new MainMenuState());
		}
	};

	if (FlxG.mouse.overlaps(bluescreen) && FlxG.mouse.pressed)
	{	
		bluescreen.animation.play('animation');
    }
	if(bluescreen.animation.curAnim.name == 'animation' && bluescreen.animation.curAnim.curFrame == 10){
		bluescreen.animation.play('loop');
	}
	backdrop.rotation += 0.005;
}