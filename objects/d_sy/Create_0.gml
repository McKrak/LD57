#macro BTOOL_MOVER 0
#macro BTOOL_PLACER 1
#macro BTOOL_ERASER 2
#macro BTOOL_RESPACER 3
#macro BTOOL_RESPACER_CONT 4
#macro BTOOL_RESPACER_ERASER 5

application_surface_draw_enable(false);

texturegroup_load("editor");
dpi_scale = floor(global.dpi_scale);

ui_show_style_editor = false;
ui_show_nav_tips = false;

alarm[0] = -1;

nodetype = 1;
board_type = 1;

ts = undefined;
point = undefined;
ray = undefined;

placer_x = 0;
placer_y = 0;
placer_z = 0;

placer_gridsize = [16,16];

selbox_holding = false;
selbox_dragging = false;
selbox_sx = 0;
selbox_sy = 0;
selbox_sx_win = 0;
selbox_sy_win = 0;

selbox_x = 0;
selbox_y = 0;
selbox = [];


xpos = 0;
ypos = 0;
zoom = 1;
zpos = 0;

memory = [];
clipboard_memory = [];
map = {};
undo_maxsteps = 256;
//undo_memory = [];
undo_stack = [];

context = noone;

manager_init = false;
editor_init = false;


image_disp_test = 0;

holding = false;
drag_pos_x1 = 0;
drag_pos_y1 = 0;
drag_pos_z1 = 0;
drag_pos_x2 = 0;
drag_pos_y2 = 0;
drag_pos_z2 = 0;

target = noone;
hit = undefined;
hover = noone;
tool = 0;
selected = [];

music_stream = undefined;
music_playing = undefined;
music_loop_point = 0;
music_pos = 0;



//collider = cm_collider(0,0,0,0,0,1,1,0);


surf_x = 0;
surf_y = 0;
surf_w = 1;
surf_h = 1;
surf_mx = 0;
surf_my = 0;
surf_sx = 0;
surf_sy = 0;

node_count = 0;
node_selected = [];
//node_id = undefined;

rename_string = "";
modal_rename = false;
modal_loading = false;
modal_zip_saving = false;
modal_zip_saved = false;
modal_eventsel = false;
mouse_over_ui = false;
modal_exit = false;
modal_save = false;
modal_save_savefile = undefined;
modal_unload_nw = false;
modal_load_nw = false;
modal_about = false;
popup_delete = false;



ppm_nw = false;
ppm_datajs = noone;
ppm_schema = noone;
ppm_is_valid_version = false;
ppm_boardlist = [];
ppm_uid = 80000001;
ppm_pjversion = "";
ppm_bpatch_result = [];
ppm_build_saveto = "";
ppm_bpatch_file = "";
ppm_bpatch_jobs = 0;
ppm_bpatch_job = 0;

pjpatch_hires = false;

global.rpk_is_loading = false;
load_id = 0;



ImGui.__Initialize( ImGuiConfigFlags.DockingEnable |
ImGuiConfigFlags.DpiEnableScaleViewports |
ImGuiConfigFlags.DpiEnableScaleFonts);

imgui_set_style(ROOT_DIR_BSIDE + "/ThemeData/ppj.cpp");
imgui_set_style_var(ImGuiStyleVar.IndentSpacing, 12);

//if (file_exists(game_save_id + "EditorSaveData/manager.ini")) {
    //var _file = file_read_all_text(game_save_id + "EditorSaveData/manager.ini");
    //imgui_load_ini_settings_from_memory(_file);
    //manager_init = true;
//}
//if (file_exists(game_save_id + "EditorSaveData/editor.ini")) {
    //var _file = file_read_all_text(game_save_id + "EditorSaveData/editor.ini");
    //imgui_load_ini_settings_from_memory(_file);
    //editor_init = true;
//}

//var _locFile = file_read_all_text("Editor/LanguageData/en.loc");
//lang = json_parse(_locFile);
//print(loc(lang,"itemsel.pj_spaces.is_unused"));


function __interaction_handler() {
	if (instance_exists(obv_3dcam)) {
		var _cam = obv_3dcam
		var _inst = noone;
		if (_cam.is_orthographic) && imgui_is_window_hovered(ImGuiHoveredFlags.None) {
			_inst = collision_point(xpos,ypos,d_obi_selectable,true,true);
			if (instance_exists(_inst)) {
				_inst.hover = true;
			}
		}
        
        var _host = variable_instance_get(_inst, "host");
        var _hosttype = rpk_get_node_type(_host);
        switch (_hosttype) {
            case NODE_PJ_SPACE:
                imgui_begin_tooltip();
                imgui_text(string(_host[$ "name"]));
                imgui_separator();
                imgui_text_disabled($"Event: {_host[$ "space_event"]}");
                imgui_text_disabled($"Event Parameter: {_host[$ "event_param"]}");
                imgui_separator();
                var _dest = _host[$ "dest"];
                if (is_array(_dest))
                for (var i = 0; i < array_length(_dest); i++) {
                    imgui_text_disabled($"Dest {i+1}: {_dest[i]}");
                }
                imgui_end_tooltip();
            break;
            case NODE_PJ_OBJECT:
                imgui_begin_tooltip();
                imgui_text(string(_host[$ "name"]));
                imgui_separator();
                var _cprop = _host[$ "cprop"];
                if (is_struct(_cprop)) {
                    var _cnames = struct_get_names(_cprop);
                    for (var i = 0; i < array_length(_cnames); i++) {
                        imgui_text_disabled($"{_cnames[i]}: {_cprop[$ _cnames[i]][$ "value"]}");
                    }
                }
                imgui_end_tooltip();
            break;
        }
		
		switch(tool) {
			case 0:
				if (selbox_holding) {
					if mouse_check_button_released(mb_left)
					&& (imgui_is_window_hovered(ImGuiHoveredFlags.None)) 
					&& !selbox_dragging {
						if (instance_exists(_inst)) /*&& (selbox_x*selbox_y == 0)*/ {
							__selection_handler(_inst.host);
						} else {
							while (array_length(selected) != 0) {
								selected[0].toggle(false);
							}
						}
					} 
					
					if (!mouse_check_button(mb_left)) {
						if (selbox_holding == 1) {
						 	var _collist = ds_list_create();
							collision_rectangle_list(xpos,ypos,selbox_sx,selbox_sy,d_obi_selectable,true,true,_collist,false);
                            if (!keyboard_check(vk_control)) {
                                while (array_length(selected) != 0) {
                                    selected[0].toggle(false);
                                }
                            }
							for (var i = 0; i < ds_list_size(_collist); i++) {
								var _inst = ds_list_find_value(_collist,i);
								print(_inst);
								_inst.host.toggle(true);
							}
							ds_list_destroy(_collist);
						}
						selbox_holding = 0;
						selbox_dragging = 0;
					}
				} else selbox_dragging = 0;
				
				if (mouse_check_button(mb_left))
				&& (imgui_is_window_hovered(ImGuiHoveredFlags.None)) {
						
					if (!selbox_holding) {
						selbox_sx = xpos;
						selbox_sy = ypos;
                        selbox_sx_win = mouse_x;
                        selbox_sy_win = mouse_y;
						if (instance_exists(_inst)) {
							selbox_holding = 2;
						} else selbox_holding = 1;
					} 
					//print($"sx:{selbox_sx}\nsy:{selbox_sy}\n");
					if (selbox_holding) {
						//print(abs(selbox_sx - surf_mx - _cam.x));
						//print(abs(selbox_sy - surf_my - _cam.y));
						if (abs(selbox_sx - xpos) > 16)
						|| (abs(selbox_sy - ypos) > 16) {
							if (!selbox_dragging) && (selbox_holding == 2) {
								selbox = [];
								for (var i = 0; i < array_length(selected); i++) {
									if (selected[i].type == NODE_SPACE) 
									|| (selected[i].type == NODE_PJ_SPACE) 
									|| (selected[i].type == NODE_PJ_OBJECT) {
										selbox[i] = [selected[i].x - selbox_sx,selected[i].y - selbox_sy];
									}
								}
							}
							selbox_dragging = selbox_holding;
						}
					}
					
					if (selbox_dragging == 2) {
						for (var i = 0; i < array_length(selected); i++) {
							if (selected[i].type == NODE_SPACE) 
							|| (selected[i].type == NODE_PJ_SPACE) 
							|| (selected[i].type == NODE_PJ_OBJECT) {
								if (keyboard_check(vk_alt)) {
									xpos = placer_gridsize[0]*floor(xpos/placer_gridsize[0])+placer_gridsize[0]/2;
									ypos = placer_gridsize[1]*floor(ypos/placer_gridsize[1])+placer_gridsize[1]/2;
								}
								selected[i].x = selbox[i][0] + xpos;
								selected[i].y = selbox[i][1] + ypos;
								selected[i].refresh();
							}
						}
					}
				} else {
					selbox_holding = 0;
					selbox_dragging = 0;
				}
				
			break;
			case BTOOL_PLACER:
				if (keyboard_check(vk_alt)) {
					xpos = placer_gridsize[0]*floor(xpos/placer_gridsize[0])+placer_gridsize[0]/2;
					ypos = placer_gridsize[1]*floor(ypos/placer_gridsize[1])+placer_gridsize[1]/2;
				}
			
				if (!instance_exists(_inst) 
				&& mouse_check_button_pressed(mb_left)) 
				&& imgui_is_window_hovered(ImGuiHoveredFlags.ChildWindows)
				&& (context != noone) 
				&& (itemsel_item != noone) {
					if ((context.type == NODE_BOARD || context.type == NODE_PJ_BOARD)) 
					&& (struct_exists(itemsel[$ itemsel_game][itemsel_cat],"type")) {
						switch (itemsel[$ itemsel_game][itemsel_cat][$ "type"]) {
							case "spaces":
								//var _id = find_next_vacant_id(context.content,NODE_PJ_SPACE);
								var _space = rpk_add_node(context,pjspace,"boardspace.0");
                                
                                //rpk_rename_node(_space,"boardspace." + string(_id));
								_space.x = xpos;
								_space.y = ypos;
								//_space.index = _id;
								_space.space_type = itemsel_item[$ "index"];
								//var _space = new pjspace(xpos,ypos,,,_id,,other.img);
								_space.add_instance();
                                undostack_push([UNDO_ADD,_space]);
								//array_push(context.content,_space);
							break;
							case "objects":
								var _space = rpk_add_node(context,pjobject,itemsel_item[$ "index"]);
								_space.x = xpos;
								_space.y = ypos;
                                if (itemsel_item[$ "cprop"]) != undefined {
                                    _space.cprop = variable_clone(itemsel_item[$ "cprop"]);
                                }
								_space.object_type = itemsel_item[$ "index"];
								if (itemsel_item[$ "xscale"] != undefined) _space.xscale = itemsel_item[$ "xscale"];
								if (itemsel_item[$ "yscale"] != undefined) _space.yscale = itemsel_item[$ "yscale"];
								if (itemsel_item[$ "xorig"] != undefined) _space.xorig = itemsel_item[$ "xorig"];
								if (itemsel_item[$ "yorig"] != undefined) _space.yorig = itemsel_item[$ "yorig"];
								//var _space = new pjspace(xpos,ypos,,,_id,,other.img);
								_space.add_instance();
                                undostack_push([UNDO_ADD,_space]);
								//array_push(context.content,_space);
							break;
						}
					}
				}
			break;
			case BTOOL_ERASER:
				if (instance_exists(_inst) 
				&& mouse_check_button(mb_left)
				&& imgui_is_window_hovered(ImGuiHoveredFlags.ChildWindows)) {
                    _inst.host.remove();
                    //undostack_push([UNDO_DEL,_inst.host]);
                }
			break;
			case BTOOL_RESPACER:
				if (instance_exists(_inst)) /*&& (selbox_x*selbox_y == 0)*/ {
					if (_inst.host.type == NODE_PJ_SPACE) {
						if mouse_check_button_pressed(mb_left)
						&& (imgui_is_window_hovered(ImGuiHoveredFlags.None)) {
							__selection_handler(_inst.host);
							respacer_src = _inst;
						}
					}
				}		
				
				
				
				if (!mouse_check_button(mb_left)) {
					if (mouse_check_button_released(mb_left)) {
						if (instance_exists(respacer_src)) && (instance_exists(respacer_dest)) && (respacer_src != respacer_dest) {
                            if (!array_contains(respacer_src.host.dest, respacer_dest.host.name)) {
    							for (var i = 0; i < array_length(respacer_src.host.dest); i++) {
                                    if ((respacer_src.host.dest[i] == -1) || (respacer_src.host.dest[i] == "")) {
    									respacer_src.host.dest[i] = respacer_dest.host.name;
                                        respacer_src.host.refresh();
                                        respacer_dest.host.refresh();
    									break;
    								}
    							}
                            }
						}
					}
					respacer_dest = noone;
					respacer_src = noone;
				}
				
				if (instance_exists(_inst)) && (mouse_check_button(mb_left)) {
					if (_inst.host.type == NODE_PJ_SPACE) {
						respacer_dest = _inst;
					}
				} else respacer_dest = noone;
			break;
            case BTOOL_RESPACER_CONT:
                if (instance_exists(_inst)) /*&& (selbox_x*selbox_y == 0)*/ {
                    if (_inst.host.type == NODE_PJ_SPACE) {
                        if mouse_check_button_pressed(mb_left)
                        && (imgui_is_window_hovered(ImGuiHoveredFlags.None)) {
                            __selection_handler(_inst.host);
                            respacer_src = _inst;
                        }
                    }
                }		
                
                if (instance_exists(respacer_dest)) {
                    if (instance_exists(respacer_src)) && (instance_exists(respacer_dest)) && (respacer_src != respacer_dest) {
                        

                        if (!array_contains(respacer_src.host.dest, respacer_dest.host.name)) {
                            for (var i = 0; i < array_length(respacer_src.host.dest); i++) {
                                if ((respacer_src.host.dest[i] == -1) || (respacer_src.host.dest[i] == "")) {
                                    respacer_src.host.dest[i] = respacer_dest.host.name;
                                    respacer_src.host.refresh();
                                    respacer_dest.host.refresh();
                                    respacer_src = respacer_dest;
                                    respacer_dest = noone;
                                    break;
                                }
                            }
                        }

                    }
                }
                if (!mouse_check_button(mb_left)) {
                    respacer_dest = noone;
                    respacer_src = noone;
                }
                
                if (instance_exists(_inst)) && (mouse_check_button(mb_left)) {
                    if (_inst.host.type == NODE_PJ_SPACE) {
                        respacer_dest = _inst;
                    }
                } else respacer_dest = noone;
            break;
            case BTOOL_RESPACER_ERASER:
                if (instance_exists(_inst) 
                && mouse_check_button(mb_left)
                && imgui_is_window_hovered(ImGuiHoveredFlags.ChildWindows)) {
                    for (var i = 0; i < array_length(_inst.host.dest); i++) {
                        _inst.host.dest[i] = "";
                    }
                    _inst.host.refresh();
                }
            break;
		}
	}
}

function __selection_handler(_content) {
	if (keyboard_check(vk_control)) {
		_content.toggle();
	} else {
		while (array_length(selected) != 0) {
			selected[0].toggle(false);
		}
		//for (var i = 0; i < array_length(selected); i++) {
		//	if (selected[i] != _content) selected[i].toggle(false);
		//}
		_content.toggle(true);
	}
}

function __change_handler() {
	if (imgui_is_item_deactivated_after_edit()) {
		//array_push(undo_memory,json_stringify(ElephantToJSON(memory,true)));
		//array_push(undo_memory_test,json_stringify(ElephantToJSON(memory,false)));
	}
	//array_push(undo_memory,ElephantToJSON(memory,true));
}
//ppm_token_test();

room_goto_next();
