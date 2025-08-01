import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;

var isRun = false;
var vignetteFade = 0;
aura = new CustomShader('Aura');
snowfall = new CustomShader('GlitchShaderA');

wave = new CustomShader('wave');
var isRun = false;
function paceRun(trueOrFalse:Bool) {
    trace(trueOrFalse);
    if(trueOrFalse =="false"){
        fgtree.visible = false;
        paceSky.visible = false;
        pacefloor.visible = false;
        sun.visible = false;
        sun2.visible = false;
        isRun = false;
    }else{
        //strumLines.members[0].characters[1].visible = true;
        //strumLines.members[0].characters[0].visible = false;
        fgtree.visible = true;
        paceSky.visible = true;
        pacefloor.visible = true;
        sun.visible = true;
        sun2.visible = true;
        isRun = true;

        strumLines.members[0].characters[0].scale.set(0.6, 0.6);
    }
    
}

function postCreate() {
    camGame.addShader(aura);
    snowfall.glitchAmount = 0.0001;
    camGame.addShader(snowfall);
    camHUD.addShader(snowfall);

    bg1.shader = wave;

    fgtree = new FlxBackdrop(Paths.image('stages/pace/v1/prun/fgtree'), 1, 0);
    fgtree.scale.set(1.3, 3);
    fgtree.velocity.set(-1050 - 100, 0);
    add(fgtree);
    fgtree.y = 300;

    paceSky = new FlxBackdrop(Paths.image('stages/pace/v1/prun/pacesky'), 1, 0);
    paceSky.scale.set(2, 2);
    paceSky.velocity.set(-650 - 100, 0);
    insert(members.indexOf(gf), paceSky);
    paceSky.y = 200;

    sun = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	insert(members.indexOf(gf),sun);
    sun2 = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/prun/sun'));
	insert(members.indexOf(gf),sun2);

    pacefloor = new FlxBackdrop(Paths.image('stages/pace/v1/prun/floor'), 1, 0);
    pacefloor.scale.set(1.5, 1.5);
    pacefloor.velocity.set(-850 - 100, 0);
    insert(members.indexOf(gf), pacefloor);
    pacefloor.y = 1000;

    fgtree.visible = false;
    paceSky.visible = false;
    pacefloor.visible = false;
    sun.visible = false;
    sun2.visible = false;
    importScript("data/huds/maniav2");
}
function create() {
    vignette = new FlxSprite(500,250).loadGraphic(Paths.image('stages/pace/v1/vignette'));
    vignette.camera = camHUD;
    vignette.screenCenter();
	insert(members.indexOf(strumLines),vignette);
}
var localTime:Float = 0;
function update(elapsed:Float) {
    localTime += elapsed;
    aura.iTime = localTime;
    snowfall.iTime = localTime;
    wave.iTime = localTime;
    var shadowScale = 0.6 + PlayState.instance.defaultCamZoom - camGame.zoom;
    vignette.alpha = FlxMath.lerp(vignette.alpha, vignetteFade, 0.15);
    if (!isRun){
        strumLines.members[0].characters[0].scale.set(shadowScale, shadowScale);
        if(strumLines.members[curCameraTarget].characters[curCameraTarget] == strumLines.members[0].characters[0]){
            camGame.zoom = FlxMath.lerp(camGame.zoom, 1.2, 0.05);
            vignetteFade = 1;
        }else {
            vignetteFade = 0;
        }
    }
}
var glitchTween:FlxTween;
function shaderAnim() {
    snowfall.glitchAmount = 1;
    if(glitchTween != null) {
		glitchTween.cancel();
	}
    glitchTween = FlxTween.tween(snowfall, {glitchAmount: 0.0001}, 0.5);
}