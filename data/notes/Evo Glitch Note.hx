glitchNoteShader = new CustomShader('invertGlitch');
glitchNoteShader.AMT = 0.2;
glitchNoteShader.SPEED = 32;
glitchNoteShader.isActive = true;

function stepHit(curStep:Int) {
    if (glitchNoteShader.isActive) { //prevent null todo
        glitchNoteShader.iTime = FlxG.random.float(0,3);
    }
}

function onNoteHit(event){
    if (event.noteType == "Evo Glitch Note"){
        event.character.shader = glitchNoteShader;
    }else{
        event.character.shader = null;
    }
}
function onNoteCreation(e) {
		switch (e.noteType) {
			case "Evo Glitch Note":
				/*
				If you're playing as the opponent (PlayState.opponentMode)
				and any strumlines AFTER dad (e.strumLineID >= 1)
				Hurt Note will be hittable for THOSE strumline characters
				doesn't matter if it's bf or other additionals strumlines, as long as it's after dads' strumline it's hittable
				*/
				//if (PlayState.opponentMode && e.strumLineID >= 1) e.note.wasGoodHit = true;

				/*
				If you're playing solo (!PlayState.opponentMode)
				and any strumlines BEFORE the current character you're playing (e.strumLineID <= 0)
				Hurt Note will be hittable for THOSE strumline characters
				doesn't matter if it's bf or other additionals, as long as it's BEFORE dad's strumline
				*/
				//if (!PlayState.opponentMode && e.strumLineID <= 0) e.note.wasGoodHit = true;
				e.note.shader = glitchNoteShader;
		}
}