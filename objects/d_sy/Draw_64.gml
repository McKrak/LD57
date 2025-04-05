ImGui.__Draw();
draw_circle(surf_mx*NATIVE_W/global.res_width,surf_my*NATIVE_H/global.res_height,25,true);
//draw_rectangle(surf_x,surf_y,surf_x + surf_w, surf_y + surf_h, true);
if (global.config == "Debug") {
    draw_set_font(fnt_debu);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    var _cname = "None";
    if (is_struct(context)) {
        _cname = context[$ "path"];
    }

    draw_text(0,0,$"mem:{global.cur_mem}\ncontext:{_cname}\nmousex:{window_mouse_get_x()}\nmousey:{window_mouse_get_y()}\nsurfx:{surf_x}\nsurfy:{surf_y}\nsurfmx:{surf_mx}\nsurfmy:{surf_my}\nsurfw:{surf_w}\nsurfh:{surf_h}");
}
