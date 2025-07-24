// libraries
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;

var bfLoad:FlxSprite;
var gradi;

var timer = FlxG.random.float(1.0, 2.5, 3.0);

var target:FlxState;

function create() {
    loadingScreen = new FlxSprite().loadGraphic(Paths.image('loadingScreens/default'));
    loadingScreen.screenCenter();
    add(loadingScreen);
    
    trace("timer got " + timer);
}

function postCreate() {
    
    trace("caching songSlot " + curChSelected);

    // switch(curChSelected){
    //     case 0:
    //         Paths.file('videos/satn.webm');
            
    // }
}

function update(elapsed:Float) {
    FlxTween.tween(FlxG.sound.music, {volume: 0}, 1.0);
    new FlxTimer().start(timer, function(timer:FlxTimer) {
        FlxTween.tween(loadingScreen, {alpha: 0}, 0.85, {ease: FlxEase.linear, onComplete: function() {
            FlxG.switchState(new PlayState());
        }});
    });
}