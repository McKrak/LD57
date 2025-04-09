// Auto-generated stubs for each available event.

function sql_microstage_result_Moment()
{
    print("INIT RESULT");
        for (var i = 0; i < instance_number(obu_button); i++) {
        var _seqinst = instance_find(obu_button,i);
        if (instance_exists(_seqinst)) {
            switch i {
                case 1:
                    _seqinst.text = loc("results.retry")
                    _seqinst.action = function() {
                        obs_microsys.state = obs_microsys.st_init;
                    }
                break;
                case 0: 
                    _seqinst.text = loc("results.exit")
                    _seqinst.action = function() {
                        with (obs_microsys) { 
                            instance_destroy();
                            room_goto(rmz_microstage);
                            room_persistent = false;
                            room_goto(rmm_main);
                        }
                    };
                break;
            }

            
        }
    }
}