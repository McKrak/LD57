if (state == st_init) {
    draw_text(200,200,"LOADING");
}
if (state == st_microresult) {
    var _result = "";
    if micro_result == MGR_WIN _result = "YOU WIN!!";
        else if micro_result == MGR_LOSE _result = "YOU LOSE!!";
    scribble($"[fa_middle][fa_center]{_result}").draw(320,180);
}
if (pause) {
    draw_text(200,200,"PAUSE");
}