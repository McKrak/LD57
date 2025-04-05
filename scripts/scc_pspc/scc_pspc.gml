function pjspace(_path = "") : node() constructor {	
	type = NODE_PJ_SPACE;
	path = _path;
	name = "";
    use_extension = false;
    
	x = 0;
	y = 0;
	xscale = 64;
	yscale = 64;
	angle = 0;
	xorig = .5;
	yorig = .5;
	index = 0;
	event_param = "";
	space_type = 0;
	dest = ["", "", "", ""];
	host = noone;
    space_event = "";
    
    mdl = noone;
    inst = noone;
	
	static add_instance = function() {
		var _host = self;
		
		//var _x = x - (xorig * (xscale));
		//var _y = y - (yorig * (yscale));
		var _xs = xscale/sprite_get_width(d_spm_bspace_pj);
		var _ys = yscale/sprite_get_height(d_spm_bspace_pj);
		var _angle = radtodeg(-angle);
		
		inst = instance_create_layer(x,y,"Grid",d_obi_boardspace,{
			host: _host,	
			image_index: space_type,
			image_xscale: _xs,
			image_yscale: _ys,
			image_angle: _angle,
		});
	}
	
    
    static toggle = function(_sel = undefined) {
        if _sel == undefined sel = !sel else sel = _sel;
        
        if (instance_exists(d_sy)) {
            if (sel) {
                if (!array_contains(d_sy.selected,self)) {
                    array_push(d_sy.selected,self);
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
        refresh();
    }
    
	static refresh = function() {
		if (instance_exists(d_sy)) {
            var _host = rpk_get_node(path, 1);
			if (room == d_scn_bdedit) && (d_sy.context == _host) {
				if (!instance_exists(inst)) add_instance();
                    
                if (instance_exists(inst)) {
					if (sel) {
						if (inst.layer != layer_get_id("Selected")) {
							inst.layer = layer_get_id("Selected");
						}
					} else {
						if (inst.layer != layer_get_id("Grid")) {
							inst.layer = layer_get_id("Grid");
						}
					}
					inst.x = x;
					inst.y = y;
					inst.image_xscale = xscale/sprite_get_width(d_spm_bspace_pj);
					inst.image_yscale = yscale/sprite_get_height(d_spm_bspace_pj);
					inst.image_angle = radtodeg(-angle);
					inst.image_index = space_type;
                    inst.dest = [];
                    for (var i = 0; i < array_length(dest); i++) {
                        var _target = rpk_content_search(_host.content, dest[i], "name");
                        if (is_struct(_target)) {
                            if (_target[$ "type"] == NODE_PJ_SPACE) {
                                inst.dest[i] = _target;
                            }
                        }
                    }
				}
			} else if (instance_exists(inst)) instance_destroy(inst);
		}
	}
    
    static remove = function() {
        toggle(false);
        if (instance_exists(inst)) instance_destroy(inst);
        var _host = rpk_get_node(path,1);
        if (_host != undefined) {
            if (_host[$ "content"] != undefined) {
                for (var i = 0; i < array_length(_host.content); i++) {
                    var _inst = _host.content[i];
                    if (_inst = self) {
                        array_delete(_host.content,i,1);
                        break;
                    }
                }
            }
        }
    }
    
    static populate_nodetree = function(_index = 0) {
        
        if (instance_exists(d_sy)) {
            var _treenode_flags_sel = 
            ImGuiTreeNodeFlags.OpenOnArrow|
            ImGuiTreeNodeFlags.SpanAvailWidth|
            ImGuiTreeNodeFlags.FramePadding|
            ImGuiTreeNodeFlags.Leaf;
            if (sel) _treenode_flags_sel |= ImGuiTreeNodeFlags.Selected;
            

            var _node = imgui_tree_node_ex($"###nodelist_{path}",_treenode_flags_sel);
            if (imgui_is_item_clicked(ImGuiMouseButton.Left) && !imgui_is_item_toggled_open()) {
                d_sy.__selection_handler(self);
            }
            if (imgui_begin_drag_drop_target()) {
                var _payload = imgui_accept_drag_drop_payload(NODE_PJ_SPACE,ImGuiDragDropFlags.None);
                if (_payload != undefined) {
                    swap(_payload);
                } else {
                    _payload = imgui_accept_drag_drop_payload(NODE_PJ_OBJECT,ImGuiDragDropFlags.None);
                    if (_payload != undefined) {
                        swap(_payload);
                    }
                }
                imgui_end_drag_drop_target();
            }
            
            
            if (imgui_begin_popup_context_item($"nodelist_{path}_context")) {
                imgui_text_disabled(path);
                imgui_separator();
                if (imgui_menu_item($"Delete###nodelist_rpk_{path}_context_delete", "Del")) {
                    remove();
                }
                imgui_end_popup();
            }
            
            if (imgui_begin_drag_drop_source(ImGuiDragDropFlags.None)) {
                imgui_set_drag_drop_payload(type,self,ImGuiCond.None);
                imgui_image(d_spm_bspace_pj,space_type,,,30,30);
                imgui_sameline(); imgui_text($"{name}");
                imgui_end_drag_drop_source();
            }
                
            imgui_sameline(); imgui_image(d_spm_bspace_pj,space_type,,,30,30);
            imgui_sameline(); imgui_text($"{name}");
                
            imgui_tree_pop();
        }
    }
    
    static __change_handler = function(_liveupdate = false) {
        var _dorefresh = false;
        if _liveupdate _dorefresh = imgui_is_item_edited();
        else _dorefresh = imgui_is_item_deactivated_after_edit();    
        if (_dorefresh) refresh();
    }
    
    static populate_nodeprop = function() {
        #region Transofmration
        imgui_separator_text("Position");
        imgui_text_disabled("X Position");
        prop_add("x",function() {return imgui_drag_float($"###nodeprop_space_position_x{path}",x);}, true, true); 
        //undostack_record();
        imgui_text_disabled("Y Position");
        prop_add("y",function() {return imgui_drag_float($"###nodeprop_space_position_y{path}",y);}, true, true); 
        //imgui_text_disabled("X Scale");
        //prop_add("xscale",function() {return imgui_drag_float($"###nodeprop_space_xscale{path}",xscale);}, true, true); 
        //imgui_text_disabled("Y Scale");
        //prop_add("yscale",function() {return imgui_drag_float($"###nodeprop_space_yscale{path}",yscale);}, true, true); 
        imgui_text_disabled("Angle");
        prop_add("angle",function() {return imgui_drag_float($"###nodeprop_space_angle{path}",angle,pi/10);}, true, true); 
        imgui_spacing();
        
        
        #endregion
        
        imgui_separator_text("Space Settings");
        //imgui_text_disabled("Type");
        //prop_add("space_type", function() {return imgui_input_int($"###nodeprop_{path}_space_type",space_type,1);}, false, true);
        imgui_text_disabled("Event");
        prop_add("space_event", function() {return imgui_input_text($"###nodeprop_space_{path}_space_event",space_event);});
        imgui_sameline(); if (imgui_button($"...###nodeprop_space_{path}_space_event_selector")) {
            d_sy.modal_eventsel = true;
            d_sy.eventsel_item = space_event;
        }
        imgui_text_disabled("Event Parameter");
        prop_add("event_param", function() {return imgui_input_text($"###nodeprop_space_{path}_event_param",event_param);});
        //if (imgui_begin_drag_drop_target()) {
            //var _payload = imgui_accept_drag_drop_payload(NODE_PJ_OBJECT,ImGuiDragDropFlags.None);
            //if (_payload != undefined) {
                //for (var i = 0; i < array_length(d_sy.selected); i++) {
                    //d_sy.selected[i].event_param = _payload.name;
                //}
            //}
            //imgui_end_drag_drop_target();
        //}
//
        imgui_spacing();

        
        imgui_separator_text("Destination Data");

        for (var i = 0; i < array_length(dest); i++) {
            var _mixedval = false;
            for (var j = 0; j < array_length(d_sy.selected); j++) {
                if (d_sy.selected[j].dest[i] != dest[i]) {
                    _mixedval = true;
                    break;
                }
            }
            var _output = -1;
            if (_mixedval) {
                imgui_push_style_color(ImGuiCol.FrameBg,#b9a812,1);
                _output = imgui_input_text($"###nodeprop_dest_{i}",dest[i]);
                imgui_pop_style_color();
            } else {
                _output = imgui_input_text($"###nodeprop_dest_{i}",dest[i]);
            }
            if (imgui_is_item_deactivated_after_edit()) {
                for (var j = 0; j < array_length(d_sy.selected); j++) {
                    with (d_sy.selected[j]) {
                        dest[i] = _output;
                        refresh();
                    }
                }
            }
            
        }
    }
	
	ELEPHANT_SCHEMA {
		v1: {
			name: buffer_string,
			x: buffer_f64,
			y: buffer_f64,
			xscale: buffer_f64,
			yscale: buffer_f64,
			angle: buffer_f64,
			xorig: buffer_f64,
			yorig: buffer_f64,
			dest: buffer_array,
			space_type: buffer_u16,
			space_event: buffer_string,
			index: buffer_f16,
			event_param: buffer_f16,
		},
        v2: {
            name: buffer_string,
            x: buffer_f16,
            y: buffer_f16,
            xscale: buffer_f16,
            yscale: buffer_f16,
            angle: buffer_f16,
            xorig: buffer_f16,
            yorig: buffer_f16,
            dest: buffer_array,
            space_type: buffer_u16,
            space_event: buffer_string,
            event_param: buffer_string,
        }
	}

    ELEPHANT_POST_READ_METHOD {
        //rpk_link_hosts(self);
        if (ELEPHANT_SCHEMA_VERSION == 1) {
            for (var i = 0; i < array_length(dest); i++) {
                if (dest[i] != -1) {
                    //var _host = rpk_get_node(path, 1);
                    var _target = rpk_content_search(host.content, dest[i], "index");
                    if (is_struct(_target)) {
                        if (_target[$ "type"] == NODE_PJ_SPACE) {
                            dest[i] = _target.name;
                        }
                    }
                }
            }
        }
    }
}

