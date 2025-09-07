package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import openfl.events.Event;
import openfl.net.FileReference;
import openfl.utils.ByteArray;
import sys.FileSystem;
import sys.io.File;
import openfl.net.FileFilter;

private var fileRef:FileReference;
private var currentSound:FlxSound;
private var statusText:FlxText;

function create():Void
{
    
    statusText = new FlxText(0, 0, FlxG.width, "Нажмите для выбора аудиофайла");
    statusText.setFormat(Paths.font("joystix monospace.otf"), 24, FlxColor.WHITE, 'center');
    statusText.screenCenter();
    add(statusText);
    
    fileRef = new FileReference();
    fileRef.addEventListener('select', onFileSelected);
    fileRef.addEventListener('complete', onFileLoaded);
}

function update(elapsed:Float):Void
{
    
    if (FlxG.mouse.justPressed)
    {
        selectAudioFile();
    }
}

private function selectAudioFile():Void
{
    var audioFilter = new FileFilter("Audio Files", "*.mp3;*.wav;*.ogg");
    fileRef.browse([audioFilter]);
}

private function onFileSelected(event:Event):Void
{
    statusText.text = "Загрузка: " + fileRef.name;
    fileRef.load();
}

private function onFileLoaded(event:Event):Void
{
    statusText.text = "Обработка: " + fileRef.name;
    
    if (currentSound != null && currentSound.playing)
    {
        currentSound.stop();
        currentSound.destroy();
    }
    
    try
    {
        // Сохраняем во временный файл
        var tempPath:String = "temp_audio" + getFileExtension(fileRef.name);
        var bytes:ByteArray = fileRef.data;
        
        #if sys
        File.saveBytes(tempPath, bytes);
        
        // Используем абсолютный путь для загрузки
        var absolutePath:String = FileSystem.absolutePath(tempPath);
        currentSound = FlxG.sound.load(absolutePath);
        currentSound.play();
        
        statusText.text = "Воспроизведение: " + fileRef.name;
        
        currentSound.onComplete = function() {
            statusText.text = "Завершено. Нажмите для нового файла";
            
            // Удаляем временный файл
            if (FileSystem.exists(tempPath))
            {
                FileSystem.deleteFile(tempPath);
            }
        };
        #else
        statusText.text = "Sys not available for this platform";
        #end
    }
    catch (e:Dynamic)
    {
        statusText.text = "Ошибка: " + e;
    }
}

function getFileExtension(filename:String):String
{
    var dotIndex:Int = filename.lastIndexOf(".");
    return (dotIndex == -1) ? ".tmp" : filename.substring(dotIndex);
}

function destroy():Void
{
    if (currentSound != null)
    {
        currentSound.stop();
        currentSound.destroy();
    }
    
    fileRef.removeEventListener(Event.SELECT, onFileSelected);
    fileRef.removeEventListener(Event.COMPLETE, onFileLoaded);
    
}
