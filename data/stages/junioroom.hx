zoomAllow = false;
importScript("data/huds/maniav1");

function postCreate() {
    tv2.visible = false;
    table2.visible = false;
    roomback2.visible = false;
    overlay2.visible = false;
    tv3.visible = false;
    table3.visible = false;
    roomback3.visible = false;
    overlay3.visible = false;
}

function onEvent(event) {
	switch (event.event.name) {
		case 'Change Character':
            if(event.event.params[0] == 0){
                if(event.event.params[1] == 'Bluescreen_Glitched'){
                    tv.visible = false;
                    table.visible = false;
                    roomback.visible = false;
                    overlay.visible = false;
                    tv2.visible = false;
                    table2.visible = false;
                    roomback2.visible = false;
                    overlay2.visible = false;
                    tv3.visible = true;
                    table3.visible = true;
                    roomback3.visible = true;
                    overlay3.visible = true;
                }
                if(event.event.params[1] == 'Bluescreen_Alt'){
                    tv.visible = false;
                    table.visible = false;
                    roomback.visible = false;
                    overlay.visible = false;
                    tv2.visible = true;
                    table2.visible = true;
                    roomback2.visible = true;
                    overlay2.visible = true;
                    tv3.visible = false;
                    table3.visible = false;
                    roomback3.visible = false;
                    overlay3.visible = false;
                }
            }
	}
}