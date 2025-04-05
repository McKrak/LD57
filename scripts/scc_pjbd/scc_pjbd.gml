#macro MAX_BOARD_DIMEN 8192
#macro MIN_BOARD_DIMEN 256

#macro PJBD_GIMMICK_CLASSIC "STG_TYPECLASSIC"
#macro PJBD_GIMMICK_DAYNIGHT "STG_DAYNIGHT"
#macro PJBD_GIMMICK_SPECIAL "STG_TYPESPEC"
#macro PJBD_GIMMICK_NOSTAREVENTS "STG_NOSTAREVENTS"

function pjboard(_path = "") : node() constructor {	
    author = "me";
	type = NODE_PJ_BOARD;
    path = _path;
    
    content = [];
    undo_memory = [];
	
	sprites = {
        bg: -1,
        bg_night: -1,
        thumb: -1,
        preview: -1
    }
    
    rt_sprites = {
        bg: -1,
        bg_night: -1,
        thumb: -1,
        preview: -1
    }
    
    audio = {
    
    }
    
    gimmicks = [];
    
    width = 2196;
    height = 1280;
	cam_zoom = 0.25;
    cam_zoom_autoset = true;
    
    //starprice = 20;
    //
    title = "";
    desc = "";
	bgm_day = "";
	bgm_night = "";
	bgm_pinch = "";
	
	ELEPHANT_SCHEMA {
		v1: {
			name: buffer_string,
            title: buffer_string,
			author: buffer_string,
			content: buffer_array,
			sprites: buffer_struct,
			bgm_day: buffer_string,
			bgm_night: buffer_string,
			bgm_pinch: buffer_string,
            audio: buffer_struct,
            width: buffer_u16,
            height: buffer_u16,
            gimmicks: buffer_struct,
            desc: buffer_string
		},
        v2: {
            name: buffer_string,
            title: buffer_string,
            author: buffer_string,
            content: buffer_array,
            sprites: buffer_struct,
            bgm_day: buffer_string,
            bgm_night: buffer_string,
            bgm_pinch: buffer_string,
            audio: buffer_struct,
            width: buffer_u16,
            height: buffer_u16,
            gimmicks: buffer_struct,
            desc: buffer_string,
            cam_zoom: buffer_f16,
            cam_zoom_autoset: buffer_bool
        },
        v3: {
                name: buffer_string,
                title: buffer_string,
                author: buffer_string,
                content: buffer_array,
                sprites: buffer_struct,
                bgm_day: buffer_string,
                bgm_night: buffer_string,
                bgm_pinch: buffer_string,
                audio: buffer_struct,
                width: buffer_u16,
                height: buffer_u16,
                gimmicks: buffer_array,
                desc: buffer_string,
                cam_zoom: buffer_f16,
                cam_zoom_autoset: buffer_bool
            }
	}
	
    ELEPHANT_POST_READ_METHOD {
        if (ELEPHANT_SCHEMA_VERSION < 2) {
            cam_zoom = 640/max(width, height);
        } else if cam_zoom_autoset cam_zoom = 640/max(width, height);
            
        if (ELEPHANT_SCHEMA_VERSION < 3) {
            gimmicks = [];
            struct_set(sprites, "bg_night", -1);
        }

        rpk_link_hosts(self);
        rpk_set_paths(self);
        if (global.cur_mem == 1) {
            print("RENDERING SPRITES");
            if (is_string(sprites[$ "bg"][$ "buff"])) {
                try {
                    rt_sprites[$ "bg"] = sprite_add_from_base64(sprites[$ "bg"][$ "buff"]);
                } catch (_) {
                    print(_);
                }
            }
            
            if (is_string(sprites[$ "bg_night"][$ "buff"])) {
                try {
                    rt_sprites[$ "bg_night"] = sprite_add_from_base64(sprites[$ "bg_night"][$ "buff"]);
                } catch (_) {
                    print(_);
                }
            }
        
            if (is_string(sprites[$ "thumb"][$ "buff"])) {
                try {
                    rt_sprites[$ "thumb"] = sprite_add_from_base64(sprites[$ "thumb"][$ "buff"]);
                } catch (_) {
                    print(_);
                }
            }
        
            if (is_string(sprites[$ "preview"][$ "buff"])) {
                try {
                    rt_sprites[$ "preview"] = sprite_add_from_base64(sprites[$ "preview"][$ "buff"]);
                } catch (_) {
                    print(_);
                }
            }
        }
        
    }

	
	static toggle = function(_sel = undefined) {
		if _sel == undefined sel = !sel else sel = _sel;
		if (instance_exists(d_sy)) {
			if (sel) {
				if (!array_contains(d_sy.selected,self)) {
					array_push(d_sy.selected,self);
					set_context(true);
				}
			} else {
				if (array_contains(d_sy.selected,self)) {
					for (var i = 0; i < array_length(d_sy.selected); i++) {
						if (d_sy.selected[i] == self) {
							array_delete(d_sy.selected,i,1);
						}
					}
				}
			}
		}
	}
	
	static remove = function(_confirm = false) {
        if (instance_exists(d_sy)) {
            if (is_array(rpk_get_node(path,1))) && (!doc_issaved) && (!_confirm) {
                d_sy.modal_save = true;
                d_sy.modal_save_savefile = self;
                return false;
            }
        }
        
		toggle(false);
        set_context(false);
		
        if (sprite_exists(rt_sprites.bg)) {
            sprite_delete(rt_sprites.bg);
        }
		refresh_background(-1);
        if (sprite_exists(rt_sprites.preview)) {
            sprite_delete(rt_sprites.preview);
        }
        if (sprite_exists(rt_sprites.thumb)) {
            sprite_delete(rt_sprites.thumb);
        }
		
        for (var i = array_length(content) - 1; i >= 0; i--) {
            content[i].remove();
        }
		//while (array_length(content)) {
			//content[0].remove();
		//}
        var _host = rpk_get_node(path, 1);
        search_and_remove(_host,self);
            
        return true;
		//if (host != noone) {
			//rpk_remove_node(host.content,self);
		//}
	}
	
    static save_json = function() {
        try {
            var _file = get_save_filename("JSON File|*.json", $"{filename_remove_extension(name)}.json"); 
            if _file != "" {
                //var _buff = buffer_create(0,buffer_grow,1);
                var _json = json_stringify(ElephantToJSON(self));
                file_write_all_text(_file,_json);
                //buffer_write(_buff,buffer_string,_json);
                //buffer_save(_buff,_file);
                show_debug_message("Saved file successfully!");
                //buffer_delete(_buff);
                return true;
            } else {
                return false;
            }
        } catch (_err) {
            print(_err);
            return false;
        }
    }
    
	static populate_nodetree = function(_index = 0) {
		if (instance_exists(d_sy)) {
			var _treenode_flags_sel = 
			ImGuiTreeNodeFlags.OpenOnArrow|
			ImGuiTreeNodeFlags.SpanAvailWidth|
			ImGuiTreeNodeFlags.FramePadding;
			if (sel) _treenode_flags_sel |= ImGuiTreeNodeFlags.Selected;
			
            //var _unsaved_str = "";
            //var _unsaved = (is_array(rpk_get_node(path,1))) && (!doc_issaved);
            //if _unsaved _unsaved_str = " *"
            
			var _node = imgui_tree_node_ex($"###nodelist_{path}",_treenode_flags_sel);
            if (imgui_is_item_clicked(ImGuiMouseButton.Left) && !imgui_is_item_toggled_open()) {
                d_sy.__selection_handler(self);
            }
				
			if (imgui_begin_popup_context_item($"nodelist_{path}_context")) {
                imgui_separator();
				if (imgui_menu_item($"Save###nodelist_{path}_context_saveppb", "Ctrl+S")) {
					save_ppb(self);
				}
                if (imgui_menu_item($"Save as...###nodelist_{path}_context_saveppbas", "Ctrl+Shift+S")) {
                    save_ppb(self, true);
                }
				imgui_separator();
				if (imgui_menu_item($"Close###nodelist_rpk_{path}_context_delete", "Ctrl+W")) {
					remove();
				}
				imgui_end_popup();
			}
				
			imgui_sameline(); imgui_image(d_spu_node,9,,,28,28);
            imgui_sameline(); imgui_text(name);
					
			if (_node) {

				//populate_rpk_nodetree(content);
				for (var i = 0; i < array_length(content); i++) {
					content[i].populate_nodetree(++_index);
					if (imgui_begin_drag_drop_target()) {
						var _payload = imgui_accept_drag_drop_payload("SPACENODE",ImGuiDragDropFlags.None);
						if (_payload != undefined) {
							if (_payload.host == self) {
								for (var j = 0; j < array_length(content); j++) {
									if (content[j] == _payload) {
										array_delete(content,j,1);
										array_insert(content,i,_payload);
									}
								}
								
							}
						}
						imgui_end_drag_drop_target();
					}
				}
				imgui_tree_pop();
			}
		}
	}
    
    static populate_nodeprop = function() {
        imgui_text("Board Select Thumbnail"); 
        
        
        nodeprop_image_button("thumb",128*global.dpi_scale,64*global.dpi_scale, "Please ensure the image is 128x64 pixels.");
        //{
            //var _sprite = rt_sprites[$ "thumb"];
            //if (sprite_exists(_sprite)) {
                //var _availx = imgui_get_content_region_avail_x();
                //var _sw = sprite_get_width(_sprite);
                //var _sh = sprite_get_height(_sprite);
                //imgui_image(_sprite,0,,,_availx,(_availx/_sw)*_sh);
            //}
        //}
        
        imgui_separator_text("Board Info");
        imgui_text_disabled("Title");
        title = imgui_input_text("###nodeprop_board_title",title);
        imgui_text_disabled("Description");
        desc = imgui_input_textmultiline("###nodeprop_board_desc",desc);
        imgui_text_disabled("Author");
        author = imgui_input_text("###nodeprop_board_author",author);
        imgui_text_disabled("Width");
        prop_add("width",function() {
            return imgui_drag_int($"###nodeprop_board_{path}_width",width,,MIN_BOARD_DIMEN,MAX_BOARD_DIMEN,,ImGuiSliderFlags.AlwaysClamp);
        }, true, false); 
        imgui_text_disabled("Height");
        prop_add("height",function() {
            return imgui_drag_int($"###nodeprop_board_{path}_height",height,,MIN_BOARD_DIMEN,MAX_BOARD_DIMEN,,ImGuiSliderFlags.AlwaysClamp);
        }, true, false); 
        
        imgui_separator_text("Gimmicks");
        nodeprop_gimmick_flag("Day/Night Cycle###nodeprop_gim_daynightcycle", PJBD_GIMMICK_DAYNIGHT);
        //imgui_text_disabled("Star Price");
        //prop_add("starprice",function() {
            //return imgui_input_int($"###nodeprop_board_{path}_starprice",starprice);
        //}); 
        //if (imgui_is_item_deactivated_after_edit()) {
            //starprice = clamp(starprice, 0, 98);
        //}
        
        imgui_text_disabled("Camera Zoom");
        prop_add("cam_zoom_autoset", function() {
            return imgui_checkbox($"Automatically Set Camera Zoom?###nodeprop_board_{path}_cam_zoom_autoset", cam_zoom_autoset);
        }, true)
        if cam_zoom_autoset cam_zoom = 640/max(width, height);
        imgui_begin_disabled(cam_zoom_autoset);
        prop_add("cam_zoom",function() {
            return imgui_drag_float($"###nodeprop_board_{path}_cam_zoom",cam_zoom,0.01,0.05,1,,ImGuiSliderFlags.AlwaysClamp);
        }, true, false); 
        imgui_end_disabled();
        
        //
        
        //imgui_text_disabled("Gimmicks");

        //var _isdaynight = array_contains(gimmicks, PJBD_GIMMICK_DAYNIGHT);
        //if (_isdaynight) {
            //
        //}

        //if imgui_checkbox("Day/Night Cycle", _isdaynight) 
        //gimmicks[$ PJBD_GIMMICK_NOSTAREVENTS] = imgui_checkbox("No Star Events", gimmicks[$ PJBD_GIMMICK_NOSTAREVENTS]);
        
        imgui_separator_text("BGM");
        imgui_text_disabled("Daytime");
        bgm_day = imgui_input_text("###nodeprop_board_bgmday",bgm_day);
        if (array_contains(gimmicks, PJBD_GIMMICK_DAYNIGHT)) {
            imgui_text("Nighttime");
            bgm_night = imgui_input_text("###nodeprop_board_bgmnight", bgm_night);
        } else bgm_night = "";
        imgui_text_disabled("Last 5 Turns");
        bgm_pinch = imgui_input_text("###nodeprop_board_bgmpinch",bgm_pinch);
        //bgm_night = imgui_input_text("BGM (Night)###nodeprop_board_bgmnight",bgm_night);
        imgui_text("Custom Audio Files");
        if (imgui_small_button("Import...###nodeprop_board_add_caudio")) {
            var _file = get_open_filename("OGG Vorbis Files (*.ogg)|*.ogg", "");
            if (file_exists(_file)) {
                var _filename = filename_remove_extension(_file);
                var _buff = buffer_load(_file);
                var _b64 = buffer_base64_encode(_buff,0,buffer_get_size(_buff));
                buffer_delete(_buff);
                audio[$ _filename] = {};
                audio[$ _filename].buff = _b64;
                audio[$ _filename].loopStart = 0;
            }
        }
        
        //if (d_sy.music_playing != undefined) {
            //var _newpos = imgui_slider_float($"Playing:", audio_sound_get_track_position(d_sy.music_playing), 0, audio_sound_length(d_sy.music_playing));
            //if (imgui_is_item_edited()) {
                //audio_sound_set_track_position(d_sy.music_playing, _newpos);
            //}
        //}
       //
        
        var _names = struct_get_names(audio);
        for (var i = 0; i < array_length(_names); i++) {
            imgui_text(_names[i]);
            imgui_sameline();
            if (imgui_small_button($"Copy###nodeprop_board_caudio_{_names[i]}_copy")) {
                clipboard_set_text(_names[i]);
            }
            imgui_sameline(); 
            if (imgui_small_button($"Remove###nodeprop_board_caudio_{_names[i]}_remove")) {
                delete audio[$ _names[i]];
                struct_remove(audio, _names[i]);
                break;
            }

            //if (imgui_arrow_button($"###nodeprop_board_caudio_{_names[i]}_play")) {
                //if (d_sy.music_stream == undefined) {
                    //var _abuff = buffer_base64_decode(audio[$ _names[i]].buff);
                    //buffer_save(_abuff, game_save_id + "/_TEMP/playingaudio.ogg");
                    //buffer_delete(_abuff);
                    //d_sy.music_stream = audio_create_stream(game_save_id + "/_TEMP/playingaudio.ogg");
                    //audio_sound_loop_start(d_sy.music_stream, audio[$ _names[i]].loopStart);
                    //d_sy.music_playing = audio_play_sound(d_sy.music_stream,0,1);
                    //
                //} else {
                    //audio_destroy_stream(d_sy.music_stream);
                    //d_sy.music_stream = undefined;
                    //d_sy.music_playing = undefined;
                    //file_delete(game_save_id + "/_TEMP/playingaudio.ogg");
                //}
                //
            //}
            var _loopStart = audio[$ _names[i]][$ "loopStart"];
            if (is_real(_loopStart)) { 
                imgui_text_disabled("Loop Start");
                audio[$ _names[i]][$ "loopStart"] = imgui_input_float($"###nodeprop_board_caudio_{_names[i]}_loopstart", _loopStart);
            }
        }
        
        imgui_separator_text("Background Image");
        imgui_text("Daytime");
        nodeprop_image_button("bg",510*global.dpi_scale,383*global.dpi_scale);
        
        if (array_contains(gimmicks, PJBD_GIMMICK_DAYNIGHT)) {
        imgui_text("Nighttime");
        nodeprop_image_button("bg_night",510*global.dpi_scale,383*global.dpi_scale);
        } else {
            if (is_string(sprites[$ "bg"][$ "bg_night"])) {
                if (sprite_exists(rt_sprites[$ _sprname]))                 sprite_delete(rt_sprites[$ _sprname]);
                rt_sprites[$ _sprname] = -1;
                sprites[$ _sprname] = -1;
            }
        }
        
        
        imgui_text("Board Select Preview");
        nodeprop_image_button("preview",510*global.dpi_scale,383*global.dpi_scale, "Please ensure the image is 510x383 pixels. \nUse the snapshot feature in the Camera Tool to generate a board preview image (the image must be manually converted to a .jpg/.jpeg image!)");
    }
	
	static set_context = function(_sel = true) {
		if (_sel) {
			if (d_sy.context != noone) && (d_sy.context != self) {
				if (is_struct(d_sy.context)) {
					if (d_sy.context[$ "set_context"] != undefined) {
						d_sy.context.set_context(false);
					}
				}
			}
			d_sy.context = self;
            if (room != d_scn_bdedit) {
                room_goto(d_scn_bdedit);
            } else {
                for (var i = 0; i < array_length(content); i++) {
                    content[i].refresh();
                }
            }


		} else {
			d_sy.context = noone;
			for (var i = 0; i < array_length(content); i++) {
				content[i].refresh();
			}
		}
	}
    
    static set_image = function(_image) {
        try {
            var _file = get_open_filename("Image File (.jpg, .jpeg)|*.jpg", "");
            if (file_exists(_file)) {

                    if (sprite_exists(rt_sprites[$ _image])) sprite_delete(rt_sprites[$ _image]);
                    rt_sprites[$ _image] = sprite_add(_file,0,0,0,0,0);
                    _buff = buffer_load(_file);
                    sprites[$ _image] = { };
                    sprites[$ _image].buff = buffer_base64_encode(_buff,0,buffer_get_size(_buff));
                    buffer_delete(_buff);
                    sprites[$ _image].width = sprite_get_width(rt_sprites[$ _image]);
                    sprites[$ _image].height = sprite_get_height(rt_sprites[$ _image]);

            } else print("No file specified");
        } catch (_) {
            if buffer_exists(_buff) {
                buffer_delete(_buff);
            }
        }
    }
    
    static nodeprop_image_button = function(_sprname, _w = 128, _h = 64, _message = "") {
        imgui_push_style_var(ImGuiStyleVar.FramePadding,0,0);
        var _width = imgui_get_content_region_avail_x();
        var _height = (_width/_w)*_h;
        //var _x = imgui_get_cursor_pos_x();
        //var _y = imgui_get_cursor_pos_y();
        var _sx = imgui_get_cursor_screen_pos_x();
        var _sy = imgui_get_cursor_screen_pos_y();
        var _dl = imgui_get_window_drawlist();
        var _text = "Click to\nreplace...";
        //var _f_color = imgui_get_style_color(ImGuiCol.FrameBgHovered);
        var _o_color = imgui_get_style_color(ImGuiCol.NavHighlight);

        var _sprite = rt_sprites[$ _sprname];
        if (sprite_exists(_sprite)) {
            imgui_sameline();
            if (imgui_small_button($"Remove###nodeprop_{path}_{_sprname}_remove")) {
                if (sprite_exists(rt_sprites[$ _sprname])) sprite_delete(rt_sprites[$ _sprname]);
                rt_sprites[$ _sprname] = -1;
                sprites[$ _sprname] = -1;
            } else {
                if imgui_image_button($"###nodeprop_{path}_{_sprname}",_sprite,0,c_white,1,c_white,0,_width,_height) {
                    if (_message != "") {
                        show_message(_message);
                    }
                    set_image(_sprname);
                }
            }
        } else if (imgui_button(_text + $"###nodeprop_{path}_{_sprname}",_width,_height)) {
            if (_message != "") {
                show_message(_message);
            }    
            set_image(_sprname);
        }

        if (imgui_is_item_hovered()) {

            imgui_drawlist_add_rect(_dl, _sx, _sy, _sx + _width, _sy + _height, _o_color);
        }

        imgui_pop_style_var();
    }
    
    static nodeprop_gimmick_flag = function(_string, _gimmick) {
        var _hasgimmick = array_contains(gimmicks, _gimmick);
        var _setgimmick = imgui_checkbox(_string, _hasgimmick);
        if (imgui_is_item_clicked()) {
            if (!_hasgimmick) array_push(gimmicks, _gimmick) else {
                for (var i = 0; i < array_length(gimmicks); i++) {
                    if (gimmicks[i] == _gimmick) {
                        array_delete(gimmicks, i, 1);
                        i = 0;
                    }
                }
            }
        }
    }
	
	static refresh_background = function(_id = 0) {
    
	}

}

