vertex_delete_buffer(buff);

if (col_mesh != noone) {
	print("DEL COLMESH");
	//cm_remove(col_container,col_mesh);
	cm_remove(global.col_mesh,col_container);
	col_container = noone;
	col_mesh = noone;
}