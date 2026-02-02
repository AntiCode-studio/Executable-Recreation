var colorShader:CustomShader = new CustomShader('adjustColor');
colorShader.brightness = 0;
colorShader.hue = 0;
colorShader.contrast = 0;
colorShader.saturation = 0;

function create() {
    camGame.addShader(colorShader);
}

// чем гуще лес, if else if else....
function flashFunc(type:String, int:Int) {
	var bebe:Int = Std.parseInt(int);
	switch (type) {
		case 'Brightness':
			colorShader.brightness = bebe;
		case 'HUE':
			colorShader.hue = bebe;
		case 'Contrast':
			colorShader.contrast = bebe;
		case 'Saturation':
			colorShader.saturation = bebe;
	}
}


var brightnessBlock = false;
var hueBlock = false;
var contrastBlock = false;
var saturationBlock = false;

var brightnessTween:FlxTween;
var hueTween:FlxTween;
var contrastTween:FlxTween;
var saturationTween:FlxTween;

function onEvent(event) {
	switch (event.event.name) {
		case 'Cam Color Func':
            //trace(event.event.params[3]);
            if(event.event.params[3]){
                tweenColor(event.event.params[0], event.event.params[1], event.event.params[2]);
            }else{
                flashFunc(event.event.params[0], event.event.params[1]);
            }
	}
}

function tweenColor(type:String, int:Int, time:Int){
	//trace(type, int, time);
	var bebe:Int = Std.parseInt(int);
	var tete:Float = Std.parseFloat(time);
	//лес ещё гуще
	switch (type) {
		case 'Brightness':
			brightnessBlock = true;
			if (brightnessTween != null) brightnessTween.cancel();
			brightnessTween = FlxTween.tween(colorShader, {brightness: bebe}, (Conductor.stepCrochet / 1000) * time, {ease: FlxEase.cubeOut, onComplete: function(_) {
				//brightnessTween.cancel();
				brightnessBlock = false;
			}});
		case 'HUE':
			hueBlock = true;
			if (hueTween != null) hueTween.cancel();
			hueTween = FlxTween.tween(colorShader, {hue: bebe}, (Conductor.stepCrochet / 1000) * time, {ease: FlxEase.cubeOut, onComplete: function(_) {
				//hueTween.cancel();
				hueBlock = false;
			}});
		case 'Contrast':
			contrastBlock = true;
			if (contrastTween != null) contrastTween.cancel();
			contrastTween = FlxTween.tween(colorShader, {contrast: bebe}, (Conductor.stepCrochet / 1000) * time, {ease: FlxEase.cubeOut, onComplete: function(_) {
				//contrastTween.cancel();
				contrastBlock = false;
			}});
		case 'Saturation':
			saturationBlock = true;
			if (saturationTween != null) saturationTween.cancel();
			saturationTween = FlxTween.tween(colorShader, {saturation: bebe}, (Conductor.stepCrochet / 1000) * time, {ease: FlxEase.cubeOut, onComplete: function(_) {
				//saturationTween.cancel();
				saturationBlock = false;
			}});
	}
}