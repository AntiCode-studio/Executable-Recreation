// SETTINGS
public var text:String = "[YOU]";
public var offset:Int = 120;

// BACKEND
public var playerStrums = PlayState.opponentMode ? strumLines.members[0] : strumLines.members[1];

// TEXT
public var label:FunkinText;

function postCreate() {
    label = new FunkinText(getStrumMidpoint(FlxAxes.X), getStrumMidpoint(FlxAxes.Y) + offset, 0, text, 32);
    label.alpha = 0;
    label.font = Paths.font("sonic-classic-open-xl.ttf");
    label.cameras = [camHUD];
    add(label);
}

function onSongStart() {
    var fade:FlxTimer;

    FlxTween.tween(label, {alpha: 1}, 1);

    fade = new FlxTimer().start(5, function(timer:FlxTimer) {
        FlxTween.tween(label, {alpha: 0}, 1, {onComplete: label.destroy});
    });
}

function getStrumMidpoint(axis:FlxAxes) {
    var sumX = 0;
    var sumY = 0;

    switch (axis) {
        case FlxAxes.X:
            for (i in 0...playerStrums.length)
                sumX += playerStrums.members[i].x;
            return (sumX / playerStrums.length);
        case FlxAxes.Y:
            for (i in 0...playerStrums.length)
                sumY += playerStrums.members[i].y;
            return (sumY / playerStrums.length);
        case FlxAxes.XY:
            for (i in 0...playerStrums.length) {
                sumX += playerStrums.members[i].x;
                sumY += playerStrums.members[i].y;
            }
            return ([sumX / playerStrums.length, sumY / playerStrums.length]);
        case FlxAxes.NONE:
            return 0;
    }
}