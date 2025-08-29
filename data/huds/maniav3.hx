import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
import flixel.util.FlxStringUtil;
var timerVtoroi:String;
public var hideTime:Bool = false;
public var timerTxt:FlxSpriteGroup = new FlxSpriteGroup(180, 5);
static final numberFontCodes:Array<String> = [for(_ in 0...10) Std.string(_)];
var scaleTimer = 1.2;

var starsGrp:FlxGroup;

public var paoFliped:Bool = false;
function postCreate() {
    timeBG = new FlxSprite();
    timeBG.frames = Paths.getSparrowAtlas('game/hud/v3/time');
    timeBG.animation.addByPrefix('idle', 'time', 2, true);
    timeBG.scale.set(1.1, 1.1);
    timeBG.animation.play('idle');
    add(timeBG);

    hpBG = new FlxSprite();
    hpBG.frames = Paths.getSparrowAtlas('game/hud/v3/hp');
    hpBG.animation.addByPrefix('idle', 'hpf', 2, true);
    hpBG.scale.set(1.1, 1.1);
    hpBG.animation.play('idle');
    add(hpBG);

    hpBar1 = new FlxSprite();
    hpBar1.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar1.animation.addByPrefix('idle', '1', 2, true);
    hpBar1.scale.set(1.1, 1.1);
    hpBar1.animation.play('idle');
    add(hpBar1);
    hpBar2 = new FlxSprite();
    hpBar2.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar2.animation.addByPrefix('idle', '2', 2, true);
    hpBar2.scale.set(1.1, 1.1);
    hpBar2.animation.play('idle');
    add(hpBar2);
    hpBar3 = new FlxSprite();
    hpBar3.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar3.animation.addByPrefix('idle', '3', 2, true);
    hpBar3.scale.set(1.1, 1.1);
    hpBar3.animation.play('idle');
    add(hpBar3);
    hpBar4 = new FlxSprite();
    hpBar4.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar4.animation.addByPrefix('idle', '4', 2, true);
    hpBar4.scale.set(1.1, 1.1);
    hpBar4.animation.play('idle');
    add(hpBar4);
    hpBar5 = new FlxSprite();
    hpBar5.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar5.animation.addByPrefix('idle', '5', 2, true);
    hpBar5.scale.set(1.1, 1.1);
    hpBar5.animation.play('idle');
    add(hpBar5);
    hpBar6 = new FlxSprite();
    hpBar6.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar6.animation.addByPrefix('idle', '6', 2, true);
    hpBar6.scale.set(1.1, 1.1);
    hpBar6.animation.play('idle');
    add(hpBar6);
    hpBar7 = new FlxSprite();
    hpBar7.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar7.animation.addByPrefix('idle', '7', 2, true);
    hpBar7.scale.set(1.1, 1.1);
    hpBar7.animation.play('idle');
    add(hpBar7);
    hpBar8 = new FlxSprite();
    hpBar8.frames = Paths.getSparrowAtlas('game/hud/v3/healthanim');
    hpBar8.animation.addByPrefix('idle', '8', 2, true);
    hpBar8.scale.set(1.1, 1.1);
    hpBar8.animation.play('idle');
    add(hpBar8);

    ramka = new FlxSprite().loadGraphic(Paths.image('game/hud/v3/ramka'));
    ramka.scale.set(0.5, 0.5);
    add(ramka);

    ramka1 = new FlxSprite().loadGraphic(Paths.image('game/hud/v3/ramka'));
    ramka1.scale.set(ramka.scale.x, ramka.scale.y);
    ramka1.flipX = true;
    add(ramka1);

    hpFG = new FlxSprite().loadGraphic(Paths.image('game/hud/v3/hpBarFrame'));
    hpFG.scale.set(1.1, 1.1);
    add(hpFG);

    rating = new FlxSprite();
    rating.frames = Paths.getSparrowAtlas('game/hud/v3/rating');
    rating.animation.addByPrefix('idle', 'rating', 2, true);
    rating.scale.set(1.1, 1.1);
    rating.animation.play('idle');
    add(rating);

    imgTime = new FlxSprite().loadGraphic(Paths.image('game/hud/v3/timeNumbers'),true,36,54);
    imgTime.setGraphicSize(100);
    imgTime.updateHitbox();
    imgTime.animation.add('0',[0],12,false);
    imgTime.animation.add('1',[1],12,false);
    imgTime.animation.add('3',[3],12,false);
    imgTime.animation.add('4',[4],12,false);
    imgTime.animation.add('5',[5],12,false);
    imgTime.animation.add('6',[6],12,false);
    imgTime.animation.add('7',[7],12,false);
    imgTime.animation.add('8',[8],12,false);
    imgTime.animation.add('9',[9],12,false);
    imgTime.animation.add(':',[10],12,false);
    imgTime.animation.add('explode',[0,1,2,3,4,5,6,7,8,9,10],12,false);
    imgTime.screenCenter();
    //add(imgTime);
    imgTime.animation.play('explode');
    imgTime.camera = camHUD;

    for(i in [timeBG, hpBG, hpBar1, hpBar2, hpBar3, hpBar4, hpBar5, hpBar6, hpBar7, hpBar8, hpFG, rating, ramka1, ramka]){
        i.screenCenter();
        //i.scale.set(1, 1);
        i.camera = camHUD;
    };
    timerTxt.camera = camHUD;
    timerTxt.updateHitbox();
    timerTxt.screenCenter();
    add(timerTxt);
    timerTxt.x -= 90;
    timerTxt.y -= 280;

    timeBG.y -= 250;
    hpBG.y += 300;
    hpBar1.y += 300;
    hpBar2.y += 300;
    hpBar3.y += 300;
    hpBar4.y += 300;
    hpBar5.y += 300;
    hpBar6.y += 300;
    hpBar7.y += 300;
    hpBar8.y += 300;
    hpFG.y += 300;

    rating.y += 300;

    ramka.y += 180;
    ramka1.y = ramka.y;
    ramka.x += 480;
    ramka1.x -= 480;

    if (paoFliped) {
        portOponent = new FlxSprite(ramka.x, ramka.y).loadGraphic(Paths.image('game/hud/port/' + PlayState.SONG.meta.customValues.oppName));
    }else {
        portOponent = new FlxSprite(ramka1.x, ramka1.y).loadGraphic(Paths.image('game/hud/port/' + PlayState.SONG.meta.customValues.oppName));
        portOponent.flipX = true;
    }
    portOponent.updateHitbox();
    portOponent.scale.set(ramka.scale.x, ramka.scale.y);
    portOponent.camera = camHUD;
    add(portOponent);

    if (paoFliped) {
        portPlayer = new FlxSprite(ramka1.x, ramka1.y).loadGraphic(Paths.image('game/hud/port/' + PlayState.SONG.meta.customValues.playerName));
    }else {
        portPlayer = new FlxSprite(ramka.x, ramka.y).loadGraphic(Paths.image('game/hud/port/' + PlayState.SONG.meta.customValues.playerName));
        portPlayer.flipX = true;
    }
    portPlayer.updateHitbox();
    portPlayer.scale.set(ramka1.scale.x, ramka1.scale.y);
    portPlayer.camera = camHUD;
    add(portPlayer);

    for(aaa in [ramka, ramka1, portOponent, portPlayer]){
        remove(aaa);
        insert(members.indexOf(strumLines), aaa);
    }

    createText(timeString(), timerTxt, 0.40, scaleTimer);

    reroyexplodes = new FlxSprite().loadGraphic(Paths.image('bl'),true,90,125);
    reroyexplodes.animation.add('explode',[0,1,2,3,4,5,6,7,8,9,10,11,12,12,12,12,12,12,12,12],12,false);
    reroyexplodes.setGraphicSize(2560);
    reroyexplodes.screenCenter();
    //add(reroyexplodes);
    reroyexplodes.animation.play('explode');

    for(i in [iconP2, iconP1, scoreTxt, accuracyTxt, healthBar, healthBarBG]) remove(i);

    missesTxt.y += 20;

    camHUD.alpha = 0;

}
function paoUpdate(aaa:Bool) {
    paoFliped = aaa;
    //trace(paoFliped);
    portUpdate();
}
function portUpdate() {
    if(paoFliped){
        portOponent.x = ramka.x;
        portOponent.y = ramka.y;
        portPlayer.x = ramka1.x;
        portPlayer.y = ramka1.y;
        portOponent.flipX = false;
        portPlayer.flipX = false;
    }else {
        portOponent.x = ramka1.x;
        portOponent.y = ramka1.y;
        portPlayer.x = ramka.x;
        portPlayer.y = ramka.y;
        portOponent.flipX = true;
        portPlayer.flipX = true;
    }
}
static function updateTimeText(txt:String = '', textgroup:FlxSpriteGroup) {
	timerVtoroi = txt;
	return textgroup.forEach((spr) -> {
		if (txt.charAt(spr.ID) != spr.animation.name && spr.animation.name != '-1') {
			spr.animation.play(numberFontCodes.indexOf(txt.charAt(spr.ID)));
			if (spr.animation.name == '-1') spr.animation.play('0');
			//else spr.scale.set(1.1, 1.1);
		}
	});
}
function onSongStart() {
    FlxTween.tween(camHUD, {alpha: 1}, 2, {ease: FlxEase.quintInOut});
}
static function createText(txt:String = '', textgroup:FlxSpriteGroup, spacing:Float = 1, scale:Float = 1) {
	textgroup?.clear();

	for (char in 0...txt.length) {
		var newChar = new FlxSprite(85 * char * spacing * scale, 0);
		newChar.loadGraphic(Paths.image('game/hud/v3/timeNumbers'),true,36,54);
        
		for (code in numberFontCodes) newChar.animation.add(code, [code]);
		for (i in ['-1', '-']) newChar.animation.add(i, [10]);
		newChar.animation.play(numberFontCodes.indexOf(txt.charAt(char)));
		newChar.scale.set(scale, scale);
		newChar.updateHitbox();
		newChar.ID = char;
		textgroup.add(newChar);
	}
}
static function timeString() {
	final remainingTime = (inst.length - Conductor.songPosition) / 1000;
	final minutes = Math.floor(remainingTime / 60);
	final seconds = Math.floor(remainingTime % 60);
	return minutes + ' ' + (seconds < 10 ? '0' + seconds : seconds);
}
function onNoteCreation(note){

    note.noteSprite = "game/notes/ManiaNotes";
}

function onStrumCreation(note){
    note.sprite = "game/notes/ManiaNotes";
}
function postUpdate(){

    if (timeString() != timerVtoroi) updateTimeText(timeString(), timerTxt);

    //iconP2Fake.scale.set(lerp(iconP2Fake.scale.x, 0.6, 0.33), lerp(iconP2Fake.scale.y ,0.6, 0.33));
    //iconP1Fake.scale.set(lerp(iconP1Fake.scale.x, 0.6, 0.33), lerp(iconP1Fake.scale.y ,0.6, 0.33));
    //timeText.text = formatTime(inst.time / 1000);

    timeBG.alpha = healthBarBG.alpha;
    //timeText.alpha = healthBarBG.alpha;
    //iconP2Fake.alpha = healthBarBG.alpha;
    //iconP1Fake.alpha = healthBarBG.alpha;

    //trace(curRating.rating);
    if(health >= 0.09){
        hpBar1.alpha = 1;
    }else {
        hpBar1.alpha = 0;
    }
    if(health >= 0.69){
        hpBar2.alpha = 1;
    }else {
        hpBar2.alpha = 0;
    }
    if(health >= 0.89){
        hpBar3.alpha = 1;
    }else {
        hpBar3.alpha = 0;
    }
    if(health >= 0.99){
        hpBar4.alpha = 1;
    }else {
        hpBar4.alpha = 0;
    }
    if(health >= 1.09){
        hpBar5.alpha = 1;
    }else {
        hpBar5.alpha = 0;
    }
    if(health >= 1.19){
        hpBar6.alpha = 1;
    }else {
        hpBar6.alpha = 0;
    }
    if(health >= 1.59){
        hpBar7.alpha = 1;
    }else {
        hpBar7.alpha = 0;
    }
    if(health >= 1.99){
        hpBar8.alpha = 1;
    }else {
        hpBar8.alpha = 0;
    }
}

//function onDadHit() iconP2Fake.scale.set(0.8, 0.8);

//function onPlayerHit(event:NoteHitEvent) iconP1Fake.scale.set(0.8, 0.8);

function beatHit(){
    //iconP1Fake.scale.set(0.8, 0.8);
    //iconP2Fake.scale.set(0.8, 0.8);
} 

function hideNumbers(text:String):Void {
	var result:String = text;
	if (hideTime)
		for (i in 0...10)
			result = StringTools.replace(result, i, '#');
	return result;
}

function formatTime(time:Float):String {
	var result:Array<String> = [];

	var elapsed:String = FlxStringUtil.formatTime(time, ModOptions.tbTimeMS);
		var remainder:String = FlxStringUtil.formatTime(inst.length / 1000 - time, ModOptions.tbTimeMS);
		result.push(hideNumbers(switch (ModOptions.tbTimeType) {
			case 'elapsed': elapsed;
			case 'remainder': remainder;
			case 'both': remainder + ' ~ ' + elapsed;
		}));
	return result.join(' / ');
}