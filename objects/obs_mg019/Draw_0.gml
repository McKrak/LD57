if (instance_exists(obs_microsys)) {
    if (result != MGR_WIN) && (!obs_microsys.pause) {
        draw_sprite_ext(spu_mg019_cutlines,type,room_width/2,room_height/2-32,.3,.3,0,c_white,0.5);
        
        
        gpu_push_state();
        gpu_set_blendmode(bm_normal);
        shader_push();
        
        if (!surface_exists(surf_cut)) {
            surf_cut = surface_create(640,360);
            surface_set_target(surf_cut);
            draw_clear_alpha(c_black,0);
            if (buffer_exists(tmpsrf)) {
                buffer_set_surface(tmpsrf,surf_cut,0);
                buffer_delete(tmpsrf);
                tmpsrf = -1;
            }
            surface_reset_target();
        }
        if (!surface_exists(surf_target)) {
            surf_target = surface_create(buff_w,buff_h);
            surface_set_target(surf_target);
            draw_clear_alpha(c_black,0);
            if (buffer_exists(tmptarget)) {
                buffer_set_surface(tmptarget,surf_target,0);
                buffer_delete(tmptarget);
                tmptarget = -1;
            } else {
                draw_sprite_ext(spu_mg019_cutlines_mask,type,buff_w/2,buff_h/2-16,.15,.15,0,c_white,1);
            }
            surface_reset_target();
        }
        
        
        if (instance_exists(obv_3dcam)) {
            if (mouse_check_button(mb_left)) {
                if (surface_exists(surf_cut)) {
                    surface_set_target(surf_cut);
                    draw_line_width_color(mouse_xprevious,mouse_yprevious,obu_cursor.x,obu_cursor.y,3,c_red,c_red);
                    surface_reset_target();
                }
        
                if (surface_exists(surf_target)) {
                    surface_set_target(surf_target);
                    gpu_push_state();
                    gpu_set_blendenable(false);
                    draw_set_alpha(0);
                    draw_line_width_color(mouse_xprevious/2,mouse_yprevious/2,obu_cursor.x/2,obu_cursor.y/2,12,c_red,c_red);
                    draw_set_alpha(1);
                    gpu_pop_state();
                    surface_reset_target();
                }
            }
        }
        
        mouse_xprevious = obu_cursor.x;
        mouse_yprevious = obu_cursor.y;
        
        draw_circle_color(obu_cursor.x,obu_cursor.y,3,c_red,c_red,false);
        shader_pop();
        gpu_pop_state();
        event_inherited();
        
        
        //if (surface_exists(surf_target)) {
            //gpu_push_state();
            //gpu_set_tex_filter(false);
            //draw_surface_stretched(surf_target,0,0,640,360);
            //gpu_pop_state();
        //}
        
        if (surface_exists(surf_cut)) {
            draw_surface_stretched(surf_cut,0,0,640,360);
        }
    }
    
    
}

