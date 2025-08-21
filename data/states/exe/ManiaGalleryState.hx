import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween.FlxTweenType;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;

var transitioning:Bool = true;
var curSelected:Int = 0;
var arts:Array<Array<Dynamic>> = [
    {
        art:'logo',
        name:'Old Logo',
        info:'this is one of the older versions\nof the mod logo',
    },
    {
        art:'test',
        name:'Mod Icon',
        info:'mod icon, nothing more',
    },
    {
        art:'umny',
        name:'Smart man',
        info:'Smart man with glasses\ndownload wallpaper',
    },
    {
        art:'devart',
        name:'One of the arts',
        info:'This was drawn\nby one of the development participants',
    }
];

var camBG:FlxCamera = new FlxCamera();
var camArt:FlxCamera = new FlxCamera();
var camUI:FlxCamera = new FlxCamera();

function create() {

    ticking = FlxG.sound.load(Paths.sound('Metronome_Tick'), 0.5);

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
    blackP.color = 0xDE5570;
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

    menuBg = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/gallery/menuAsset"));
	menuBg.screenCenter();
	uiAssets.add(menuBg);
    //menuBg.x -= 300;

    nameArt = new FunkinText(0, 0, 0, '', 70);
    nameArt.setFormat(Paths.font("sonic-classic-open-xl.ttf"), 70, FlxColor.WHITE, 'center');
    nameArt.color = 0x13054c;
	uiAssets.add(nameArt);
    nameArt.alignment = 'center';
    nameArt.scale.x = 0.8;
    nameArt.scale.y = 0.8;
    
    infArt = new FunkinText(0, 0, 0, '', 70);
    infArt.setFormat(Paths.font("sonic-classic-open-xl.ttf"), 70, FlxColor.WHITE, 'center');
    infArt.color = 0x13054c;
	uiAssets.add(infArt);
    infArt.alignment = 'center';
    infArt.scale.x = 0.4;
    infArt.scale.y = 0.4;

    navigation = new FunkinText(0, 0, 0, 'Left/Right - Change Image\nMouse wheel - Zoom\nR - Resset zoom', 70);
    navigation.setFormat(Paths.font("sonic-classic-open-xl.ttf"), 50, FlxColor.WHITE, 'left');
    navigation.color = 0x13054c;
	uiAssets.add(navigation);
    navigation.scale.x = 0.4;
    navigation.scale.y = 0.4;
    navigation.updateHitbox();
    navigation.screenCenter();
    navigation.x -= 210;
    navigation.y += 330;

    importScript("data/scripts/visualizer");
}
var targetZoom:Float = 1.0;
var camArtXchange:Float = 350.0;

var camUIXchange:Float = -300;
function beatHit(curBeat:Int) {
    if (curBeat % 2 == 0) {
        backdrop.velocity.y = -500;
        backdrop.scale.x = 0.99;
    }
}
var localTime:Float = 0;
function update(elapsed:Float) {
    nameArt.text = arts[curSelected].name;
	nameArt.screenCenter();
    nameArt.y -= 250;

    infArt.text = arts[curSelected].info;
	infArt.screenCenter();
    infArt.y -= 200;

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
			new FlxTimer().start(0.5, (_) -> [
                FlxG.switchState(new MainMenuState())
            ]);
		};
	}
    camArt.zoom = FlxMath.lerp(camArt.zoom, targetZoom, 0.04);
    camArt.x = FlxMath.lerp(camArt.x, camArtXchange, 0.04);

    camUI.x = FlxMath.lerp(camUI.x, camUIXchange, 0.04);
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
    FlxG.sound.play(Paths.sound("scrollMenu"), 0.7);
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
        camArtXchange = 350;
        camUIXchange = -300;
    }else{
        camArtXchange = 0;
        camUIXchange = -1270;
    }
    
    if (wheel != 0)
    {
        // Изменяем целевой зум
        targetZoom += wheel * 0.1;
        
        // Ограничиваем зум
        targetZoom = FlxMath.bound(targetZoom, 0.2, 5);
        
        // Можно добавить эффект при зуме
        ticking.pitch = targetZoom;
        ticking.stop();
        ticking.play();
    }
}