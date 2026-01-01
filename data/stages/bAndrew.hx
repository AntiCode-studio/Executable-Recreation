var lastFocused:Int = null;
var zoomin:FlxTween = null;
public var zoomAllow:Bool = true;

introLength = 0;

function onNoteHit(event)
	event.enableCamZooming = true;

function onCameraMove(_) if(zoomin == null && lastFocused != (lastFocused = curCameraTarget) && zoomAllow)
zoomin = FlxTween.tween(FlxG.camera, {zoom: curCameraTarget == 0 ? 0.5 : 0.375}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.cubeOut, onComplete: function(_){
	zoomin = null;
	defaultCamZoom = FlxG.camera.zoom;
}});