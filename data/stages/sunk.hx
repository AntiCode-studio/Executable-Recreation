importScript("data/huds/maniav3");
portVisible = false;
introLength = 0;
function postCreate() {
    tilt_angleIntensity = 0.1;
    tilt_followMult = 0.5;
    tilt_offset = 15;
    tilt_isHUDlerped = true;
}
var theend = false;
function theend() {
    theend = true;
}
function update(elapsed:Float) {
    if(theend){
        strumLines.members[0].characters[0].x += 3;
        //trace(strumLines.members[0].characters[0].x);
    }
    switch (strumLines.members[0].characters[0].x) {
        case 1599: 
            strumLines.members[1].characters[0].visible = false;
            FlxG.sound.play(Paths.sound("explosion"), 1);
            reroyexplodes = new FlxSprite().loadGraphic(Paths.image('bl'),true,90,125);
            reroyexplodes.animation.add('explode',[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19],12,false);
            reroyexplodes.setGraphicSize(600);
            reroyexplodes.updateHitbox();
            add(reroyexplodes);
            reroyexplodes.animation.play('explode');
            reroyexplodes.x = strumLines.members[1].characters[0].x;
            reroyexplodes.y = strumLines.members[1].characters[0].y + 100;
    }
}