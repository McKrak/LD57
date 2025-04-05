function lang_set(_locale) {
    try {
        var _file = file_read_all_text($"{ROOT_DIR}/LanguageData/{_locale}.loc");
        global.lang = json_parse(_file);
        _file = "";
        gc_collect();
    } catch (_err) {
        print(_err);
    }
}

function loc(_ind) {
    return string(get_token(global.lang, _ind));
}