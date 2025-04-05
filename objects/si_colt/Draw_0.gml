	//btCollisionWorld_debugDrawWorld(dynamicsWorld);
	//var _size = btDebugDrawInMemory_getSize(debugDraw);
	//if (_size > 0)
	//{
	//	if (buffer_get_size(debugDrawBuffer) < _size)
	//	{
	//		buffer_resize(debugDrawBuffer, _size);
	//	}
	//	btDebugDrawInMemory_toBuffer(debugDraw, debugDrawBuffer);
	//	buffer_set_used_size(debugDrawBuffer, _size);
	//	var _vbuffer = vertex_create_buffer_from_buffer(debugDrawBuffer, btGetDebugDrawVertexFormat());
	//	shader_set(btShDebugDraw);
	//	vertex_submit(_vbuffer, pr_linelist, -1);
	//	shader_reset();
	//	vertex_delete_buffer(_vbuffer);
	//}
	
//cm_debug_draw(global.col_mesh);