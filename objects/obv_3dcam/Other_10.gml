if (drawmode) {
	if (do_output) {
		if (output != undefined) {
			if surface_exists(output) {
				if (aspect_ratio == AR_DYNAMIC) {
                    var _xstart = NATIVE_W*(max(res_ratio_width/2+.5,1)-1);
                    var _ystart = NATIVE_H*(max(res_ratio_height/2+.5,1)-1);
                    
                    var _x = output_xoffset*max(res_ratio_width,1) - _xstart;
                    var _w = output_xscale*NATIVE_W*max(res_ratio_width,1);
                    var _y = output_yoffset*max(res_ratio_height,1) - _ystart;
                    var _h = output_yscale*NATIVE_H*max(res_ratio_height,1);
                    var _sh = surface_get_height(output);
                    var _sw = surface_get_width(output);
                    draw_surface_stretched(output,_x,_y,_w,_h);
                } else {
                    var _w = output_xscale*NATIVE_W;
                    var _h = output_yscale*NATIVE_H;
                    var _sh = surface_get_height(output);
                    var _sw = surface_get_width(output);
                    draw_surface_stretched(output,output_xoffset,output_yoffset,_w,_h);
                }
				
			
				//var _m = matrix_get(matrix_world); // get current matrix
  
			    //var _new_m = matrix_build(_x,_y,0, 24,0,0, 1, 1, 0);
			    //matrix_set(matrix_world, _new_m);
				
				//matrix_set(matrix_world,_m);
				
                draw_set_font(fnt_debu);
                                draw_set_halign(fa_left);
                                draw_set_valign(fa_top);
                                draw_text_color(32,32,$"x:{x}\ny:{y}\nz:{z}\nxto:{xto}\nyto:{yto}\nzto:{zto}\ncurx:{cursor_x}\ncury:{cursor_y}",c_aqua,c_aqua,c_aqua,c_aqua,1);
			}
		}
	}
}