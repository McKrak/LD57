mat	= matrix_build_identity();

vbuff		= vertex_create_buffer();
vertices	= ds_list_create();
rebuild		= false;

function Reset() {
	ds_list_clear(vertices);
	rebuild	= true;
}
function AddTriangle(_vertex1, _vertex2, _vertex3) {
	ds_list_add(vertices, _vertex1, _vertex2, _vertex3);
	rebuild = true;
}
function AddQuad(_vertex1, _vertex2, _vertex3, _vertex4) {
	AddTriangle(_vertex1, _vertex2, _vertex3);
	AddTriangle(_vertex1, _vertex3, _vertex4);
}
function Draw() {
	if (rebuild) build();
	
	matrix_set(matrix_world, mat);
	vertex_submit(vbuff, pr_trianglelist, Texture);
}

function build() {
	static _normal		= new Vec3(0, 0, 0);
	static _vector12	= new Vec3(0, 0, 0);
	static _vector13	= new Vec3(0, 0, 0);
		
	rebuild	= false;
		
	vertex_delete_buffer(vbuff);
	vbuff = vertex_create_buffer();
			
	vertex_begin(vbuff, Vertex_Format);
	var _v1, _v2, _v3, _count = ds_list_size(vertices);
	for (var i = 0; i < _count; i += 3) {
		_v1 = vertices[|i];
		_v2 = vertices[|i+1];
		_v3 = vertices[|i+2];
				
		_vector12.FromTo(_v2.Position, _v1.Position);
		_vector13.FromTo(_v3.Position, _v1.Position);
		_normal.Cross(_vector13, _vector12);
		_normal.Normalize();
		
		_v1.ToBuffer(vbuff, _normal);
		_v2.ToBuffer(vbuff, _normal);
		_v3.ToBuffer(vbuff, _normal);
	}
	vertex_end(vbuff);
	vertex_freeze(vbuff);
}