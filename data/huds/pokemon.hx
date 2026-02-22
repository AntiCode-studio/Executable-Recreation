import flixel.util.FlxStringUtil;
import flixel.math.FlxRect;
import flixel.util.helpers.FlxBounds;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.math.FlxPoint;
import flixel.text.FlxBitmapText;
public var daPixelZoom = PlayState.daPixelZoom;

var timeFrame:FlxSprite;
var minuteNum:FlxBitmapText;
var secNum:FlxBitmapText;
var secNum2:FlxBitmapText;

var healthFrame:FlxSprite;

var healthbar:FlxSprite;
var healthClip:FlxRect;

var stars:FlxTypedGroup;

var scale:Float = 3;

var healthbarBG2:FlxSprite;

public var healthBounds:FlxBounds<Float> = new FlxBounds(0.0, 2.0);

function createUI() {
    for(i in [iconP2, iconP1, scoreTxt, accuracyTxt, healthBar, healthBarBG]) remove(i);
    timeFrame = new FlxSprite().loadGraphic(Paths.image('stages/evo/hud/timeFrame'));
    timeFrame.scale.set(scale,scale);
    timeFrame.updateHitbox();
    var timeFrameY = downscroll ? FlxG.height - timeFrame.height - 70 : 70;
    timeFrame.y = timeFrameY;
    timeFrame.screenCenter(FlxAxes.X);
    timeFrame.camera = camHUD;
    add(timeFrame);
    timeFrame.pixelPerfectPosition = true;

    var timeFont = FlxBitmapFont.fromMonospace(Paths.image('stages/evo/hud/numbers'),'1234567890',FlxPoint.get(6,12));

    minuteNum = new FlxBitmapText();
    secNum = new FlxBitmapText();
    secNum2 = new FlxBitmapText();

    for (i in [minuteNum,secNum,secNum2]) {
        i.font = timeFont;
        i.text = '1';
        i.scale.set(scale,scale);
        i.updateHitbox();
        i.camera = camHUD;
        add(i); 
        i.pixelPerfectPosition = true;
    }

    minuteNum.setPosition(timeFrame.x + (6*scale), timeFrame.y + (5*scale));
    minuteNum.camera = camHUD;
    secNum.setPosition(timeFrame.x + (18*scale), timeFrame.y + (5*scale));
    secNum.camera = camHUD;
    secNum2.setPosition(timeFrame.x + (25*scale), timeFrame.y + (5*scale));
    secNum2.camera = camHUD;

    healthbarBG2 = new FlxSprite().loadGraphic(Paths.image('stages/evo/hud/color'));
    healthbarBG2.camera = camHUD;

    healthbar = new FlxSprite().loadGraphic(Paths.image('stages/evo/hud/color'));
    healthbar.color = 0x18C320;
    healthbar.camera = camHUD;

    healthClip = new FlxRect(healthbar.x,healthbar.y,79,3);
    healthClip.width /=2;
    healthbar.clipRect = healthClip;

    healthFrame = new FlxSprite().loadGraphic(Paths.image('stages/evo/hud/hpBar'));
    healthFrame.camera = camHUD;

    for (i in [healthbarBG2,healthbar,healthFrame]) {
        i.scale.set(scale,scale);
        i.updateHitbox();
        add(i);
    }

    var healthY = downscroll ? 50 : FlxG.height - healthFrame.height - 50;
    healthFrame.setPosition(FlxG.width -healthFrame.width,healthY);
    healthbar.setPosition(healthFrame.x + (27*scale), healthFrame.y + (6*scale));
    healthbarBG2.setPosition(healthbar.x, healthbar.y);
    stars = new FlxTypedGroup();
    add(stars);
    for (i in 0...6) {
        var star = new FlxSprite().loadGraphic(Paths.image('stages/evo/hud/stars'));
        star.scale.set(scale,scale);
        star.updateHitbox();
        star.y = healthFrame.y + (15 * scale);
        star.x = healthFrame.x + healthFrame.width - star.width - (i*(star.width - 1*scale)) - (1*scale);
        star.camera = camHUD;
        stars.add(star);
        star.pixelPerfectPosition = true;
    }

}

function alphaAllUpdate() {
    //trace(healthBarBG.alpha);
    timeFrame.alpha = healthBarBG.alpha;
    minuteNum.alpha = healthBarBG.alpha;
    secNum.alpha = healthBarBG.alpha;
    secNum2.alpha = healthBarBG.alpha;
    healthbarBG2.alpha = healthBarBG.alpha;
    healthbar.alpha = healthBarBG.alpha;
    healthFrame.alpha = healthBarBG.alpha;
    for (i in 0...6) {
        stars.members[i].alpha = healthbar.alpha;
    }
}

function postCreate() {
    createUI();
    camGame.pixelPerfectRender = true;
}

// Добавьте переменные для хранения предыдущих значений
var lastHealth:Float = -1;
var lastAccuracy:Float = -1;
var lastStarCount:Int = -1;

function onHealthChange() 
{
    // Проверяем, изменилось ли здоровье достаточно для обновления
    if (Math.abs(health - lastHealth) < 0.001) return; // Минимальное изменение
    
    var newWidth:Float = FlxMath.remapToRange(health, healthBounds.min, healthBounds.max, 0, 79);
    var newWidthRounded:Int = Math.floor(newWidth); // Округляем один раз
    
    // СПОСОБ 1: setSize() - самый понятный
    healthClip.setSize(newWidthRounded, 3);
    healthbar.clipRect = healthClip;
    healthbar.dirty = true;

    // Обновляем цвет на основе процента здоровья
    var percent = health * 50;
    var newColor:Int = healthbar.color;
    
    if (percent > 30) newColor = 0x18C320;
    else if (percent > 15) newColor = 0xFBB200;
    else newColor = 0xFB5928;
    
    // Меняем цвет только если он изменился
    if (newColor != healthbar.color) {
        healthbar.color = newColor;
    }
    
    lastHealth = health;
}

function onPlayerMiss() 
{
    // Не вызывайте onUpdateScore и onHealthChange здесь напрямую
    // Вместо этого обновите все в одном месте
    updateUI();
}

function onPlayerHit() 
{
    updateUI();
}

function updateUI() 
{
    onHealthChange();
    onUpdateScore();
}

function onUpdateScore() 
{
    // Обновляем звезды только если изменилась точность
    var currentAccuracy:Float = accuracy;
    if (Math.abs(currentAccuracy - lastAccuracy) < 0.001) return;
    
    var targetStarCount:Int = 0;
    
    if (misses == 0) {
        targetStarCount = 5; // Все звезды золотые
    } else {
        if (currentAccuracy > 0.9) targetStarCount = 5;
        else if (currentAccuracy > 0.8) targetStarCount = 4;
        else if (currentAccuracy > 0.7) targetStarCount = 3;
        else if (currentAccuracy > 0.6) targetStarCount = 2;
        else if (currentAccuracy > 0.5) targetStarCount = 1;
        else targetStarCount = 0;
    }
    
    // Обновляем звезды только если изменилось количество
    if (targetStarCount != lastStarCount || misses == 0) {
        starCount(targetStarCount);
        lastStarCount = targetStarCount;
    }
    
    lastAccuracy = currentAccuracy;
}

function starCount(count:Int) 
{
    for (i in 0...stars.length) 
    {
        if (misses == 0) {
            stars.members[i].color = 0xFFD745; // Золотой цвет
            continue;
        }

        var starIndex = stars.length - 1 - i;
        if (i <= count) {
            stars.members[starIndex].color = 0xFFFFFF; // Белый
        } else {
            stars.members[starIndex].color = 0x000000; // Черный
        }
    }
}

function update(elapsed:Float) 
{
    alphaAllUpdate();
    if (!PlayState.instance.paused)
    {
        var curTime:Float = inst.time;
        var songCalc:Float = (inst.length - curTime);
        var secondsTotal:Int = Math.floor(songCalc / 1000);
        
        if (secondsTotal < 0) secondsTotal = 0;

        var finalTime = FlxStringUtil.formatTime(secondsTotal, false);

        // Обновляем время только если оно изменилось
        if (minuteNum != null && secNum != null && secNum2 != null)
        {
            var timeParts:Array<String> = finalTime.split(":");
            
            if (timeParts.length >= 2)
            {
                // Проверяем, изменились ли значения перед обновлением
                if (minuteNum.text != timeParts[0]) {
                    minuteNum.text = timeParts[0];
                }
                
                if (secNum.text != timeParts[1].charAt(0)) {
                    secNum.text = timeParts[1].charAt(0);
                }
                
                if (secNum2.text != timeParts[1].charAt(1)) {
                    secNum2.text = timeParts[1].charAt(1);
                }
            }
        }
    }
}

function onNoteCreation(event) {
	event.cancel();

	var note = event.note;
	var strumID = event.strumID;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/pixelUI/noteSkins/arrowEnds'), true, 7, 6);
		var maxCol = Math.floor(note.graphic.width / 7);
		note.animation.add("hold", [strumID%maxCol]);
		note.animation.add("holdend", [maxCol + strumID%maxCol]);
	} else {
		note.loadGraphic(Paths.image('game/pixelUI/noteSkins/arrows-pixels'), true, 17, 17);
		var maxCol = Math.floor(note.graphic.width / 17);
		note.animation.add("scroll", [maxCol + strumID%maxCol]);
	}
	var strumScale = event.note.strumLine.strumScale;
	note.scale.set(daPixelZoom*strumScale, daPixelZoom*strumScale);
	note.updateHitbox();
	note.antialiasing = false;
}
function onPostNoteCreation(event) event.note.splash = "pixel-pokemon";
function onStrumCreation(event) {
    event.cancel();
	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/pixelUI/noteSkins/arrows-pixels'), true, 17, 17);
	var maxCol = Math.floor(strum.graphic.width / 17);
	var strumID = event.strumID % maxCol;

	strum.animation.add("static", [strumID]);
	strum.animation.add("pressed", [maxCol + strumID, (maxCol*2) + strumID], 12, false);
	strum.animation.add("confirm", [(maxCol*3) + strumID, (maxCol*4) + strumID], 24, false);

	var strumScale = strumLines.members[event.player].strumScale;
	strum.scale.set(daPixelZoom*strumScale, daPixelZoom*strumScale);
	strum.updateHitbox();
	strum.antialiasing = false;
}