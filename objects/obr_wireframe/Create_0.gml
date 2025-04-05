//vertex_format_begin();
//vertex_format_add_position_3d();
//vertex_format_add_normal();
//vertex_format_add_color();
//vertex_format_add_texcoord();
//Vertex_Format = vertex_format_end();

Texture		= -1;
WorldMat	= matrix_build_identity();

vbuff		= vertex_create_buffer();
vertices	= ds_list_create();
rebuild		= false;

function Reset() {
	ds_list_clear(vertices);
	rebuild	= true;
}
function AddLine(_vertex1, _vertex2) {
	ds_list_add(vertices, _vertex1, _vertex2);
	rebuild = true;
}
function AddTriangle(_vertex1, _vertex2, _vertex3) {
	AddLine(_vertex1, _vertex2);
	AddLine(_vertex2, _vertex3);
	AddLine(_vertex3, _vertex1);
}
function AddQuad(_vertex1, _vertex2, _vertex3, _vertex4) {
	AddLine(_vertex1, _vertex2);
	AddLine(_vertex2, _vertex3);
	AddLine(_vertex3, _vertex4);
	AddLine(_vertex4, _vertex1);
}
function Draw() {
	if (rebuild) build();
		
	matrix_set(matrix_world, WorldMat);
	vertex_submit(vbuff, pr_linelist, Texture);
}

function build() {
	rebuild = false;
		
	vertex_delete_buffer(vbuff);
	vbuff = vertex_create_buffer();
		
	vertex_begin(vbuff, Vertex_Format);
	var _count = ds_list_size(vertices);
	for (var i = 0; i < _count; ++i) {
		vertices[|i].ToBuffer(vbuff);
	}
	vertex_end(vbuff);
	vertex_freeze(vbuff);
}