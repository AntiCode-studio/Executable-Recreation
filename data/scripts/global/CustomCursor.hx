static public var cursor = {
    animations: {
        pressed: {
            sprite: "menus/main/mouse", // Leave blank if you don't want a pressed image.
            scale: 0.35
        },
        idle: {
            sprite: "menus/main/mouse", // Leave blank if you don't want a static/idle image. (Why'd you install the script then)
            scale: 0.4
        },
        hover: {
            sprite: "menus/main/mouse", // Leave blank if you don't want a hover image.
            scale: 0.4
        }
    },
    hoverableSprites: [], // use `cursor.hoverableSprites.push(object);` to allow the hover anim to trigger when hovering.
    curAnim: "",
    curImage: "",
    playAnim: function (name:String, ?force:Bool = false):Void {
        force ??= false;
        if (cursor.curAnim != name || force) {
            cursor.curAnim = name;
            switch (name) {
                case "pressed":
                    if (cursor.animations.pressed.sprite != "") {
                        FlxG.mouse.useSystemCursor = false;
                        cursor.curImage = cursor.animations.pressed.sprite;
                        FlxG.mouse.load(Paths.image(cursor.animations.pressed.sprite), cursor.animations.pressed.scale);
                    }
                case "static":
                    if (cursor.animations.idle.sprite != "") {
                        FlxG.mouse.useSystemCursor = false;
                        cursor.curImage = cursor.animations.idle.sprite;
                        FlxG.mouse.load(Paths.image(cursor.animations.idle.sprite), cursor.animations.idle.scale);
                    }
                case "hover":
                    if (cursor.animations.hover.sprite != "") {
                        FlxG.mouse.useSystemCursor = false;
                        cursor.curImage = cursor.animations.hover.sprite;
                        FlxG.mouse.load(Paths.image(cursor.animations.hover.sprite), cursor.animations.hover.scale);
                    }
                default:
                    cursor.curImage = "";
                    FlxG.mouse.useSystemCursor = true;
                    trace("No such cursor animation exists.");
            }
        }
    },
    destroy: function () {
        if (!FlxG.mouse.useSystemCursor) {
            FlxG.mouse.useSystemCursor = true;
            FlxG.mouse.unload();
        }
    }
}

function new() {
    cursor.playAnim("static");
}

function update() {
    if (FlxG.mouse.justPressed) {
        cursor.playAnim("pressed");
    } else if (FlxG.mouse.justReleased) {
        cursor.playAnim("static");
    }
    for (sprite in cursor.hoverableSprites) {
        if (FlxG.mouse.overlaps(sprite)) {
            cursor.playAnim("hover");
        }
    }
}

function preStateSwitch() {
    cursor.hoverableSprites = [];
}

function destroy() {
    cursor.hoverableSprites = [];
    cursor.destroy();
}
