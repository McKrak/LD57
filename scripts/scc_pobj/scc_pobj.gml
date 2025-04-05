#macro CPROP_FLOAT		"CPROP_FLOAT"
#macro CPROP_STRING     "CPROP_STRING"
#macro CPROP_SPACEID    "CPROP_SPACEID"
#macro CPROP_OBJID      "CPROP_OBJID"
#macro CPROP_PIPETYPE   "CPROP_PIPETYPE"
#macro CPROP_BANKSPR    "CPROP_BANKSPR"
#macro CPROP_INT        "CPROP_INT"
#macro CPROP_BOOL       "CPROP_BOOL"
#macro CPROP_GATECOLOR  "CPROP_GATECOLOR"

function pjobject(_path = "") : node() constructor {	
	type = NODE_PJ_OBJECT;
	path = _path;
	name = "";
    use_extension = false;
	x = 0;
	y = 0;
	z = 0;
	xscale = 64;
	yscale = 64;
	zscale = 0;
	xorig = .5;
	yorig = .5;
	angle = 0;
	variant = 0;
	cprop = {};
	
	object_type = "none";
	
	
	
	mdl = noone;
	inst = noone;
	
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
			object_type: buffer_string,
			cprop: buffer_struct
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
            object_type: buffer_string,
            cprop: buffer_struct
        }
	}
	
	static add_instance = function() {
		var _host = self;
		var _spr = asset_get_index($"d_spi_pj_{object_type}");
		if (_spr == -1) {
			_spr = d_spi_pj_none;
		}
		
		//var _x = x - (xorig * (xscale));
		//var _y = y - (yorig * (yscale));
		var _xs = xscale/sprite_get_width(_spr);
		var _ys = yscale/sprite_get_height(_spr);
		var _angle = radtodeg(-angle);
		var _img = 0;
		if (object_type = "pipespr") {
			_img = cprop[$ "pipeType"][$ "value"];
		}
		//print($"{_spr}: {_x},{_y},{z}");
		inst = instance_create_depth(x,y,0,d_obi_pj_obj,{
			host: _host,	
			sprite_index: _spr,
			image_xscale: _xs,
			image_yscale: _ys,
			image_angle: _angle,
			image_index: _img
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
							//inst.mdl.layer = inst.layer;
						}
					} else {
						if (inst.layer != layer_get_id("Grid")) {
							inst.layer = layer_get_id("Grid");
							//inst.mdl.layer = inst.layer;
						}
					}
					var _spr = asset_get_index($"d_spi_pj_{object_type}");
					if (_spr == -1) {
						_spr = d_spi_pj_none;
					}
					inst.sprite_index = _spr;
				
					//var _x = x - (xorig * (xscale));
					//var _y = y - (yorig * (yscale));
					var _xs = xscale/sprite_get_width(_spr);
					var _ys = yscale/sprite_get_height(_spr);
				
					inst.x = x;//_x;
					inst.y = y;//_y;
					inst.image_xscale = _xs;
					inst.image_yscale = _ys;
					inst.image_angle = radtodeg(-angle);
                    switch(object_type) {
                        case "pipespr": inst.image_index = get_token(cprop, "pipeType.value"); break; 
                        case "enginedoor": inst.image_index = get_token(cprop, "gateColor.value"); break;
                        case "bankspr": inst.image_index = get_token(cprop, "showCounterOnly.value") == 3; break;
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
                if (imgui_menu_item($"Delete###nodelist_{path}_context_delete", "Del")) {
                    remove();
                }
                imgui_end_popup();
            }
            
            var _img = asset_get_index($"d_spi_pj_{object_type}");
            if (_img == -1) _img = d_spi_pj_none;
            
            if (imgui_begin_drag_drop_source(ImGuiDragDropFlags.None)) {
                imgui_set_drag_drop_payload(type,self,ImGuiCond.None);
                imgui_image(real(_img),variant,,,30,30);
                imgui_sameline(); imgui_text($"{name}");
                imgui_end_drag_drop_source();
            }
				
			
			imgui_sameline(); imgui_image(real(_img),0,,,32,32);
			imgui_sameline(); imgui_text($"{name}");
            imgui_sameline(); imgui_text_disabled("(" + loc(d_sy.lang, $"itemsel.pj.objects.{object_type}.name") + ")");
				
			imgui_tree_pop();
		}
	}
	
    static populate_nodeprop = function() { 
        imgui_separator_text("Object Type");
        imgui_text(loc(d_sy.lang, $"itemsel.pj.objects.{object_type}.name"));
        
        #region Transofmration
        imgui_separator_text("Placement");
        imgui_text_disabled("X Position");
        prop_add("x",function() {return imgui_drag_float($"###nodeprop_space_position_x{path}",x);}, true, true); 
        imgui_text_disabled("Y Position");
        prop_add("y",function() {return imgui_drag_float($"###nodeprop_space_position_y{path}",y);}, true, true); 
        imgui_text_disabled("X Scale");
        prop_add("xscale",function() {return imgui_drag_float($"###nodeprop_space_xscale{path}",xscale);}, true, true); 
        imgui_text_disabled("Y Scale");
        prop_add("yscale",function() {return imgui_drag_float($"###nodeprop_space_yscale{path}",yscale);}, true, true); 
        imgui_text_disabled("Angle");
        prop_add("angle",function() {return imgui_drag_float($"###nodeprop_space_angle{path}",angle,1/pi/10);}, true, true); 
        #endregion
        
        imgui_separator_text("Object Properties");
        var _names = struct_get_names(cprop);
        for (var i = 0; i < array_length(_names); i++) {
            var _cprop = cprop[$ _names[i]];
            switch (_cprop.type) {
                case CPROP_SPACEID:
                    _cprop.value = imgui_input_text(_names[i],_cprop.value);
                break;
                case CPROP_OBJID:
                    _cprop.value = imgui_input_text(_names[i],_cprop.value);
                break;
                case CPROP_INT:
                    _cprop.value = imgui_input_int(_names[i],_cprop.value);
                break;
                case CPROP_BOOL:
                    _cprop.value = imgui_checkbox(_names[i],_cprop.value);
                break;
                case CPROP_PIPETYPE:
                    //if imgui_radio_button("Disabled###nodeprop_cprop_pipetype_0", _cprop.value == 0) {
                        //_cprop.value = 0;
                        //refresh();
                    //}
                    if imgui_radio_button("Green###nodeprop_cprop_pipetype_1", _cprop.value == 1) {
                        _cprop.value = 1;
                        refresh();
                    }
                    if imgui_radio_button("Red###nodeprop_cprop_pipetype_2", _cprop.value == 2) {
                        _cprop.value = 2;
                        refresh();
                    }
                break;
                case CPROP_BANKSPR:
                    if (imgui_checkbox("Show Counter Only", _cprop.value == 3)) {
                        if (imgui_is_item_clicked()) {
                            _cprop.value = 0;
                            refresh();
                        }
                    } else {
                        if (imgui_is_item_clicked()) {
                            _cprop.value = 3;
                            refresh();
                        }
                    }
                break;
                case CPROP_GATECOLOR:
                    if imgui_radio_button("Blue###nodeprop_cprop_gatecolor_0", _cprop.value == 0) {
                        _cprop.value = 0;
                        refresh();
                    }
                    if imgui_radio_button("Red###nodeprop_cprop_gatecolor_1", _cprop.value == 1) {
                        _cprop.value = 1;
                        refresh();
                    }
                break;
            }
        }
        
        
    }
    
	//ELEPHANT_POST_READ_METHOD {
	//	refresh();
	//}
}

