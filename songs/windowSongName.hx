import funkin.game.PlayState;
import funkin.editors.charter.Charter;
import funkin.backend.utils.WindowUtils;
function postCreate() {
    window.title = "Executable Mania Recreation - " + PlayState.SONG.meta.displayName;
    if (PlayState.chartingMode) {
        window.title = "* Executable Mania Recreation - " + PlayState.SONG.meta.displayName + " (Chart Playtesting)";
    }
}