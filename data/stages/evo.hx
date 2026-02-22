
// importScript("data/scripts/pixel");
importScript("data/huds/pokemon");
portVisible = false;
introLength = 0;
function create() {
    bg = new FlxSprite(0, 0);
	bg.frames = Paths.getSparrowAtlas('stages/evo/bgAssets');
    bg.animation.addByPrefix('idle','frame',8);
    bg.antialiasing = false;
	bg.animation.play('idle');
	insert(0, bg);
}
function postCreate() {
    enableCameraHacks = false;
    tilt_offset = 1;
    tilt_isHUDlerped = false;
}
function stepMania(result:Int) {
    
    switch (Std.parseInt(result)) {
        case 1: 
            tilt_offset = 5;
    }
    
}