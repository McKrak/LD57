if (global.config == "Debug") {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(0,0,$"{x}, {y}");
    draw_rectangle(0,0,640,360, true);
}
gpu_push_state();
gpu_set_tex_filter(true);
//part_system_drawit(ps_trail);
draw_self();
gpu_pop_state();
