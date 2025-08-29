importScript("data/huds/maniav3");
paoFliped = true;

function mirrorMode() {
    bg2.alpha = 0;
    
    for (strum in strumLines.members[0].members) {
        FlxTween.tween(strum, {x: strum.x - 765}, 0.5, {ease: FlxEase.quintInOut});
    }
    for (strum in strumLines.members[1].members) {
        FlxTween.tween(strum, {x: strum.x + 765}, 0.5, {ease: FlxEase.quintInOut});
    }
}