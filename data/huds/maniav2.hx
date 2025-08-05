import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
import flixel.util.FlxStringUtil;

for(i in [iconP2, iconP1, scoreTxt, accuracyTxt]) remove(i);

public var hideTime:Bool = false;
function postCreate() {
    timeBG = new FlxSprite(0,0).loadGraphic(Paths.image('game/hud/time'));
	add(timeBG);
    hudPort = new FlxSprite(0,0).loadGraphic(Paths.image('game/hud/idko'));
	add(hudPort);
    hudPort2 = new FlxSprite(0,0).loadGraphic(Paths.image('game/hud/idkp'));
	add(hudPort2);

    

    iconP1Fake = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
	iconP2Fake = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
    for(icon in [iconP1Fake, iconP2Fake]) {
		add(icon);
	}

    
    timeText = new FlxText(0, 0, 500, formatTime(inst.time / 1000), 60);
	timeText.alignment = 'center';
    timeText.font = Paths.font("sonic-classic-open-xl.ttf");
	add(timeText);

    for(i in [timeBG, hudPort, hudPort2, iconP1Fake, iconP2Fake, timeText]){
        i.screenCenter();
        i.scale.set(0.7, 0.7);
        i.camera = camHUD;
    };
    iconP1Fake.x += 490;
    iconP1Fake.y += 270;
    iconP2Fake.x -= 490;
    iconP2Fake.y += 270;
    timeBG.x -= 14;
    timeText.y -= 250;

}

function postUpdate(){

    iconP2Fake.scale.set(lerp(iconP2Fake.scale.x, 0.6, 0.33), lerp(iconP2Fake.scale.y ,0.6, 0.33));
    iconP1Fake.scale.set(lerp(iconP1Fake.scale.x, 0.6, 0.33), lerp(iconP1Fake.scale.y ,0.6, 0.33));
    timeText.text = formatTime(inst.time / 1000);

    hudPort.alpha = healthBarBG.alpha;
    hudPort2.alpha = healthBarBG.alpha;
    timeBG.alpha = healthBarBG.alpha;
    timeText.alpha = healthBarBG.alpha;
    iconP2Fake.alpha = healthBarBG.alpha;
    iconP1Fake.alpha = healthBarBG.alpha;
}

function onDadHit() iconP2Fake.scale.set(0.8, 0.8);

function onPlayerHit(event:NoteHitEvent) iconP1Fake.scale.set(0.8, 0.8);

function beatHit(){
    iconP1Fake.scale.set(0.8, 0.8);
    iconP2Fake.scale.set(0.8, 0.8);
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