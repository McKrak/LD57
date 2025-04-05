hover = false;
sel = false;
z = depth;
dest = [];

var _do_draw = false;
if (instance_exists(obv_3dcam)) {
	_do_draw = !obv_3dcam.is_orthographic;
}

//vertex_format_begin();
//vertex_format_add_position_3d();
//vertex_format_add_texcoord();
//form = vertex_format_end();

//var _self = self;
//mdl = instance_create_depth(x,y,z,obr_mesh,{
	//z: z,
	//model: "BoardData/commonobj/space",
	//texture: d_spm_bspace_pj,
	//pattern: host.space_type,
	//collidable: true,
	//host: _self,
	//col_group: CM_GROUP_TRIGGER,
	//cast_shadow: false,
	//layer: layer_get_id("Instances"),
	//do_draw: _do_draw,
	////layer: layer,
	////host: self.id,
	////use_global_ambience: false,
	////amb_color: 65280,
//});

