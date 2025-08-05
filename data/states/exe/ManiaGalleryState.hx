import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;

var transitioning:Bool = true;
var curSelected:Int = 0;
var arts:Array<Array<Dynamic>> = [
    {
        art:'test',
        info:'HERNYA',
    },
    {
        art:'testing',
        info:'pohui',
    }  
];

var camBG:FlxCamera = new FlxCamera();
var camArt:FlxCamera = new FlxCamera();
var camUI:FlxCamera = new FlxCamera();

function create() {

    ticking = FlxG.sound.load(Paths.sound('Metronome_Tick'), 1);

    FlxG.cameras.add(camBG, false);
    camBG.bgColor = new FlxColor(0x00000000);

    FlxG.cameras.add(camArt, false);
    camArt.bgColor = new FlxColor(0x00000000);

    FlxG.cameras.add(camUI, false);
    camUI.bgColor = new FlxColor(0x00000000);


    bgAssets = new FlxGroup();
	add(bgAssets);
    bgAssets.cameras = [camBG];

    artAssets = new FlxGroup();
	add(artAssets);
    artAssets.cameras = [camArt];

    uiAssets = new FlxGroup();
	add(uiAssets);
    uiAssets.cameras = [camUI];

    FlxG.camera = camUI;
    
    FlxG.sound.playMusic(Paths.music('Works of Art'), 1, true);
    Conductor.changeBPM(107);

	if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
		FlxG.sound.music.play();
	}
    transitioning = false;

    blackP = new FlxSprite();
    blackP.makeGraphic(1280, 720, FlxColor.WHITE);
    blackP.updateHitbox();
    blackP.screenCenter();
    blackP.color = 0xff6a6a;
    add(blackP);

    backdrop = new FlxBackdrop(Paths.image('menus/gallery/parts'));
    backdrop.updateHitbox();
    backdrop.velocity.set(0, -60);
    backdrop.alpha = 0.6;
    add(backdrop);

    menuItems = new FlxTypedGroup<FlxSprite>();
	artAssets.add(menuItems);

    for(i in 0...arts.length)
	{
		var item:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/gallery/arts/" + arts[i].art.toLowerCase()));
		item.screenCenter();
		menuItems.add(item);

		item.ID = i;
	}

}
var targetZoom:Float = 1.0;
var camXchange:Float = 350.0;
function beatHit(curBeat:Int) {
    if (curBeat % 2 == 0) {
        backdrop.velocity.y = -500;
        backdrop.scale.x = 0.99;
    }
}
function update(elapsed:Float) {

    camArt.scroll.x = FlxMath.lerp(camArt.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.05, (1/30)*240*elapsed);
	camArt.scroll.y = FlxMath.lerp(camArt.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.05, (1/30)*240*elapsed);
    if(controls.LEFT_P){
        changeItem(-1);
    }
	if(controls.RIGHT_P){
        changeItem(1);
    }
    if(controls.LEFT)
	{
		targetZoom = 1.0;
	}
	if(controls.RIGHT)
	{
		targetZoom = 1.0;
	}

	if (FlxG.keys.justPressed.R) {
		targetZoom = 1.0;
	}
    backdrop.velocity.set(0, FlxMath.lerp(backdrop.velocity.y, -60, 0.04));
    backdrop.scale.x = FlxMath.lerp(backdrop.scale.x, 1, 0.04);
    if (controls.BACK) {
		if (!transitioning){
            FlxG.sound.play(Paths.sound("cancelMenu"), 0.7);
            transitioning = true;
			new FlxTimer().start(1.4, (_) -> [
                FlxG.switchState(new MainMenuState())
            ]);
		};
	}
    camArt.zoom = FlxMath.lerp(camArt.zoom, targetZoom, 0.04);
    camArt.x = FlxMath.lerp(camArt.x, camXchange, 0.04);
    handleMouseWheelZoom();
    menuItems.forEach(function(item:FlxSprite)
	{
		if(item.ID == curSelected)
		{
			item.visible = true;
		}
		else
		{
			item.visible = false;
		}
	});
}
function changeItem(val:Int = 0)
{
	curSelected += val;
	if (curSelected >= arts.length)
		curSelected = 0;
	if (curSelected < 0)
		curSelected = arts.length - 1;
	// there was code using FlxTween but its sucks so im using Lerp instead
}
function handleMouseWheelZoom():Void
{
    // Получаем изменение колесика мыши
    var wheel:Int = FlxG.mouse.wheel;

    if(targetZoom >= 0.9 && targetZoom <= 1.1){
        camXchange = 350;
    }else{
        camXchange = 0;
    }
    
    if (wheel != 0)
    {
        // Изменяем целевой зум
        targetZoom += wheel * 0.1;
        
        // Ограничиваем зум
        targetZoom = FlxMath.bound(targetZoom, 0.25, 5.0);
        
        // Можно добавить эффект при зуме
        ticking.pitch = targetZoom;
        ticking.stop();
        ticking.play();
    }
}