function create() {
    bgB = new FlxSprite(-700, 0);
    bgB.makeGraphic(2560, 1400, FlxColor.BLACK);
    add(bgB);
    importScript("data/huds/maniav1");
}
function update(elapsed:Float) {
    
}
function stepHit(curStep:Int) {
    switch (curStep) {
        case 16: 
            bgB.alpha = 0;
    }
}