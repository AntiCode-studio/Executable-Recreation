import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween.FlxTweenType;

var rotationTime:Float = 0;
var rotationInterval:Float = 5; // секунды

function create() {
    FlxG.sound.playMusic(Paths.music('battle'), 1, true);
    Conductor.changeBPM(166);
    if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
    	FlxG.sound.music.play();
    }

    backdrop = new FlxBackdrop(Paths.image('menus/qube'));
    backdrop.updateHitbox();
    backdrop.velocity.set(100, 50);
    backdrop.alpha = 0.6;
    backdrop.zoom = 0.6;
    add(backdrop);
    backdrop.color = 0x94003e;

    backdrop2 = new FlxBackdrop(Paths.image('menus/qube'));
    backdrop2.updateHitbox();
    backdrop2.velocity.set(-100, -50);
    backdrop2.alpha = 1;
    backdrop2.zoom = 0.6;
    add(backdrop2);
    backdrop2.color = 0x94003e;
}

function update(elapsed:Float) {
    if (controls.BACK) {
		FlxG.sound.play(Paths.sound("cancelMenu"), 0.7);
		FlxG.switchState(new ModState('debug/TestStateSelect'));
	}
}