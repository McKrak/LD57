

#region Modals

var _modalflags = ImGuiWindowFlags.NoMove|ImGuiWindowFlags.NoResize;
var _setmodalpos = function() {
    imgui_set_next_window_pos(global.res_width/2,global.res_height/2,,0.5,0.5);
    imgui_set_next_window_size(400,0);
}

_setmodalpos();
if (modal_save_savefile != undefined) {
    if (imgui_begin_popup_modal($"{modal_save_savefile[$ "name"]}###modal_save", undefined, _modalflags)) {
        imgui_text_wrapped($"Close \"{modal_save_savefile[$ "name"]}\"? Any unsaved progress will be lost!");
        imgui_separator();
        if (imgui_button("Save")) {
            if (rpk_get_node_type(modal_save_savefile) == NODE_PJ_BOARD) {
                print("IS PJBD");
                var _savestatus = save_ppb(modal_save_savefile);
                print(_savestatus);
                if _savestatus == true {
                    imgui_close_current_popup();
                    modal_save_savefile.remove();
                }
            }    
        } imgui_sameline();
        if (imgui_button("Don't Save")) {
            imgui_close_current_popup();
            modal_save_savefile.remove(true);
        } imgui_sameline();
        if (imgui_button("Cancel")) {
            imgui_close_current_popup();
        }
        imgui_end_popup();
    }
}
modal_save = false;

_setmodalpos();
if (imgui_begin_popup_modal("Exit?###modal_exit", undefined, _modalflags)) {
    imgui_text_wrapped("Are you sure you want to exit?");
    imgui_separator();
    if (imgui_button("Yes")) game_end();
    imgui_sameline();
    if (imgui_button("Nevermind")) imgui_close_current_popup();
    imgui_end_popup();	
}
modal_exit = false;

_setmodalpos();
if (imgui_begin_popup_modal("Party Project Workshop###modal_about", undefined, _modalflags)) {
    var _w = imgui_get_content_region_avail_x();
    imgui_image(d_spu_pj_logo,0,,,_w,_w/sprite_get_width(d_spu_pj_logo)*sprite_get_height(d_spu_pj_logo));
    imgui_text("Party Project Workshop "); imgui_sameline();
    imgui_text_disabled($"{VERSION}");
    imgui_text_disabled($"Supported Party Project Versions: v98.4 (hotfix)")
    imgui_separator_text("Credits");
    imgui_text_wrapped("- McKrak - Developer");
    imgui_text_wrapped("- Charro64 - Creator of original game (Party Project), additional support.");
    imgui_text_wrapped("- typhloquil - Tester");
    imgui_text_wrapped("- dudegamer64 - Tester");
    
    imgui_separator_text("Disclaimer");
    imgui_text_wrapped("This is an UNOFFICIAL tool made by someone unaffiliated with the game. Things WILL break!\nDo NOT submit bug reports that happen in-game from using this tool in the Party Project Discord. Unless you are CERTAIN, and have PROOF that a bug can occur in an unmodified version of Party Project, please submit any bug reports here:");
    imgui_text_link_open_url("https://mckrak.itch.io/partyprojectworkshop/community", "https://mckrak.itch.io/partyprojectworkshop/community");
    
    
    imgui_separator();
    if (imgui_button("View on itch.io###model_about_itch")) {
        url_open("https://mckrak.itch.io/partyprojectworkshop");
    } imgui_sameline();
    if (imgui_button("Close###modal_about_close")) imgui_close_current_popup();
    imgui_end_popup();	
}
modal_about = false;

_setmodalpos();
if (imgui_begin_popup_modal("Unload package.nw?###modal_unload_nw", undefined, _modalflags)) {
    
    imgui_text_wrapped("Do you want to unload this version of Party Project? It will not be recoverable if you don't have a vanilla backup saved!");
    imgui_text_wrapped($"(You can retrieve the vanilla package.nw folder from {game_save_id})");
    imgui_separator();
    if (imgui_button("Yes")) {
        ppm_unload_nw();
        imgui_close_current_popup();
    }
    imgui_sameline();
    if (imgui_button("Nevermind")) imgui_close_current_popup();
    imgui_end_popup();
}
modal_unload_nw = false;

_setmodalpos();
if (imgui_begin_popup_modal("Loading in a package.nw###modal_load_nw", undefined, _modalflags)) {
    imgui_text_wrapped("Select an original, unmodified Party Project package.nw file.\nThis will create a clone at Party Project Workshop's save directory for that version. This will only need to be done once per version.");
    imgui_separator();
    if (imgui_button("OK")) {
        var _file = get_open_filename("Node-Webkit File (.nw)|*.nw", "");
        if (file_exists(_file)) {
            ppm_unload_datajs();
            load_id = zip_unzip_async(_file, game_save_id + "package/");
            modal_loading = true;
        }
        imgui_close_current_popup();
    }
    imgui_end_popup();
}
modal_load_nw = false;

_setmodalpos();
if (imgui_begin_popup_modal("Loading Package###modal_loading", undefined, _modalflags)) {
    imgui_text_wrapped("This should only take a moment...");
    if (!modal_loading) {
        imgui_close_current_popup();
    }
    imgui_end_popup();	
}



_setmodalpos();
if (imgui_begin_popup_modal("Building...###modal_zip_saving", undefined, _modalflags)) {
    if (ppm_bpatch_jobs) {
        var ppm_bpatch_filename = filename_remove_extension(ppm_bpatch_file);
        imgui_text($"Patching Board: {ppm_bpatch_filename}");
        imgui_progressbar(ppm_bpatch_job/(ppm_bpatch_jobs+1),imgui_get_content_region_avail_x());
    } else {
        imgui_text("Saving package... this might take a while!");
        imgui_progressbar(1/1,imgui_get_content_region_avail_x());
    }
    
    if (!modal_zip_saving) {
        imgui_close_current_popup();
    }
    imgui_end_popup();	
}

_setmodalpos();
if (imgui_begin_popup_modal("Save Successful###modal_zip_saved", undefined, _modalflags)) {
    var _errs = array_length(ppm_bpatch_result);
    if (!_errs) {
        imgui_text_wrapped("Game successfully patched! You can now play Party Project.");
    } else {
        imgui_text_wrapped("The game was successfully patched, but some boards were unable to be added.\n\nThe problematic boards are as follows: ");
        for (var i = 0; i < _errs; i++) {
            imgui_bullet_text(ppm_bpatch_result[i]);
        }
        imgui_text_wrapped("The game should still be playable, but the above boards will not be present.");
    }
    if (imgui_button("OK###modal_zip_saved_confirm")) {
        ppm_bpatch_result = [];
        modal_zip_saved = false;
        imgui_close_current_popup();
    }
    imgui_end_popup();	
}
//if (imgui_begin_popup_modal("Error###modal_zip_saved", undefined, _modalflags)) {
    //imgui_text("Game successfully patched! You can now play Party Project.");
    //if (imgui_button("OK###modal_zip_saved_confirm")) {
        //imgui_close_current_popup();
    //}
    //imgui_end_popup();	
//}
//modal_zip_saved = false;

imgui_set_next_window_pos(global.res_width/2,global.res_height/2,,0.5,0.5);
imgui_set_next_window_size_constraints(global.res_width/2,global.res_width/2,global.res_width,global.res_height);
if (imgui_begin_popup_modal("Choose an Event...###modal_eventsel", undefined, ImGuiWindowFlags.NoMove)) {
    var _tabnames = struct_get_names(eventsel);
    var _evsel = undefined;
    if (imgui_begin_tab_bar("###modal_eventsel_catsel")) {
        if (imgui_begin_tab_item("Happening Space Events###modal_eventsel_catsel_rs")) {
            _evsel = eventsel[$ "rs"];
            imgui_end_tab_item();
        }
        if (imgui_begin_tab_item("Pass-By Events###modal_eventsel_catsel_pj")) {
            _evsel = eventsel[$ "pj"];
            imgui_end_tab_item();
        }
        imgui_end_tab_bar();
    }
    if (is_array(_evsel)) {
        var _flags = ImGuiTableFlags.BordersV | ImGuiTableFlags.BordersOuterH | ImGuiTableFlags.Resizable | 
        ImGuiTableFlags.RowBg | ImGuiTableFlags.ScrollY | ImGuiTableFlags.NoBordersInBody;
        
        if (imgui_begin_table("###modal_eventsel_selector", 4, _flags, undefined, imgui_get_content_region_avail_y() - 32)) {
            var _colwidth = [4];
            imgui_table_setup_scroll_freeze(0, 1);
            imgui_table_setup_column("Event ID###modal_eventsel_selector_id",ImGuiTableColumnFlags.None);
            imgui_table_setup_column("Name###modal_eventsel_selector_name",ImGuiTableColumnFlags.None);
            imgui_table_setup_column("Desc###modal_eventsel_selector_desc",ImGuiTableColumnFlags.None);
            imgui_table_setup_column("Special Requirements###modal_eventsel_selector_spec",ImGuiTableColumnFlags.None);
            
            imgui_table_headers_row();
            
            for (var i = 0; i < 4; i++) {
                imgui_table_next_column();
                _colwidth[i] = imgui_get_column_width(); 
                //imgui_text(_colwidth[i]);
            }

            for (var i = 0; i < array_length(_evsel); i++) {
                imgui_table_next_row();
                var _name = loc(lang, _evsel[i][$ "name"]);
                var _desc = loc(lang, _evsel[i][$ "desc"]);
                var _spec = _evsel[i][$ "spec"] != undefined ? loc(lang, _evsel[i][$ "spec"]) : "";
                var _id = _evsel[i][$ "value"];
                var _row_height = max(
                imgui_calc_text_height(_name,,_colwidth[1]),
                imgui_calc_text_height(_id,,_colwidth[0]),
                imgui_calc_text_height(_desc,,_colwidth[2]),
                imgui_calc_text_height(_spec,,_colwidth[3])
                );
                imgui_table_next_column();
                var _sel_flags = ImGuiSelectableFlags.SpanAllColumns | ImGuiSelectableFlags.AllowOverlap;
                if (imgui_selectable($"###modal_eventsel_selector_button_{i}",_id == eventsel_item,_sel_flags,0,_row_height)) {
                    eventsel_item = _id;
                }
                imgui_sameline();
                imgui_text_wrapped(_id);
                imgui_table_next_column();
                imgui_text_wrapped(_name); 
                imgui_table_next_column();
                imgui_text_wrapped(_desc);
                imgui_table_next_column();
                imgui_text_wrapped(_spec);
            }
            imgui_end_table();
        }
    }
    imgui_separator();
    if (imgui_button("Nevermind###modal_eventsel_cancel")) imgui_close_current_popup(); 
    imgui_sameline(imgui_get_content_region_avail_x() - imgui_calc_text_width("Confirm"));
    if (imgui_button("Confirm###modal_eventsel_confirm")) {
        for (var i = 0; i < array_length(selected); i++) {
            if (rpk_get_node_type(selected[i]) == NODE_PJ_SPACE) {
                selected[i][$ "space_event"] = eventsel_item;
            }
        }
        imgui_close_current_popup(); 
    }    
    imgui_end_popup();	
}
modal_eventsel = false;

_setmodalpos();
if (imgui_begin_popup_modal($"Rename###modal_rename", undefined, ImGuiWindowFlags.NoMove|ImGuiWindowFlags.NoResize)) {
    //imgui_text("Are you sure you want to exit?");
    rename_string = imgui_input_text("###modal_rename_input",rename_string);
    imgui_separator();
    if (imgui_button("Cancel###modal_rename_cancel")) imgui_close_current_popup();
    imgui_sameline();
    if (imgui_button("OK###modal_rename_ok")) {
        rpk_rename_node(selected[0], rename_string);
    }
    imgui_end_popup();	
}
modal_rename = false;

//if (imgui_begin_popup($"###popup_delete")) {
    //imgui_text("Delete?");
    //if (imgui_menu_item("OK")) {
        //for (var i = array_length(selected) - 1; i >= 0; i--) {
            //if (rpk_get_node_type(selected[i]) != NODE_PJ_BOARD) selected[i].remove();
        //}
    //}
    //imgui_end_popup();
//}

var _new_modal = false;

#endregion



if (imgui_begin_mainmenubar()) {
    if (imgui_begin_menu("File###mainbar_file")) {
        
        if (imgui_menu_item($"New###file_new_rpk", "Ctrl+N")) {
            rpk_add_node(global.mem[1], rpk);
        }
        //if (imgui_menu_item($"Open... (.rpk)...###file_import_pp", "Ctrl+O")) {
            //rpk_load();
            //
        //}
        
        
        if (imgui_menu_item($"Import (.rpk)...###file_import")) {
            
            var _rpk = rpk_load();
            if _rpk != undefined {
                array_push(global.mem[1],_rpk);
            }
            
        }
        if (imgui_menu_item($"Import Node...###file_import_node")) {
            
            var _load = rpk_load_node(true);
            if _load != undefined {
                array_push(global.mem[1],_load);
            }
            
        }
        
        imgui_separator();
        if (imgui_menu_item("Exit","Alt+F4")) {
            modal_exit = true;
        }
        imgui_end_menu();
    }

    if (imgui_begin_menu("Window###mainbar_workspace")) {
        if (imgui_menu_item("Editor Appearance Settings###mainbar_workspace_appearance_settings",,ui_show_style_editor)) {
            ui_show_style_editor = !ui_show_style_editor;
        }
        
        if (imgui_menu_item($"Reset Layout###mainbar_workspace_reset_layout")) {
            editor_init = false;
        }
        
        
        imgui_end_menu();
    }


    if (imgui_begin_menu("Help###mainbar_help")) {
        if (imgui_menu_item($"Show Navigation Tips###mainbar_help_nav",,ui_show_nav_tips)) {
            ui_show_nav_tips = !ui_show_nav_tips;
        }
        if (imgui_menu_item($"About Party Project Workshop###mainbar_help_about")) {
            modal_about = true;
        }
        imgui_separator();
        if (imgui_menu_item($"Open Tutorial###mainbar_help_tutorial")) {
            url_open("https://docs.google.com/document/d/1sk-SL5nDf_l5GxDrEXll2Ub71Ddt-QcKPD-u6Gn72Vc")
        }
        imgui_end_menu();
    }

    var _dbgstats = $"FPS: {fps_real}";
    var _textw = imgui_calc_text_width(_dbgstats);
    imgui_set_cursor_pos_x(imgui_get_content_region_avail_x()-_textw);
    imgui_text_disabled(_dbgstats);
    imgui_end_mainmenubar();
}


        if (keyboard_check_pressed(vk_delete)) {
            for (var i = array_length(selected) - 1; i >= 0; i--) {
                if (rpk_get_node_type(selected[i]) != NODE_PJ_BOARD) selected[i].remove();
            }
        }
        
        //if (keyboard_check_pressed(ord("C")) && keyboard_check(vk_control)) {
            //while (array_length(clipboard_memory) != 0) {
                //delete clipboard_memory[0];
                //array_delete(clipboard_memory,0,1);
            //}
            //for (var i = 0; i < array_length(selected); i++) {
                //array_push(clipboard_memory, ElephantDuplicate(selected[i]));
            //}
        //}
        //
        //if (keyboard_check_pressed(ord("V")) && keyboard_check(vk_control)) {
            //if (context != noone) {
                //for (var i = 0; i < array_length(clipboard_memory); i++) {
                    //if (clipboard_memory[i].type == NODE_PJ_SPACE)
                    //|| (clipboard_memory[i].type == NODE_PJ_OBJECT) {
                        //var _node = ElephantDuplicate(clipboard_memory[i]);
                        //array_push(context.content, _node);
                        //rpk_set_paths(context);
                        //rpk_rename_node(_node,ppj_find_next_vacant_id(context.content),false);
                        //_node.toggle(true);
                    //}
                //}
            //}
        //}
        //
        //if (keyboard_check_pressed(ord("Z")) && keyboard_check(vk_control)) {
            //if (is_struct(context)) {
                //var _umem = context[$ "undo_memory"];
                //if (is_array(_umem)) {
                    //var _step = array_pop(_umem);
                    //if (is_array(_step)) {
                        //for (var i = 0; i < array_length(_step); i++) {
                            //var _node = _step[i]
                            //print(_node[i]);
                            //if (_node[0] == UNDO_ADD) {
                                //_node[1].remove();
                            //} else if (_node[0] == UNDO_DEL) {
                                //array_push(context.content, _node[1]);
                                //rpk_set_paths(context);
                            //}
                        //}
                    //}
                //}
            //}
        //}
        
        if (keyboard_check_pressed(ord("S")) && keyboard_check(vk_control)) {
            if (is_struct(context)) {
                if (rpk_get_node_type(context) == NODE_PJ_BOARD) {
                    save_ppb(context, keyboard_check(vk_shift));
                }
            }
        }
    
        if (keyboard_check_pressed(ord("W")) && keyboard_check(vk_control)) {
            if (is_struct(context)) {
                if (rpk_get_node_type(context) == NODE_PJ_BOARD) {
                    context.remove();
                }
            }
        }
    
        if (keyboard_check_pressed(ord("N")) && keyboard_check(vk_control)) {
            rpk_add_node(global.mem[1], pjboard);
        }
    
        if (keyboard_check_pressed(ord("O")) && keyboard_check(vk_control)) {
            var _load = load_pjb(false);
        }


        
        var node_id = imgui_dock_space_over_viewport(ImGuiDockNodeFlags.PassthruCentralNode);

        if (!editor_init) {
            var dock1 = ImGui.DockBuilderSplitNode(node_id, ImGuiDir.Left, 0.25);
            node_id = dock1[2];
            dock1 = dock1[0];
            
            var dock2 = ImGui.DockBuilderSplitNode(node_id, ImGuiDir.Right, 0.25);
            node_id = dock2[2];
            dock2 = dock2[0];
            
            //var dock3 = ImGui.DockBuilderSplitNode(node_id, ImGuiDir.Down, 0.25);
            //node_id = dock3[2];
            //dock3 = dock3[0];
            

            ImGui.DockBuilderDockWindow("###viewport",node_id);
            

            ImGui.DockBuilderDockWindow($"###nodelist", dock1);
            ImGui.DockBuilderDockWindow($"###nodeprop", dock2);
            //ImGui.DockBuilderDockWindow($"###itemsel", dock3);
            ImGui.DockBuilderFinish(node_id);
            editor_init = true;	
        }
        
        
        #region NodeList
        if (imgui_begin($"Node List###nodelist")) {
            //populate_rpk_nodetree(memory);
            imgui_push_style_var(ImGuiStyleVar.FramePadding,8,8);
            for (var i = 0; i < array_length(global.mem[1]); i++) {
                global.mem[1][i].populate_nodetree();
            }
            imgui_pop_style_var();
        }
        imgui_end();
        #endregion
        
        #region NodeProp
        if (imgui_begin($"Node Properties###nodeprop")) {
            //var _proptype = 0;
            //
            //if (array_variable_compare(selected,"type")) {
                //_proptype = selected[0].type;
            //} else {
                //_proptype = 0;
            //}
            //imgui_text_disabled($"{array_length(selected)} selected. {_proptype}");
            //imgui_separator();
        //
            //if (array_length(selected)) {
                //imgui_text(selected[0].name);
                //imgui_text_disabled(selected[0].path);  imgui_sameline(imgui_get_window_content_region_max_x() - 30);
                //if (imgui_small_button("Copy")) {
                    //clipboard_set_text(selected[0].path);
                //}
            //}
            //imgui_separator();
            //
            //populate_nodeprop(_proptype);
            var _proptype = 0;
            
            if (array_variable_compare(selected,"type")) {
                _proptype = selected[0].type;
            } else {
                _proptype = 0;
            }
            imgui_text_disabled($"{array_length(selected)} selected. {_proptype}");
            imgui_separator();
            
            if (array_length(selected)) {
                var _last = array_last(selected);
                imgui_text(_last.name);
                imgui_sameline(imgui_get_window_content_region_max_x() - 30);
                if (imgui_small_button("Copy")) {
                    clipboard_set_text(_last.name);
                }
                imgui_text_disabled(_last.path);  
                imgui_sameline(imgui_get_window_content_region_max_x() - 30);
                if (imgui_small_button("Copy###nodeprop_copy_path")) {
                    clipboard_set_text(_last.path);
                }
                imgui_separator();
                if (_proptype != 0) _last.populate_nodeprop();
            }
            
            //populate_nodeprop(_proptype);
        
            //#region Board
        
            //#endregion
            
            
        }
        imgui_end();
        #endregion
        
        //#region ItemSel
        //if (imgui_begin($"Item Selection###itemsel{id}")) {
            //if (imgui_begin_child($"Categories###itemsel_cat{id}",60,,ImGuiChildFlags.ResizeX|ImGuiChildFlags.Border)) {
                //imgui_push_style_color(ImGuiCol.Button,#000000,0);
                //imgui_push_style_color(ImGuiCol.ButtonActive,#FFFFFF,1);
                //imgui_push_style_color(ImGuiCol.ButtonHovered,c_pjyellow,1);
                //imgui_push_style_var(ImGuiStyleVar.WindowPadding,5,5);
                //imgui_push_style_var(ImGuiStyleVar.FramePadding,0,0);
                    //
                //var _get_selection_color = function(_id) {
                    ///*if _id == tool_hovered return c_yellow 
                    //else*/ if _id == itemsel_cat return c_white 
                    //else return c_gray;
                //}
                //
                //var _size = 44*dpi_scale;
                //
                //for (var i = 0; i < array_length(itemsel[$ itemsel_game]); i++) {
                    //var _index = itemsel[$ itemsel_game][i];
                    //if (imgui_image_button(
                    //loc(lang, _index[$ "name"]) + $"###itemsel_cat_{itemsel_game}_{_index[$ "name"]}",
                    //asset_get_index(_index[$ "spr"]), real(_index[$ "img"]),_get_selection_color(i),1,c_white,0,_size,_size)) {
                        //itemsel_cat = i;
                        //itemsel_item = noone;
                    //}
                //}
                ////if imgui_image_button($"Party Project Nodes###itemsel_cat_pj_spaces{id}",	d_spu_pj_categories,0,_get_selection_color("pj_spaces"),1,c_white,0,44,44) itemsel_cat = "pj_spaces";
                ////if imgui_image_button($"Party Project Nodes###itemsel_cat_pj_objects{id}",	d_spu_pj_categories,0,_get_selection_color("pj_objects"),1,c_white,0,44,44) itemsel_cat = "pj_objects";
        //
                //imgui_pop_style_color(3);
                //imgui_pop_style_var(2);
            //}
            //imgui_end_child();
            //
            //
            //imgui_sameline();
            //
            //
            //if (imgui_begin_child($"Selector###itemsel_selector{id}",
            //imgui_get_content_region_avail_x(),imgui_get_content_region_avail_y(),ImGuiChildFlags.Border)) {
            //
                //for (var i = 0; i < array_length(itemsel[$ itemsel_game][itemsel_cat][$ "content"]); i++) {
                    //var _element = itemsel[$ itemsel_game][itemsel_cat][$ "content"][i];
                    //
                    //var _spr = asset_get_index(_element.spr);
                    //
                    //if (imgui_image_button($"Item###itemsel_selector_item{i}_{id}",
                    //_spr,_element.img,c_white,1,c_white,0,64*dpi_scale,64*dpi_scale)) {
                        //
                        //if (tool == BTOOL_MOVER) {
                            //if (itemsel_cat == 0) {
                                //for (var j = 0; j < array_length(selected); j++) {
                                    //var _node = selected[j];
                                    //if (rpk_get_node_type(_node) == NODE_PJ_SPACE) {
                                        //_node.space_type = _element.index;
                                        //_node.refresh();
                                    //}
                                //}
                            //}
                        //} else itemsel_item = _element; 
                    //}
                    //if (imgui_is_item_hovered(ImGuiHoveredFlags.Stationary)) {
                        //
                        ////imgui_set_next_window_size(240,400);
                        //imgui_begin_tooltip();
                        //imgui_text($"{loc(lang,_element.name)} ({_element.index})");
                        //
                        //imgui_push_text_wrap_pos(700);
                        //if _element.unused imgui_text_colored(loc(lang,$"itemsel.is_unused"),c_red);
                        //imgui_text_disabled(loc(lang,_element.desc));
                        //imgui_pop_text_wrap_pos();
                            //
                        ////if (!keyboard_check(vk_tab)) {
                        ////	imgui_text_colored(loc(lang,"itemsel.tab_notice"),#aaaa00);
                        ////} else {
                        ////	imgui_push_text_wrap_pos(700);
                        ////	imgui_text_disabled(itemsel.pj_spaces[i].desc);
                        ////	imgui_pop_text_wrap_pos();
                        ////}
                        //imgui_end_tooltip();
                        //
                        //
                    //}
                    //
                    //var _lastitem = imgui_get_item_rect_max_x();
                    //var _nextitem = _lastitem + 8 + 64*dpi_scale;
                    //if (i + 1 < array_length(itemsel[$ itemsel_game][itemsel_cat][$ "content"])) 
                    //&& (_nextitem < imgui_get_window_x() + imgui_get_window_content_region_max_x()) {
                        //imgui_sameline();
                    //}
                    //
                //}
                //
            //}
            //imgui_end_child();
        ////ImGui.TextColored("You can choose to include specific windows inside of split dock nodes!", c_yellow);
            //
        //}
        //imgui_end();
        //
        //#endregion
        
        #region Viewport
        if (ImGui.Begin("Viewport###viewport")) {
            switch (room_get_name(room)) {
                case "d_scn_bdedit":	
                
                if (imgui_begin_child($"toolsel{id}",60*dpi_scale,,/*ImGuiChildFlags.ResizeX|*/ImGuiChildFlags.Border)) {
                    imgui_push_style_color(ImGuiCol.Button,#000000,0);
                    imgui_push_style_color(ImGuiCol.ButtonActive,#FFFFFF,1);
                    imgui_push_style_color(ImGuiCol.ButtonHovered,c_pjyellow,1);
                    imgui_push_style_var(ImGuiStyleVar.WindowPadding,5,5);
                    imgui_push_style_var(ImGuiStyleVar.FramePadding,0,0);
                        
                    var _get_selection_color = function(_id) {
                        /*if _id == tool_hovered return c_yellow 
                        else*/ if _id == tool return c_white 
                        else return c_gray;
                    }
                    
                    var _size = 44*dpi_scale;
                        
                    if imgui_image_button("Mover",	         	    d_spu_tool0,0,_get_selection_color(0),1,c_white,0,_size,_size) tool = 0; 
                    if imgui_image_button("Placer",	    	        d_spu_tool1,0,_get_selection_color(1),1,c_white,0,_size,_size) tool = 1; 
                    if imgui_image_button("Eraser",		            d_spu_tool2,0,_get_selection_color(2),1,c_white,0,_size,_size) tool = 2;
                    if imgui_image_button("Linker",	                d_spu_tool3,0,_get_selection_color(3),1,c_white,0,_size,_size) tool = 3; 
                    if imgui_image_button("Linker (Continuous)",	d_spu_tool4,0,_get_selection_color(4),1,c_white,0,_size,_size) tool = 4;
                    if imgui_image_button("Unlinker",           	d_spu_tool5,0,_get_selection_color(5),1,c_white,0,_size,_size) tool = 5;
                        
                        {
                        var _cur = imgui_get_cursor_pos_y();
                        var _h = imgui_get_content_region_max_y();
                        
                        imgui_set_cursor_pos_y(_h - _size);
                        if (imgui_image_button("Spaces Visibility###viewport_space_vis", d_spu_bdedit_viewspaces,viewspaces,viewspaces ? c_white : c_grey,1,c_white,0,_size,_size)) {
                            
                            viewspaces = !viewspaces;
                            layer_set_visible("Grid", viewspaces);
                            
                        }
                        imgui_set_cursor_pos_y(-(_h - _size))
                        _h = imgui_get_content_region_max_y();
                        imgui_set_cursor_pos_y(_h - _size - 4 - _size);
                        if (imgui_image_button("Spaces Visibility###viewport_camera", d_spu_bdedit_picturemode,0,picturemode ? c_white : c_grey,1,c_white,0,_size,_size)) {
                            
                            picturemode = !picturemode;
                            
                        }
                        if (rpk_get_node_type(context) == NODE_PJ_BOARD) && (array_contains(context.gimmicks,PJBD_GIMMICK_DAYNIGHT)) {
                            imgui_set_cursor_pos_y(-(_h - _size))
                            _h = imgui_get_content_region_max_y();
                            imgui_set_cursor_pos_y(_h - (3*_size) - 8);
                            if (imgui_image_button("Time of Day###viewport_timeofday", d_spu_bdedit_timeofday,timeofday,c_white,1,c_white,0,_size,_size)) {
                                timeofday = !timeofday;
                                
                            }
                        } else timeofday = 0;

                        }
                    
                    
                    
                    //imgui_text($"Space {index}\n---------\nX:{x} Y:{y} Z:{z}\nType: {type}\nPath: {path}");
                    
                    //if imgui_image_button("2D3D",		d_spu_bdedit_viewtype,obv_3dcam.is_orthographic,c_white,1,c_white,0,_size,_size) obv_3dcam.is_orthographic = !obv_3dcam.is_orthographic;
        
                    imgui_pop_style_color(3);
                    imgui_pop_style_var(2);
                
                    
                }
                imgui_end_child();
                imgui_sameline();
                if (imgui_begin_child($"viewport_view_container")) {
                    if (imgui_begin_child($"toolprop",,,ImGuiChildFlags.AutoResizeY)) {
                        if (!picturemode) switch (tool) {
                            case 0:
                                
                                imgui_text("Tool: Mover"); //imgui_sameline();
                                //imgui_set_next_item_width(128);
                                //imgui_input_intn("Grid Size", placer_gridsize);
                            break;
                            case BTOOL_PLACER:
                                imgui_text("Tool: Placer");
                                //imgui_set_next_item_width(128);
                                //imgui_input_intn("Grid Size", placer_gridsize);
                            break;
                            case BTOOL_ERASER:
                                imgui_text("Tool: Eraser");
                            break;
                            case BTOOL_RESPACER:
                                imgui_text("Tool: Linker"); //imgui_sameline();
                                //imgui_text_disabled("Respacer Behaviour"); imgui_sameline();
                                //if (imgui_begin_combo($"###toolprop_respacer_behaviour","IDK lol",ImGuiComboFlags.WidthFitPreview)) {
                                    //imgui_selectable($"Add to a New Path Rule###toolprop_respacer_behaviour_new");
                                    //imgui_selectable($"Append to Selected Rule###toolprop_respacer_behaviour_add");
                                    //imgui_selectable($"Override Existing Rule###toolprop_respacer_behaviour_override");
                                    //imgui_end_combo();
                                //} imgui_sameline();
                            //
                                //imgui_input_int($"Selected Rule:###toolprop_respacer_selectedrule{id}",0,1); imgui_sameline();
                            
                                //imgui_button($"Clear Paths on Selected Spaces###toolprop_respacer_clearselected");
                            break;
                            case BTOOL_RESPACER_CONT:
                                imgui_text("Tool: Continuous Linker")
                            break;
                            case BTOOL_RESPACER_ERASER:
                                imgui_text("Tool: Unlinker")
                            break;
                        } else {
                            imgui_text("Camera Settings");
                            imgui_sameline();
                            if (imgui_button("Take Snapshot###toolprop_snapshot")) {
                                var _fname = filename_remove_extension(context.name);
                                var _file = get_save_filename("Image File (.png)|*.png", $"{_fname}.png");
                                if (_file != undefined) && (_file != "") && (is_string(_file)) && (string_length(_file) > 0) {
                                    surface_save(snapshot_surf, _file);
                                }
                            }
                        }
                        imgui_end_child();
                    }
                        
                    
                    var _flags = ImGuiWindowFlags.HorizontalScrollbar;
                    if (imgui_begin_child($"viewport_surf",undefined,undefined,undefined,_flags)) {
                        if (instance_exists(obv_3dcam)) {
                            var _cam = obv_3dcam;
                            surf_w = _cam.res_width;
                            surf_h = _cam.res_height;
                            surf_x = imgui_get_cursor_screen_pos_x();
                            surf_y = imgui_get_cursor_screen_pos_y();
                            
                            surf_sx = imgui_get_scroll_x();
                            surf_sy = imgui_get_scroll_y();
                            
                            _cam.res_width = imgui_get_content_region_avail_x();
                            _cam.res_height = imgui_get_content_region_avail_y();
                            _cam.x = imgui_get_scroll_x()/zoom;
                            _cam.y = imgui_get_scroll_y()/zoom;
                            _cam.ortho_zoom = zoom;
                            
                            if (_cam.is_orthographic) {
                                if (true) {
                                    if (keyboard_check(vk_control) && mouse_wheel_down()) {
                                        zoom = clamp(zoom-0.1, 0.1, 2);
                                        
                                    }
                                    if (keyboard_check(vk_control) && mouse_wheel_up()) {
                                        zoom = clamp(zoom+0.1, 0.1, 2);
                                    }
                                    with (_cam) {
                                        //if (keyboard_check(ord("A"))) {
                                            //_cam.x -= spd*sy.dt;
                                        //}
                                        //if (keyboard_check(ord("D"))) {
                                            //_cam.x += spd*sy.dt;
                                        //}
                                        //if (keyboard_check(ord("W"))) {
                                            //_cam.y -= spd*sy.dt;
                                        //}
                                        //if (keyboard_check(ord("S"))) {
                                            //_cam.y += spd*sy.dt;
                                        //}
                                        //if (keyboard_check(ord("Q"))) {
                                            //_cam.ortho_zoom+=.1;
                                        //}
                                        //if (keyboard_check(ord("E"))) {
                                            //_cam.ortho_zoom-=.1;
                                        //}
                                    }
                                    __interaction_handler();
                                    
                                    //imgui_set_scroll_x(_cam.x);
                                    //imgui_set_scroll_y(_cam.y);
                                }
                            }

                            if (surface_exists(_cam.output)) && (rpk_get_node_type(context) == NODE_PJ_BOARD) {
                                var _max_w = context.width;
                                var _max_h = context.height;    
                            
                                imgui_set_cursor_pos(_max_w * zoom - imgui_calc_text_width(" ") + (_cam.res_width),
                                    _max_h * zoom - imgui_get_text_line_height() + (_cam.res_height));
                                imgui_text(" ");
                                //imgui_set_cursor_pos(-_cam.res_width/2,-_cam.res_height/2);
                                //imgui_text("A");
                                imgui_set_cursor_pos(imgui_get_scroll_x(),imgui_get_scroll_y());
                                var _curx = imgui_get_scroll_x();
                                var _cury = imgui_get_scroll_y();
                                imgui_surface(_cam.output,,,_cam.res_width,_cam.res_height);

                                
                                //if (imgui_is_window_focused(ImGuiFocusedFlags.RootAndChildWindows)) {
                                    var _mx = (window_mouse_get_x() - surf_x - surf_w/2) / zoom;
                                    var _my = (window_mouse_get_y() - surf_y - surf_h/2) / zoom;
                                    imgui_set_scroll_x(_cam.x*zoom);
                                    imgui_set_scroll_y(_cam.y*zoom);
                                    xpos = _mx;//;+ _scx;
                                    ypos = _my;// + _scy;
                            
                                    //#region 2D and 3D Camera Control
                                    //if (_cam.is_orthographic) {
        //
                                    //} else {
                                        //if (_cam.view_mat != undefined) && (_cam.proj_mat != undefined) {
                                            //var _smx = _mx - surf_x;
                                            //var _smy = _my - surf_y;
                                            //var _smh = _smx / surf_w;
                                            //var _smv = 1 - _smy / surf_h;
                                //
                                            //var v = cm_2d_to_3d(_cam.view_mat, _cam.proj_mat, _smh, _smv);
                                            //ray = cm_cast_ray(global.col_mesh, cm_ray(_cam.x, _cam.y, _cam.z, _cam.x + v[0] * 3000, _cam.y + v[1] * 3000, _cam.z + v[2] * 3000));
                                            //target = cm_ray_get_hit_object(ray);
                                            //hit = cm_ray_get_hit(ray);
                                            //xpos = cm_ray_get_x(ray);
                                            //ypos = cm_ray_get_y(ray);
                                            //zpos = cm_ray_get_z(ray);
                                        //}
                        //
                                        //if (hit) && is_array(target) {
                                            //var _inst = array_last(target);
        //
                                            //if (mouse_check_button_pressed(mb_left)) {
                                                //__selection_handler(_inst.host);
                                            //}
                                        //}
                            //
                                        //if (mouse_check_button(mb_right)) {
                                            //_cam.look_dir -= (_mx - _scx)/10;
                                            //_cam.look_pitch += (_my - _scy)/10;
                                            //_cam.look_pitch = clamp(_cam.look_pitch,-90,90);
                                            //window_mouse_set(_scx,_scy);
                                        //}
                //
                                        //with (_cam) {
                                            //spd = (clamp(spd+(mouse_wheel_up()-mouse_wheel_down()),0,20));
        //
                                            //if (keyboard_check(ord("A"))) {
                                                //x -= dsin(look_dir)*spd*sy.dt;
                                                //y -= dcos(look_dir)*spd*sy.dt;
                                            //}
                                            //if (keyboard_check(ord("D"))) {
                                                //x += dsin(look_dir)*spd*sy.dt;
                                                //y += dcos(look_dir)*spd*sy.dt;
                                            //}
                                            //if (keyboard_check(ord("W"))) {
                                                //x += dcos(look_dir)*spd*sy.dt;
                                                //y -= dsin(look_dir)*spd*sy.dt;
                                            //}
                                            //if (keyboard_check(ord("S"))) {
                                                //x -= dcos(look_dir)*spd*sy.dt;
                                                //y += dsin(look_dir)*spd*sy.dt;
                                            //}
                                            //z += (keyboard_check(ord("E")) - keyboard_check(ord("Q")))*spd*sy.dt;
                                        //}
                                    //}
                                    //#endregion
                                    //xpos = surf_mx * _cam.ortho_zoom + _cam.x;
                                    //ypos = surf_my * _cam.ortho_zoom + _cam.y;
                                    //__interaction_handler();
                                //} else {
                                //	selbox_holding = 0;
                                //	selbox_dragging = 0;
                                //}
                            }
                        }
                        
                    }
                    imgui_end_child();
                    
                }	
                imgui_end_child();
            
                break;
                case "d_scn_mdlviewer":
                if (imgui_begin_child($"viewport_surf{id}")) {
                    if (instance_exists(obv_3dcam)) {
                        var _cam = obv_3dcam
                        surf_w = imgui_get_content_region_avail_x();
                        surf_h = imgui_get_content_region_avail_y();
                        surf_x = imgui_get_cursor_screen_pos_x();
                        surf_y = imgui_get_cursor_screen_pos_y();
                        surf_mx = surf_x + surf_w/2;
                        surf_my = surf_y + surf_h/2;
                        _cam.res_width = surf_w;
                        _cam.res_height = surf_h;
                        
                        if (surface_exists(_cam.output)) {
                            imgui_surface(_cam.output, c_white, 1, surf_w, surf_h);
                            if (imgui_is_window_focused(ImGuiFocusedFlags.RootAndChildWindows)) {
                                var _mx = window_mouse_get_x();
                                var _my = window_mouse_get_y();
                                
                                
                    
                                #region 2D and 3D Camera Control
                                if (_cam.is_orthographic) {
    
                                    with (_cam) {
                                        if (keyboard_check(ord("A"))) {
                                            x -= spd*sy.dt;
                                        }
                                        if (keyboard_check(ord("D"))) {
                                            x += spd*sy.dt;
                                        }
                                        if (keyboard_check(ord("W"))) {
                                            y -= spd*sy.dt;
                                        }
                                        if (keyboard_check(ord("S"))) {
                                            y += spd*sy.dt;
                                        }
                                    }
                                } else {
                                    //if (_cam.view_mat != undefined) && (_cam.proj_mat != undefined) {
                                        //var _smx = _mx - surf_x;
                                        //var _smy = _my - surf_y;
                                        //var _smh = _smx / surf_w;
                                        //var _smv = 1 - _smy / surf_h;
                            //
                                        //var v = cm_2d_to_3d(_cam.view_mat, _cam.proj_mat, _smh, _smv);
                                        //ray = cm_cast_ray(global.col_mesh, cm_ray(_cam.x, _cam.y, _cam.z, _cam.x + v[0] * 3000, _cam.y + v[1] * 3000, _cam.z + v[2] * 3000));
                                        //target = cm_ray_get_hit_object(ray);
                                        //hit = cm_ray_get_hit(ray);
                                        //xpos = cm_ray_get_x(ray);
                                        //ypos = cm_ray_get_y(ray);
                                        //zpos = cm_ray_get_z(ray);
                                    //}
                    
                                    if (hit) && is_array(target) {
                                        var _inst = array_last(target);
                                        if (mouse_check_button_pressed(mb_left)) {
                                            __selection_handler(_inst.host);
                                        }
                                    }
                        
                                    if (mouse_check_button(mb_right)) {
                                        var _deltadir = (_mx - surf_mx)/10;
                                        var _deltapitch = (_my - surf_my)/10;
                                        _deltadir = abs(_deltadir) < .1 ? 0 : _deltadir;
                                        _deltapitch = abs(_deltapitch) < .1 ? 0 : _deltapitch;
                                        _cam.look_dir -= _deltadir;
                                        _cam.look_pitch += _deltapitch;
                                        _cam.look_pitch = clamp(_cam.look_pitch,-90,90);
                                        window_mouse_set(surf_mx,surf_my);
                                    }
            
                                    with (_cam) {
                                        spd = (clamp(spd+(mouse_wheel_up()-mouse_wheel_down()),0,20));
                                        if (keyboard_check(ord("A"))) {
                                            x -= dsin(look_dir)*spd*sy.dt;
                                            y -= dcos(look_dir)*spd*sy.dt;
                                        }
                                        if (keyboard_check(ord("D"))) {
                                            x += dsin(look_dir)*spd*sy.dt;
                                            y += dcos(look_dir)*spd*sy.dt;
                                        }
                                        if (keyboard_check(ord("W"))) {
                                            x += dcos(look_dir)*spd*sy.dt;
                                            y -= dsin(look_dir)*spd*sy.dt;
                                        }
                                        if (keyboard_check(ord("S"))) {
                                            x -= dcos(look_dir)*spd*sy.dt;
                                            y += dsin(look_dir)*spd*sy.dt;
                                        }
                                        z += (keyboard_check(ord("E")) - keyboard_check(ord("Q")))*spd*sy.dt;
                                    }
                                }
                                #endregion
                                __interaction_handler();
                            }
                        }
                    }
                    imgui_end_child();
                }
                break;
            }
        } 
        imgui_end();
        
        
        
        #endregion
        

        #endregion
        
        
        
        #region Mover Code
        //var _mx = window_mouse_get_x();
        //var _my = window_mouse_get_y();
        
        //if (mouse_check_button_released(mb_left)) {
        //	if (instance_exists(hover)) {
        //		hover.mdl.collidable = true;
        //	}
        //}
        
        //if (_mx > surf_x) && (_mx < surf_x + surf_w) && (_my > surf_y) && (_my < surf_y + surf_h) {
        //	var _smx = _mx - surf_x;
        //	var _smy = _my - surf_y;
        //	var _smh = _smx / surf_w;
        //	var _smv = 1 - _smy / surf_h;
            
        //	if (instance_exists(obv_3dcam)) {
        //		//print("GUH");
        //		var _cam = obv_3dcam
        //		if (_cam.view_mat != undefined) && (_cam.proj_mat != undefined) {
        //			var v = cm_2d_to_3d(_cam.view_mat, _cam.proj_mat, _smh, _smv);
        //			ray = cm_cast_ray(global.col_mesh, cm_ray(_cam.x, _cam.y, _cam.z, _cam.x + v[0] * 3000, _cam.y + v[1] * 3000, _cam.z + v[2] * 3000));
        //			target = cm_ray_get_hit_object(ray);
        //			hit = cm_ray_get_hit(ray);
        //		}
        //	}
            
            
        //	if (mouse_check_button(mb_left)) {
        //		//print("HOLD");
        //		if (instance_exists(hover)) {
        //			hover.mdl.collidable = false;
        //			hover.x = cm_ray_get_x(ray);
        //			hover.y = cm_ray_get_y(ray);
        //			hover.z = cm_ray_get_z(ray);
        //			hover.mdl.Update();
        //			//print("GUH");
        //		}
        //	} else {
        //		if (hit) && (is_array(target)) {
        //			if (instance_exists((array_last(target)))) {
        //				if (array_last(target) != hover) && (instance_exists(hover)) {
        //					hover.mdl.col = false;
        //				}
        //				hover = array_last(target);
        //				hover.mdl.col = true;
        //			} else if (hover != noone) {
        //				hover.mdl.col = false;
        //				hover = noone;
        //			}
        //		} else if (hover != noone) {
        //			hover.mdl.col = false;
        //			hover = noone;
        //		}
        //	}
        //}
        #endregion
        
        
        //imgui_dock_space_over_viewport();
        //imgui_show_demo_window(true);
        
        //if (board_data.general.bg_type) && (sprite_exists(board_data.general.spr_bg)) {
        //	layer_background_sprite(layer_background_get_id(layer_get_id("Background")),board_data.general.spr_bg);
        //}
        
        if (mouse_check_button_released(mb_left)) {
            holding = false;
        }
        
        if (is_struct(context)) && (array_length(undo_stack)) {
            var _umem = context[$ "undo_memory"];
            if (is_array(_umem)) {
                while (array_length(_umem) > undo_maxsteps) {
                    array_delete(_umem, 0, 1);
                }
                array_push(_umem,undo_stack);
            }
        }
        undo_stack = [];












if (modal_exit) {
    imgui_open_popup("###modal_exit");
}

if (modal_unload_nw) {
    imgui_open_popup("###modal_unload_nw");
}

if (modal_load_nw) {
    imgui_open_popup("###modal_load_nw");
}

if (modal_save) {
    imgui_open_popup("###modal_save");
}

if (_new_modal) {
    imgui_open_popup("###modal_new");
}

if (modal_loading) {
    imgui_open_popup("###modal_loading");
}
if (modal_zip_saving) {
    imgui_open_popup("###modal_zip_saving");
}
if (modal_zip_saved) {
    imgui_open_popup("###modal_zip_saved");
}
if (modal_eventsel) {
    imgui_open_popup("###modal_eventsel");
}
//
if (modal_rename) {
    imgui_open_popup("###modal_rename");
}
if (modal_about) {
    imgui_open_popup("###modal_about");
}
if (ui_show_style_editor) {
    imgui_show_style_editor();
}
if (ui_show_nav_tips) {
    imgui_show_user_guide();
}
if (popup_delete) {
    imgui_open_popup("popup_delete");
}


ImGui.__EndFrame();

if (context == noone) && (room != d_scn_main) {
    room_goto(d_scn_main);
}