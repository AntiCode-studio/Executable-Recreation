import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;

var bgChars = [];
var zombies = [];

vhsCompoced = new CustomShader('vhsCompoced');
importScript("data/scripts/resizing");
ratioThing(960, 720, false);

importScript("data/huds/composedv3");
portVisible = false;

wave = new CustomShader('wave');

chromCushion = new CustomShader('ChromCushion');
highContrast = new CustomShader('highContrast');
mosaic = new CustomShader('Mosaic');

introLength = 0;

function create() {
    generateChars();
    remove(strumLines.members[3].characters[0]);
    insert(members.indexOf(pc), strumLines.members[3].characters[0]);
    strumLines.members[3].characters[0].flipX = false;
    strumLines.members[3].characters[0].alpha = 0;
    vhsCompoced.alpha = 1.0;
    //camGame.addShader(vhsCompoced);
    chromCushion.amount = 0;
    FlxTween.tween(chromCushion, {amount: 0.5}, 2, {ease: FlxEase.cubeInOut, type: FlxTweenType.PINGPONG});
    camGame.addShader(chromCushion);
    camGame.addShader(highContrast);
    highContrast.contrast = 1.25;
    tvlight.blend = BlendMode.SHADER;
    //tvlight.alpha = 0.5;

    tvlight.alpha = 0;
    pc.alpha = 0;
    tvstat.alpha = 0;
    tvbg.alpha = 0;
    strumLines.members[3].characters[0].scrollFactor.set(0,0);

    strumLines.members[3].characters[0].screenCenter();
    tvbg.screenCenter();
    tvstat.screenCenter();
    pc.screenCenter();
    tvlight.screenCenter();

    strumLines.members[3].characters[0].y -= 200;

    staticAnim.screenCenter();
    staticAnim.animation.play('idle');
    staticAnim.alpha = 0;

    strumLines.members[3].characters[0].scale.set(2,2);
    tvbg.scale.set(2,2);
    tvstat.scale.set(2,2);
    pc.scale.set(2,2);
    tvlight.scale.set(2,2);

    tvstat.shader = wave;
    wave.frequency = 8.0;
    wave.amplitude = 0.05;

    card = new FlxSprite().loadGraphic(Paths.image('stages/composted/collect'));
    card.scale.set(0.4,0.4);
    card.updateHitbox();
    card.screenCenter();
    card.camera = camHUD;
    card.angle = -45;
    card.y = FlxG.height * 1.25;
    add(card);
}

function onSongStart() {

    FlxG.sound.play(Paths.sound('page2'));
    FlxTween.tween(card, {angle: 0, y: (FlxG.height - card.height)/2}, 1, {ease: FlxEase.circOut,onComplete: Void->{
        var time = 0.5;
        new FlxTimer().start(time, (_) -> [
                FlxG.sound.play(Paths.sound('page1'),0.3)
            ]);
        FlxTween.tween(card, {y: FlxG.height * 1.25, angle: 25}, 2, {startDelay: time,ease: FlxEase.sineInOut});
    }});

}

function leaveZombie(z) {
    FlxTween.tween(z, {alpha: 0},1, {onComplete: (f)->{z.destroy();}});
}

function generateZombie() {
    var ranomd = FlxG.random.int(1,2);
    var zombie = new FlxSprite(1250);
    zombie.frames = Paths.getSparrowAtlas('stages/composted/zom' + ranomd);
    zombie.animation.addByPrefix('zom','zom');
    zombie.animation.play('zom');

    var bg = FlxG.random.bool(50);
    if (bg) {

        zombie.y = 150;
        zombie.scale.set(0.35,0.35);
        zombie.updateHitbox();
        insert(members.indexOf(fence),zombie);
        zombie.velocity.x = -100;
        zombie.x = 700;
        zombie.scrollFactor.set(fence.scrollFactor.x,fence.scrollFactor.y);
    }
    else {
        zombie.scale.set(1.25,1.25);
        zombie.updateHitbox();
        zombie.y = 300;
        insert(members.indexOf(boyfriend) + 1,zombie);
        zombie.velocity.x = -200;
        zombie.scrollFactor.set(1.2,1.2);
    }

    zombie.alpha = 0;
    FlxTween.tween(zombie, {alpha: 1},1);
    zombies.push(zombie);
}
var phace2:Bool = false;

function fadePlant(plantNum) {
    plantNum -= 1;
    for (i in 0...bgChars.length){
        var obj = bgChars[plantNum];
        //trace(obj);
        FlxTween.tween(obj, {alpha: 1}, 2, {ease: FlxEase.backOut});
    }
    //trace(bgChars.members);
    //bgChars.forEach(function(item:FlxSprite)
	//{
    //    trace(item.ID);
	//	
	//});
}

function phaceChange(trueOrFalse:Bool) {
    if(trueOrFalse =="true"){
        for(i in [pc, tvstat, tvstat, tvbg, strumLines.members[3].characters[0], staticAnim]){
        FlxTween.tween(i, {alpha: 1}, 1, {ease: FlxEase.backOut,onComplete: function(f:FlxTween) {
                FlxTween.tween(staticAnim, {alpha: 0}, 1, {ease: FlxEase.backOut});
            }
        });
        FlxTween.tween(tvlight, {alpha: 0.5}, 2, {ease: FlxEase.backOut});
        phace2 = true;
    }
    }else{
        for(i in [pc, tvstat, tvstat, tvbg, strumLines.members[3].characters[0], staticAnim, tvlight]){
            i.alpha = 0;
            phace2 = false;
        }
    }
}

function generateChars() {
    for (i in 1...6) {
        b = new FlxSprite(-300,-900);
        b.frames = Paths.getSparrowAtlas('stages/composted/bgChars');
        b.animation.addByPrefix('idle', 'plant' + i, 15, false);
        b.animation.play('idle');
        if (i == 5) insert(members.indexOf(tvbg), b);
        else insert(members.indexOf(dad), b);
        b.alpha = 0;
        bgChars.push(b);
    }
}

var localTime:Float = 0;
function update(elapsed:Float) {
    localTime += elapsed;
    vhsCompoced.iTime = localTime;
    wave.iTime = localTime;

    //highContrast.contrast = health;
}
var rotate:Bool;
function postUpdate(elapsed:Float) {
    for (i in 0...zombies.length) {
        //zombies[i].angle --;
        var obj = zombies[i];
        if (obj != null)  {
            var threshold = -1000;
            if (obj.scale.x < 0.5) {
                threshold = -250;
            }
    
            if (obj.x < threshold) {
                leaveZombie(obj);
                zombies.remove(obj);
            }
        }

    }

    //if(controls.ACCEPT){
    //    rotate = true;
    //}

    if(rotate){
        for (ge in 0...members.length) {
            members[ge].angle --;
        }
    } 
}

function destroy() {
    ratioThing(1280, 720, false);
}
function stepHit(curStep:Int) {
    switch (curStep) {
        case 684: 
            camGame.setFilters();
            ratioThing(1281, 720, false);
        case 944:
            camGame.addShader(chromCushion);
            camGame.addShader(highContrast);
            ratioThing(800, 600, true);
        case 1564: 
            camGame.setFilters();
            ratioThing(1281, 720, false);
        case 1616:
            camGame.addShader(chromCushion);
            camGame.addShader(highContrast);
            ratioThing(800, 600, true);
    }

    if(curStep % 16 == 0){
        if (FlxG.random.bool(10) && curStep >= 19) generateZombie();
        //trace('section');
    }
}