import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween.FlxTweenType;
import funkin.backend.utils.AudioAnalyzer;
//import flixel.addons.display.waveform.FlxWaveform;
import funkin.editors.ui.UIFileExplorer;
//import funkin.backend.system.Flags;
import funkin.editors.ui.UIText;
import funkin.editors.ui.UIState;
import funkin.editors.ui.UITopMenu;
import funkin.editors.ui.UIButton;
import funkin.editors.ui.UIButtonList;
import funkin.editors.ui.UISubstateWindow;

var rotationTime:Float = 0;
var rotationInterval:Float = 5; // секунды

var fileExplorer:UIFileExplorer;

var testingUIItems:Array<FlxSprite> = [];

var uiCamera = new FlxCamera();
uiCamera.bgColor = 0;

function create() {
    backdrop = new FlxBackdrop(Paths.image('editors/bgs/debugBg'));
    backdrop.updateHitbox();
    backdrop.velocity.set(60/2, -10/2);
    backdrop.alpha = 0.6;
    backdrop.rotation = -20;
    backdrop.zoom = 0.8;
    add(backdrop);
    FlxTween.tween(backdrop, {zoom: 1}, 5, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});

    FlxG.autoPause = false;

    //fileExplorer = new UIFileExplorer(5, 5 + 32 + 36, 56, 56, 'ogg', function (path, res) {
	//	if (path == null || res == null) return;
	//	var audioPlayer:UIAudioPlayer = new UIAudioPlayer(fileExplorer.x + 8, fileExplorer.y + 8, res);
	//	fileExplorer.members.push(audioPlayer);
	//	fileExplorer.uiElement = audioPlayer;
	//});
    //add(fileExplorer);

    
    
}
function destroy():Void
{
    FlxG.autoPause = true;
}
function update(elapsed:Float) {

    if (FlxG.mouse.justPressed)
    {
    //    browseForFile();
    }

    //trace(analyzer.analyze(0, 80));
    rotationTime += elapsed;
    if (controls.BACK) {
		FlxG.sound.play(Paths.sound("cancelMenu"), 0.7);
		FlxG.switchState(new ModState('debug/TestStateSelect'));
	}
    backdrop.rotation += 0.005;
}