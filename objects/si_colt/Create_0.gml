#macro COLSHAPE_MESH 0
#macro COLSHAPE_SPHERE 1

//collisionConfiguration = btDefaultCollisionConfiguration_create();
//dispatcher = btCollisionDispatcher_create(collisionConfiguration);
//overlappingPairCache = btDbvtBroadphase_create();
//solver = btSequentialImpulseConstraintSolver_create();
//dynamicsWorld = btDiscreteDynamicsWorld_create(dispatcher, overlappingPairCache, solver, collisionConfiguration);
//btDiscreteDynamicsWorld_setGravityXYZ(dynamicsWorld, 0, 0, -160);

//debugDraw = btDebugDrawInMemory_create();
//var _debugDrawMode = btDebugDrawModes.DBG_DrawWireframe
//	| btDebugDrawModes.DBG_DrawContactPoints
//	| btDebugDrawModes.DBG_DrawNormals;
//btIDebugDraw_setDebugMode(debugDraw, _debugDrawMode);
//btCollisionWorld_setDebugDrawer(dynamicsWorld, debugDraw);

//debugDrawBuffer = buffer_create(1, buffer_grow, 1);

//global.stride = buffer_sizeof(buffer_f32) * 3
//	+ buffer_sizeof(buffer_f32) * 3
//	+ buffer_sizeof(buffer_u32)
//	+ buffer_sizeof(buffer_f32) * 2
//	+ buffer_sizeof(buffer_u32)
//	+ buffer_sizeof(buffer_u32);
	
global.col_mesh = cm_octree(100);