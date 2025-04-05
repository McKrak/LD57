function imgui_set_style(_themefile) {
    try {
    if (file_exists(_themefile)) {
        var _text = file_read_all_text(_themefile);
        var _lines = string_split(_text,";",true);
        for (var i = 1; i < array_length(_lines); i++) {
            var _line = _lines[i];
                var _cmd = string_split_ext(_line,["[","]"]);
                if (array_length(_cmd) = 3) {
                    var _propertySeg = _cmd[1];
                    var _valueSeg = _cmd[2];
                    
                    var _property = string_split(_propertySeg,"_")[1];
                    print(_property);
                    var _valuearray = string_split_ext(_valueSeg,["(",")"])[1];
                    var _valuearrayraw = string_replace_all(_valuearray,"f","");
                    var _values = string_split(_valuearrayraw,",");
                    print(_values)
                    
                    
                    imgui_set_style_color(i-1,make_color_rgb(real(_values[0])*255,real(_values[1])*255,real(_values[2])*255),real(_values[3]));
                    
                    
            }
        }
    }
    } catch (_err) {
        print("An error occured while trying to load the theme configuration.");
        print(_err);
    }
}