import funkin.menus.BetaWarningState;
import funkin.menus.TitleState;
import funkin.menus.MainMenuState;
import funkin.menus.StoryMenuState;
import funkin.menus.FreeplayState;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;

import funkin.backend.utils.WindowUtils;
import lime.graphics.Image;
import openfl.text.TextFormat;
import funkin.backend.system.framerate.FramerateCounter;
import funkin.backend.MusicBeatTransition;

//static var windowTitleFake:String = "Black Sock";
static var windowTitle:String = "Executable Mania Recreation";

static var curMainMenuSelected:Int = 0;
static var curStoryMenuSelected:Int = 0;
static var isInPlayState:Bool = false;
static var curOptionMenuSelected:Int = 0;
static var optionsSelectedSomethin:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    //BetaWarningState => "rom/warn",
    TitleState => "exe/ManiaTitleState",
    //MainMenuState => "rom/TitleState",
    //StoryMenuState => "rom/TitleState",
    //FreeplayState => "rom/TitleState",
    //OptionsMenu => "",
    //CreditsMain => ""
];

function postGameStart() {
    FlxG.save.data.titleAnim = true;
}

static var ModOptions = FlxG.save.data;

function new() {
	ModOptions.tbEnable ??= false;
	ModOptions.tbSongName ??= false;
	ModOptions.tbTimeType ??= 'elapsed';
	ModOptions.tbShowEndTime ??= true;
	ModOptions.tbTimeMS ??= false;
}

function preStateSwitch()
{

    Main.framerateSprite.codenameBuildField.y =  Main.framerateSprite.memoryCounter.y;
    Main.framerateSprite.memoryCounter.visible = false;

    FlxG.camera.bgColor = 0x00000000;
    FlxG.mouse.visible = true;

    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));

    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('gameIcon'))));
	window.title = windowTitle;
}

import funkin.backend.scripting.MultiThreadedScript;
import funkin.backend.scripting.GlobalScript;

function readSubFolder(folder) {
	var globalScripts = Paths.getFolderContent(folder).filter((i:String) -> return StringTools.endsWith(i, '.hx'));
	for (script in globalScripts) {
		var daScript = new MultiThreadedScript(Paths.script(folder + '/' + script));
		daScript.call('create');
		GlobalScript.scripts.add(daScript.script);
		daScript.call('postCreate');
	}
	for (daFolder in Paths.getFolderDirectories(folder+"/", true)) {
		readSubFolder(daFolder);
	}
}

function new() {
	var globalScripts = Paths.getFolderContent('data/scripts/global').filter((i:String) -> return StringTools.endsWith(i, '.hx'));
	for (script in globalScripts) {
		var daScript = new MultiThreadedScript(Paths.script('data/scripts/global/' + script));
		daScript.call('create');
		GlobalScript.scripts.add(daScript.script);
		daScript.call('postCreate');
	}
	for (folder in Paths.getFolderDirectories('data/scripts/global/', true)) {
		readSubFolder(folder);
	}
}
