import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween.FlxTweenType;
import funkin.backend.utils.AudioAnalyzer;
//import flixel.addons.display.waveform.FlxWaveform;
import funkin.game.Character;
import funkin.options.type.SliderOption;
import flixel.addons.ui.FlxSlider;
import funkin.editors.ui.UISlider;

var rotationTime:Float = 0;
var rotationInterval:Float = 5; // секунды

var bf = new Character(0, 0, "bf", true);
var legenda = new Character(0, 0, "legend");

// Переменные для ползунков
var tracks:Array<FlxSprite> = [];
var handles:Array<FlxSprite> = [];
var isDragging:Array<Bool> = [];
var currentValues:Array<Float> = [0., 0., 0., 0.]; // Начальные значения
var sliderLabels:Array<FlxText> = [];
var valueTexts:Array<FlxText> = [];

// Названия параметров
var paramNames:Array<String> = ['Brightness', 'HUE', 'Contrast', 'Saturation'];

var currentBrightness = 0;

// Чекбокс переменные
var checkbox:FlxSprite;
var checkboxChecked:Bool = true;
var checkboxLabel:FlxText;

function postCreate() {
    backdrop = new FlxBackdrop(Paths.image('editors/bgs/debugBg'));
    backdrop.updateHitbox();
    backdrop.velocity.set(60/2, -10/2);
    backdrop.alpha = 0.6;
    backdrop.rotation = -20;
    backdrop.zoom = 0.8;
    add(backdrop);
    FlxTween.tween(backdrop, {zoom: 1}, 5, {ease: FlxEase.quintInOut, type: FlxTweenType.PINGPONG});

    sonic = new FlxSprite();
    sonic.loadGraphic(Paths.image('editors/debug/player'));
    sonic.updateHitbox();
    sonic.scale.set(0.4,0.4);
    sonic.screenCenter();
    sonic.x = 1000;
    sonic.antialiasing = true;
    //add(sonic);
    sonic.shader = initErectShader(currentBrightness, 0, 0, 0);
    FlxTween.tween(sonic, {x: -500}, 2, {ease: FlxEase.quintInOut});

    cinos = new FlxSprite();
    cinos.loadGraphic(Paths.image('editors/debug/opp'));
    cinos.updateHitbox();
    cinos.scale.set(0.4,0.4);
    cinos.screenCenter();
    cinos.x = -1000;
    cinos.antialiasing = true;
    //add(cinos);
    cinos.shader = initErectShader(currentBrightness, 0, 0, 0);
    FlxTween.tween(cinos, {x: 300}, 2, {ease: FlxEase.quintInOut});

	bf.dance();
    //bf.flipX = true;
    bf.updateHitbox();
    bf.screenCenter();
    bf.x = -1000;
    bf.y -= 300;
    FlxTween.tween(bf, {x: 800}, 2, {ease: FlxEase.quintInOut});
	add(bf);
    bf.shader = initErectShader(currentBrightness, 0, 0, 0);

    legenda.dance();
    //bf.flipX = true;
    legenda.updateHitbox();
    legenda.screenCenter();
    legenda.x = 1400;
    legenda.y -= 200;
    FlxTween.tween(legenda, {x: 200}, 2, {ease: FlxEase.quintInOut});
	add(legenda);
    legenda.shader = initErectShader(currentBrightness, 0, 0, 0);

    // Создаем 4 ползунка
    for (i in 0...4) {
        // Трек слайдера
        var track = new FlxSprite(100, 100 + i * 60);
        track.makeGraphic(200, 10, FlxColor.GRAY);
        add(track);
        tracks.push(track);
        
        // Ползунок
        var handle = new FlxSprite(100, 95 + i * 60);
        handle.makeGraphic(20, 20, getHandleColor(i));
        add(handle);
        handles.push(handle);
        
        // Метка параметра
        var label = new FlxText(20, 95 + i * 60, 80, paramNames[i] + ":", 16);
        add(label);
        sliderLabels.push(label);
        
        // Текст значения
        var valueText = new FlxText(310, 95 + i * 60, 60, "50%", 16);
        add(valueText);
        valueTexts.push(valueText);
        
        // Флаг перетаскивания
        isDragging.push(false);
        
        // Обновляем позицию
        updateHandlePosition(i);
        updateValueText(i);
    }
    
    // Создаем чекбокс
    checkbox = new FlxSprite(100, 350);
    checkbox.makeGraphic(20, 20, FlxColor.WHITE);
    add(checkbox);
    
    checkboxLabel = new FlxText(130, 350, 200, "+", 16);
    add(checkboxLabel);
    
    updateCheckboxAppearance();
}
function destroy():Void
{

}
var colorShader = new CustomShader('adjustColor');
function initErectShader(brightness:Float, hue:Float, contrast:Float, saturation:Float):CustomShader
{
    trace(brightness, hue, contrast, saturation);
    colorShader.brightness = brightness;
    colorShader.hue = hue;
    colorShader.contrast = contrast;
    colorShader.saturation = saturation;
    return colorShader;
}

function updateCheckboxAppearance():Void {
    if (checkboxChecked) {
        checkbox.color = FlxColor.GREEN;
        checkboxLabel.text = "+";
    } else {
        checkbox.color = FlxColor.RED;
        checkboxLabel.text = "-";
    }
}

function toggleCheckbox():Void {
    checkboxChecked = !checkboxChecked;
    updateCheckboxAppearance();
}

function update(elapsed:Float) {

    //trace(analyzer.analyze(0, 80));
    rotationTime += elapsed;
    if (controls.BACK) {
		FlxG.sound.play(Paths.sound("cancelMenu"), 0.7);
		FlxG.switchState(new ModState('debug/TestStateSelect'));
	}
    backdrop.rotation += 0.005;

    // Обрабатываем каждый ползунок
    for (i in 0...4) {
        // Начало перетаскивания
        if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(handles[i])) {
            isDragging[i] = true;
        }
        
        // Конец перетаскивания
        if (FlxG.mouse.justReleased) {
            isDragging[i] = false;
        }
        
        // Перетаскивание
        if (isDragging[i]) {
            handles[i].x = FlxG.mouse.x - handles[i].width / 2;
            
            // Ограничиваем в пределах трека
            if (handles[i].x < tracks[i].x) handles[i].x = tracks[i].x;
            if (handles[i].x > tracks[i].x + tracks[i].width - handles[i].width) {
                handles[i].x = tracks[i].x + tracks[i].width - handles[i].width;
            }
            
            // Обновляем значение
            currentValues[i] = (handles[i].x - tracks[i].x) / (tracks[i].width - handles[i].width);
            
            // Обновляем текст значения
            updateValueText(i);
            
            // Применяем параметр в зависимости от индекса
            if(checkboxChecked){
                applyParameter(i, currentValues[i] * 1000);
            }else{
                applyParameter(i, -Math.abs(currentValues[i] * 1000));
            }
            
        }
    }
    
    // Обработка клика по чекбоксу
    if (FlxG.mouse.justPressed) {
        var mouseX = FlxG.mouse.x;
        var mouseY = FlxG.mouse.y;
        
        if (mouseX >= checkbox.x && mouseX <= checkbox.x + checkbox.width &&
            mouseY >= checkbox.y && mouseY <= checkbox.y + checkbox.height) {
            toggleCheckbox();
        }
    }
}
function updateHandlePosition(index:Int) {
    handles[index].x = tracks[index].x + (tracks[index].width - handles[index].width) * currentValues[index];
}

function updateValueText(index:Int) {
    valueTexts[index].text = Math.round(currentValues[index] * 100) + "%";
}

function applyParameter(index:Int, value:Float) {
    trace(value);
    switch (index) {
        case 0:
            colorShader.brightness = value;
            trace(value);
            
        case 1:
            colorShader.hue = value;
            
        case 2:
            colorShader.contrast = value;
            
        case 3: 
            colorShader.saturation = value;
    }
}

function getHandleColor(index:Int):FlxColor {
    return switch (index) {
        case 0: FlxColor.RED;      // Громкость - красный
        case 1: FlxColor.BLUE;     // Басы - синий
        case 2: FlxColor.GREEN;    // Тембр - зеленый
        case 3: FlxColor.YELLOW;   // Скорость - желтый
        default: FlxColor.WHITE;
    }
}

// Дополнительная функция для установки значений извне
public function setSliderValue(index:Int, value:Float) {
    if (index >= 0 && index < 4) {
        currentValues[index] = value;
        updateHandlePosition(index);
        updateValueText(index);
        applyParameter(index, value);
    }
}

// Получение текущих значений
public function getSliderValue(index:Int):Float {
    return (index >= 0 && index < 4) ? currentValues[index] : 0;
}