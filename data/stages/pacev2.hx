var isRun = false;
var vignetteFade = 0;
aura = new CustomShader('Aura');
snowfall = new CustomShader('GlitchShaderA');
function postCreate() {
    camGame.addShader(aura);
    snowfall.glitchAmount = 0.0001;
    camGame.addShader(snowfall);
    camHUD.addShader(snowfall);
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