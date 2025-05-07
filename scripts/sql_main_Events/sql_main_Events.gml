// Auto-generated stubs for each available event.

function sql_main_Moment()
{
    var act_exit = function() {
    game_end();
    }
    
    var act_play = function() {
        room_goto(rms_microinit);
    }
    for (var i = 0; i < instance_number(obu_button); i++) {
        var _seqinst = instance_find(obu_button,i);
        if (instance_exists(_seqinst)) {
            switch i {
                //case 2:
                    //_seqinst.text = loc("topmenu.night1")
                    //_seqinst.action = function() {
                        //room_goto(rms_microinit_night1);
                    //}
                //break;
                case 1: 
                    _seqinst.text = loc("topmenu.night1")
                    _seqinst.action = function() {
                        room_goto(rms_microinit_night1);
                    }
                break;
                case 0: 
                    _seqinst.text = loc("topmenu.exit")
                    _seqinst.action = act_exit;
                break;
            }

            
        }
    }
}