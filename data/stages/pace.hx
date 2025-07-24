import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;

aura = new CustomShader('Aura');
var noteOffsets = [0,0];
public var noteMoveAmt = 150;
function postCreate() {
    camGame.addShader(aura);
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
}
//    	cameraNotePoint.x = FlxMath.lerp(cameraNotePoint.x, noteOffsets[0], camFollowRate); 
//	cameraNotePoint.y = FlxMath.lerp(cameraNotePoint.y, noteOffsets[1], camFollowRate); 
var localTime:Float = 0;
function update(elapsed:Float) {
    localTime += elapsed;
    aura.iTime = localTime;
    backDrop.angle -= 0.04;
    //backDrop1.angle += 0.04;
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

    if(strumLines.members[curCameraTarget].characters[curCameraTarget] == strumLines.members[0].characters[0]){
        camGame.zoom = FlxMath.lerp(camGame.zoom, 1.1, 0.05);
    }
}

