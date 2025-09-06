import openfl.display.BlendMode;
import flixel.effects.FlxFlicker;
importScript("data/huds/maniav3");
paoFliped = true;
introLength = 0;
var shade = new FunkinSprite(0,-200).makeGraphic(1,1,FlxColor.WHITE);
function create() {
    shade.scale.set(2000,2000);
    shade.color = 0x85007e;
    shade.updateHitbox();
    shade.alpha = 0;
    shade.blend = BlendMode.MULTIPLY;
    shade.zoomFactor = 0;
    shade.scrollFactor(0,0);
    add(shade);
}
var localTime:Float = 0;
aura = new CustomShader('Aura');
camGame.addShader(aura);
function update(elapsed:Float) {
    localTime += elapsed;
    aura.iTime = localTime;
}


function mirrorMode() {
    //bg2.alpha = 0;
    
    for (strum in strumLines.members[0].members) {
        FlxTween.tween(strum, {x: strum.x - 765}, 1.5, {ease: FlxEase.quintInOut});
    }
    for (strum in strumLines.members[1].members) {
        FlxTween.tween(strum, {x: strum.x + 765}, 1.5, {ease: FlxEase.quintInOut});
    }
    FlxTween.tween(shade, {alpha: 0.8}, 1.5, {ease: FlxEase.quintInOut});
}
function onPlayerMiss(event:NoteMissEvent) {
    flicker();
}
function flicker() {
    boyfriend.setColorTransform(1,0.5,1);
    FlxFlicker.flicker(boyfriend,1,0.05,true,true,(flicker)->{boyfriend.setColorTransform(1,1,1);});
}