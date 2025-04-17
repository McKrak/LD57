// Auto-generated stubs for each available event.

function sql_calibration_Moment()
{
    for (var i = 0; i < instance_number(obu_text); i++) {
        var _inst = instance_find(obu_text,i);
        if (instance_exists(_inst)) {
            switch (i) {
                case 0: _inst.text = "MOUSE CALIBRATION"; break;
                case 1: 
                    _inst.text = "Please drag the slider across to the outlined circle\nto calibrate mouse controls.";
                    _inst.scale = .5; 
                break;
            }
        }
    }
}