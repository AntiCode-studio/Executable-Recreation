import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
import flixel.util.FlxStringUtil;
import funkin.backend.system.framerate.Framerate;
import flixel.text.FlxTextBorderStyle;
//for(i in [iconP2, iconP1, scoreTxt, accuracyTxt]) remove(i);

function postCreate() {
    FlxTween.tween(Framerate.offset, {y: 65}, .5, {ease: FlxEase.cubeOut});

    timeBarBG = CoolUtil.loadAnimatedGraphic(new FlxSprite(0, FlxG.height * 0.02), Paths.image('game/timeBar'));
	timeBarBG.screenCenter();
    timeBarBG.y -= 340;
    timeBarBG.scale.set(1.5, 1.5);
    timeBarBG.alpha = 0;
	insert(members.indexOf(strumLines), timeBarBG);

	timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBarFillDirection.LEFT_TO_RIGHT, timeBarBG.width, timeBarBG.height, inst, 'time', 0, inst.length);
	timeBar.createFilledBar(0xff000000, 0xffffffff);
	timeBar.numDivisions = timeBar.width;
    timeBar.scale.set(3.1, 2.5);
    timeBar.alpha = 0;
	insert(members.indexOf(strumLines), timeBar);

    for (e in [timeBarBG, timeBar]) {
		e.cameras = [camHUD];
	}
    
    remove(accuracyTxt);
    remove(scoreTxt);
    remove(missesTxt);

    songinfo = new FunkinText(150, 0, 0, accuracyTxt.text + ' ' + scoreTxt.text + ' ' + missesTxt.text, 70);
    songinfo.setFormat(Paths.font("sonic-classic-open-xl.ttf"), 40, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	add(songinfo);
    songinfo.screenCenter(FlxAxes.X);
    songinfo.cameras = [camHUD];
    songinfo.alpha = 0;
    
    songName = new FunkinText(0, 0, 0, PlayState.SONG.meta.displayName, 70);
    songName.setFormat(Paths.font("sonic-classic-open-xl.ttf"), 40, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	add(songName);
    songName.cameras = [camHUD];
    songName.alpha = 0;

}

function onSongStart() {
    for (e in [songinfo, timeBar, songName]) {
		FlxTween.tween(e, {alpha: 1}, 2, {ease: FlxEase.quintInOut});
	}
}
function onPlayerHit(event:NoteHitEvent) {
    songinfo.text = accuracyTxt.text + ' ' + scoreTxt.text + ' ' + missesTxt.text;
    songinfo.scale.set(1.1, 1.05);
}
function onPlayerMiss(event:NoteMissEvent) {
    songinfo.text = accuracyTxt.text + ' ' + scoreTxt.text + ' ' + missesTxt.text;
}
function postUpdate(){
    songinfo.scale.set(lerp(songinfo.scale.x, 1, 0.33), lerp(songinfo.scale.x, 1, 0.33));
}