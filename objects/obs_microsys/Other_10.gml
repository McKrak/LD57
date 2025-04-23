scribble($"[fa_middle][fa_center]TESTDRAW")
            .blend(image_blend,image_alpha)
            .sdf_outline(c_black,1*global.min_scale)
            .gradient(c_blue,.25)
            .draw(320,180);

if (state == st_init) {
    scribble($"[fa_middle][fa_center]LOADING").draw(320,180);
}
if (state == st_microresult) {
    var _result = "";
    if micro_result == MGR_WIN _result = "YOU WIN!!";
        else if micro_result == MGR_LOSE _result = "YOU LOSE!!";
    scribble($"[fa_middle][fa_center]{_result}").draw(320,180);
}
if (state == st_gameover_lose) {
    scribble($"[fa_middle][fa_center]GAME OVER").draw(320,180);
}