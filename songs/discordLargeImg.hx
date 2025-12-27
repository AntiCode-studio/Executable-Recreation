import funkin.backend.utils.DiscordUtil;
//import funkin.game.PlayState;
import StringTools;

var songInfo = PlayState.SONG.meta.displayName + PlayState.difficulty;
function onSongStart() {

    //trace("Discord RPC: ", PlayState.SONG.meta.displayName, PlayState.difficulty);
    songInfo = songInfo.toLowerCase();
    songInfo = StringTools.replace(songInfo, " ", "");

    DiscordUtil.config.logoKey = songInfo;

    trace(DiscordUtil.config.logoKey);
}
function destroy() {
    DiscordUtil.config.logoKey = "maniamenus";
}