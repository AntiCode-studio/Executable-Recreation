import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;

aura = new CustomShader('Aura');
var noteOffsets = [0,0];
public var noteMoveAmt = 150;

var paceSky:FlxBackdrop;
var pacefloor:FlxBackdrop;
var fgtree:FlxBackdrop;
function postCreate() {
    camGame.addShader(aura);
}
var isRun = false;
function paceRun(trueOrFalse:Bool) {
    trace(trueOrFalse);
    if(trueOrFalse =="false"){
        fgtree.visible = false;
        paceSky.visible = false;
        pacefloor.visible = false;
        sun.visible = false;
        sun2.visible = false;
        isRun = false;
    }else{
        //strumLines.members[0].characters[1].visible = true;
        //strumLines.members[0].characters[0].visible = false;
        prlBG.alpha = 0;
        redBG.alpha = 0;
        redBG2.alpha = 0;
        redFog.alpha = 0;
        redFog2.alpha = 0;
        fgtree.visible = true;
        paceSky.visible = true;
        pacefloor.visible = true;
        sun.visible = true;
        sun2.visible = true;
        isRun = true;

        strumLines.members[0].characters[0].scale.set(0.6, 0.6);
    }
    
}
function dark(blabla:Int) {
    trace(blabla);
    if(blabla == '0'){
        bgB.alpha = 1;
    }
    if(blabla == '1'){
        bgB.alpha = 0;
    }
}
function bgSet(bgSetFun:Int) {
    if(bgSetFun == '0' || bgSetFun == 0){
        prlBG.alpha     = 1;
        redBG.alpha     = 0;
        redBG2.alpha    = 0;
        redFog.alpha    = 0;
        redFog2.alpha   = 0;
    }else if(bgSetFun == '1' || bgSetFun == 1){
        prlBG.alpha     = 0;
        redBG.alpha     = 1;
        redBG2.alpha    = 0;
        redFog.alpha    = 0;
    }else if(bgSetFun == '2' || bgSetFun == 2){
        prlBG.alpha     = 0;
        redBG.alpha     = 1;
        redBG2.alpha    = 1;
        redFog.alpha    = 1;
        redFog2.alpha   = 1;
    }else if(bgSetFun == '3' || bgSetFun == 3){
        prlBG.alpha     = 1;
        redBG.alpha     = 1;
        redBG2.alpha    = 1;
        redFog.alpha    = 1;
        redFog2.alpha   = 1;
    }
}
function create() {
    gradiRed = FlxGradient.createGradientFlxSprite(1, 1080, [FlxColor.BLACK, FlxColor.PURPLE]);
    gradiRed.scale.x = FlxG.width + 1300;
    gradiRed.scale.y ++;
	gradiRed.updateHitbox();
    gradiRed.screenCenter();
    //gradiRed.blend = BlendMode.DARKEN;
	gradiRed.active = true;
    //gradiRed.shader = skyset;
	gradiRed.scrollFactor.set(0, 0);
	//add(gradiRed);
    insert(members.indexOf(gf), gradiRed);

    backDrop = new FlxBackdrop(Paths.image('menus/qube'));
    backDrop.y = -500;
    //backDrop.velocity.set(-150, 50);
    backDrop.scale.set(1, 1);
    insert(members.indexOf(gf), backDrop);
    backDrop.blend = BlendMode.DARKEN;
    backDrop1 = new FlxBackdrop(Paths.image('menus/Grid_lmao'));
    backDrop1.y = -500;
    //backDrop.velocity.set(-150, 50);
    backDrop1.scale.set(2, 2);
    insert(members.indexOf(gf), backDrop1);
    backDrop1.blend = BlendMode.ADD;
    //backDrop1.alpha = 0.3;
    backDrop1.color = 0x41003D;
    //backDrop1.angle = 140;
    //FlxTween.tween(backDrop, {y: backDrop.y + 200}, 3, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});

    paceSky = new FlxBackdrop(Paths.image('stages/pace/v1/prun/pacesky'), 1, 0);
    paceSky.scale.set(2, 2);
    paceSky.velocity.set(-650, 0);
    insert(members.indexOf(gf), paceSky);
    paceSky.y = 200;

    sun = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	insert(members.indexOf(gf),sun);
    sun2 = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	insert(members.indexOf(gf),sun2);

    pacefloor = new FlxBackdrop(Paths.image('stages/pace/v1/prun/floor'), 1, 0);
    pacefloor.scale.set(1.3, 1.3);
    pacefloor.velocity.set(-850, 0);
    insert(members.indexOf(gf), pacefloor);
    pacefloor.y = 1000;

    fgtree = new FlxBackdrop(Paths.image('stages/pace/v1/prun/fgtree'), 1, 0);
    fgtree.scale.set(1.3, 3);
    fgtree.velocity.set(-1050, 0);
    add(fgtree);
    fgtree.y = 300;

    
    redFog2.visible = false;
    fgtree.visible = false;
    paceSky.visible = false;
    pacefloor.visible = false;
    sun.visible = false;
    sun2.visible = false;

    bgSet(0);

    bgB = new FlxSprite(-700, 0);
    bgB.loadGraphic(Paths.image('stages/pace/v2/p3/Untitled4126_Restored_Restored2_20230804185558'));
    add(bgB);
    bgB.scale.set(3, 3);
    bgB.alpha = 0;
    bgB.blend = BlendMode.DARKEN;
}
//    	cameraNotePoint.x = FlxMath.lerp(cameraNotePoint.x, noteOffsets[0], camFollowRate); 
//	cameraNotePoint.y = FlxMath.lerp(cameraNotePoint.y, noteOffsets[1], camFollowRate); 
var localTime:Float = 0;
var backDropAlpha = 0;
function update(elapsed:Float) {
    localTime += elapsed;
    aura.iTime = localTime;
    backDrop.angle -= 0.04;

    sun.angle -= 0.04;
    sun2.angle += 0.04;
    //backDrop1.angle += 0.04;
    backDrop.alpha = FlxMath.lerp(backDrop.alpha, backDropAlpha, 0.15);
    backDrop1.alpha = FlxMath.lerp(backDrop1.alpha, backDropAlpha, 0.15);
    backDrop.velocity.set(FlxMath.lerp(backDrop.velocity.x, noteOffsets[0], 0.04), FlxMath.lerp(backDrop.velocity.y, noteOffsets[1], 0.04));
    backDrop1.velocity.set(FlxMath.lerp(backDrop1.velocity.x, noteOffsets[1], 0.04), FlxMath.lerp(backDrop1.velocity.y, noteOffsets[0], 0.04));
    for (i in strumLines.members[curCameraTarget].characters){
        switch(i.getAnimName()){
            case "singLEFT" | "singLEFT-alt":
                noteOffsets = [-noteMoveAmt, 0];
            case "singDOWN" | "singDOWN-alt":
                noteOffsets = [0, noteMoveAmt];
            case "singUP" | "singUP-alt":
                noteOffsets = [0, -noteMoveAmt];
            case "singRIGHT" | "singRIGHT-alt":
                noteOffsets = [noteMoveAmt, 0];
            case "idle":
                noteOffsets = [10, -10];
        }
    }

    var shadowScale = 1 + PlayState.instance.defaultCamZoom - camGame.zoom;

    if (!isRun){
        strumLines.members[0].characters[0].scale.set(shadowScale, shadowScale);
        if(strumLines.members[curCameraTarget].characters[curCameraTarget] == strumLines.members[0].characters[0]){
            camGame.zoom = FlxMath.lerp(camGame.zoom, 1.2, 0.05);
        }
    }
    
}

