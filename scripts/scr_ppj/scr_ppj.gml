#macro NODE_PJ_BOARD	".ppb"
#macro NODE_PJ_SPACE	".pspc"
#macro NODE_PJ_CAM		".pcam"
#macro NODE_PJ_OBJECT	".pobj"

function load_pjb(_decompress = true) {
	
	try {
		var _file = get_open_filename("Party Project Board|*.ppb", "");
		
		if (file_exists(_file)) {
            print(_file);
            var _ppb = rpk_load_json(global.mem[1], _file);
            _ppb.doc_savepath = _file;
            
			print ("Loaded board successfully!");
			return _ppb;
		} else return undefined;
	} catch (_err) {
		print(_err);
		return undefined;
	}
}

//function ppb_rename_node(_node, _newname) {
    //try {
        //if (_newname != "%ROOT%") {
            ////if (!string_ends_with(_newname,_node.type)) _newname += _node.type;
            //var _discrim = 0;
            //var _content = rpk_get_node(_node.path, 1);
            //if (_content != undefined) {
                //if (is_struct(_content)) {
                    //_content = _content.content;
                //}
                //for (var i = 0; i < array_length(_content); i++) { 
                    //if (_content[i].name == _newname) {
                        ////var _split = string_split(_newname, ".");
                        ////array_delete(_split,array_length(_split) - 1,1);
                        ////if (array_last(_split) =)
                        //var _newnamenoext = string_split(_newname, ".")[0];
                        //_newname = _newnamenoext + "." + string(_discrim++) + _node.type;
                        //i = 0;
                    //}
                //}
            //} else {
                //print("Idk what now");
            //}
        //}
        //
        //var _patharray = string_split(_node.path, "/", false); 
        //var _scope = rpk_get_node(_patharray[0]);
        //var _newpath = "";
        //if (_scope == undefined) {
            //_scope = _node;
            //_newpath = _newname; 
        //} else {
            //_patharray[array_length(_patharray) - 1] = _newname;
            //for (var i = 0; i < array_length(_patharray); i++) {
                //if (i != 0) _newpath += "/";
                //_newpath += _patharray[i];
            //}
        //}
        //__rpk_rename_node_inner(_scope, _node.path, _newpath);
        //
        //_node.path = _newpath;
        //_node.name = _newname;
        //
    //} catch (_err) {
        //print(_err);
    //}
//}
//
function __ppb_write_placement(_inst) {
	return [
					_inst.x,
					_inst.y,
					0,
					_inst.xscale,
					_inst.yscale,
					1,
					0,
					_inst.angle,
					_inst.xorig,
					_inst.yorig,
					0,
					0,
					[]
	]
}



function __ppb_convert_name_to_id(_name) {
    try {
        if (is_string(_name)) {
            var _namenoext = string_split(_name,".")[0];
            var _int = int64(_namenoext);
            return _int;
        } else return 0;
    } catch (_err) {
        print(_err);
        return 0;
    }
}

function save_ppb(_board, _prompt = false) {
    var _file = "";
    if (!_prompt) && (file_exists(_board.doc_savepath)) {
        _file = _board.doc_savepath;
    } else {
        _file = get_save_filename("Party Project Board|*.ppb", $"{_board.name}");
    }
    
    if (_file != undefined) && (_file != "") && (is_string(_file)) && (string_length(_file) > 0) {
        var _name = _board.name;
        rpk_rename_node(_board, "%ROOT%", false);
        var _out = ElephantToJSON(_board);
        var _fname = filename_remove_extension(_file);
        rpk_rename_node(_board, _fname);

        
        //buffer_save(_out, _file);
        //buffer_delete(_out);
        
        var _outJSON = json_stringify(_out);
        file_write_all_text(_file,_outJSON);
        _outJSON = "";
        _out = {};

        show_message("Board exported successfully!");
        _board.doc_savepath = _file;
        //_board.doc_issaved = true;
        return true;
	} else return false;
}