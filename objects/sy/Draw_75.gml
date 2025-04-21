
draw_set_font(fnt_debu);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
if (global.config == "Debug") {
    draw_text_transformed_color(640,360,$"FPS:{fps}\nFPS_REAL:{fps_real}\nSPEED FACTOR:{dt}\nMIN SCALE:{global.min_scale}\nRES:({global.res_width}, {global.res_height})\nRES RATIO:({global.res_ratio_width}, {global.res_ratio_height})\nDPI: {global.dpi_scale}\nINST_COUNT: {instance_count}\nMEM: {global.mem_used}",1,1,0, c_lime,c_lime,c_aqua,c_aqua,1);
    
}

