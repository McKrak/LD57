randomize();
alarm[0] = 30;

var _texture = sprite_get_texture(spm_grid,0);



#region Demo mesh

	meshRotationX	= 0;
	meshRotationY	= 0;
	meshRotationZ = 0;
	//for (var i = 0; i < 20; i++) {
	//	dupemesh[i]	= instance_create_layer(i*64,64,"Instances",obr_mesh,{
	//						model: "Check/untitled2",
	//						xscale: 50,
	//						yscale: 50,
	//						zscale: 50,
	//						tex_repeat: false,
	//						self_update: true,
	//					});
	//}
	mesh			= instance_create_layer(0,0,"Instances",obr_mesh,{
							//path: "Kahuna/Minigame/201/",
							model: "Check/Pants",
							xscale: 50,
							yscale: 50,
							zscale: 50,
							tex_repeat: false,
							
						});
	mesh2			= instance_create_layer(0,0,"Instances",obr_mesh,{
							//path: "Kahuna/Minigame/201/",
							model: "Check/stage",
							xscale: 100,
							yscale: 100,
							zscale: 100,
							xrot: 90,
						});
	//mesh			= instance_create_layer(x,y,"Instances",ob_Mesh,{
	//	Texture: _texture,
	//});
	#region Constructing demo mesh

		//var _planeSize  = 200,
		//	_posPlaneT1	= new Vec3(-_planeSize, 0, +_planeSize),
		//	_posPlaneT2	= new Vec3(+_planeSize, 0, +_planeSize),
		//	_posPlaneT3	= new Vec3(+_planeSize, 0, -_planeSize),
		//	_posPlaneT4	= new Vec3(-_planeSize, 0, -_planeSize),
		//	_posPlaneB1	= new Vec3(-_planeSize, 10, +_planeSize),
		//	_posPlaneB2	= new Vec3(+_planeSize, 10, +_planeSize),
		//	_posPlaneB3	= new Vec3(+_planeSize, 10, -_planeSize),
		//	_posPlaneB4	= new Vec3(-_planeSize, 10, -_planeSize),
		//	_uvPlane1	= new Vec2(0.51, 0.01),
		//	_uvPlane2	= new Vec2(0.99, 0.01),
		//	_uvPlane3	= new Vec2(0.99, 0.49),
		//	_uvPlane4	= new Vec2(0.51, 0.49);
	
		//var _boxSize	= 50,
		//	_posBoxB1	= new Vec3(-_boxSize, 0, +_boxSize),
		//	_posBoxB2	= new Vec3(+_boxSize, 0, +_boxSize),
		//	_posBoxB3	= new Vec3(+_boxSize, 0, -_boxSize),
		//	_posBoxB4	= new Vec3(-_boxSize, 0, -_boxSize),
		//	_posBoxM1	= new Vec3(-(_boxSize-2), -7, +(_boxSize-2)),
		//	_posBoxM2	= new Vec3(+(_boxSize-2), -7, +(_boxSize-2)),
		//	_posBoxM3	= new Vec3(+(_boxSize-2), -7, -(_boxSize-2)),
		//	_posBoxM4	= new Vec3(-(_boxSize-2), -7, -(_boxSize-2)),
		//	_posBoxT1	= new Vec3(-_boxSize, -_boxSize*2, +_boxSize),
		//	_posBoxT2	= new Vec3(+_boxSize, -_boxSize*2, +_boxSize),
		//	_posBoxT3	= new Vec3(+_boxSize, -_boxSize*2, -_boxSize),
		//	_posBoxT4	= new Vec3(-_boxSize, -_boxSize*2, -_boxSize),
		//	_uvBoxSide1	= new Vec2(0.01, 0.51),
		//	_uvBoxSide2	= new Vec2(0.49, 0.51),
		//	_uvBoxSide3	= new Vec2(0.49, 0.99),
		//	_uvBoxSide4	= new Vec2(0.01, 0.99),
		//	_uvBoxTop	= new Vec2(0.25, 0.50);
		
		//var _rootSize	= 20,
		//	_posRootB1	= new Vec3(0, -_boxSize*2, +_rootSize),
		//	_posRootB2	= new Vec3(+_rootSize, -_boxSize*2, 0),
		//	_posRootB3	= new Vec3(0, -_boxSize*2, -_rootSize),
		//	_posRootB4	= new Vec3(-_rootSize, -_boxSize*2, 0),
		//	_posRootT	= new Vec3(0, -_boxSize*2-_rootSize*2, 0),
		//	_uvRoot		= new Vec2(0.25, 0.50);
		
		//var _posTreeX1	= new Vec3(0, -_boxSize*4, -_boxSize),
		//	_posTreeX2	= new Vec3(0, -_boxSize*4, +_boxSize),
		//	_posTreeX3	= new Vec3(0, -_boxSize*2, +_boxSize),
		//	_posTreeX4	= new Vec3(0, -_boxSize*2, -_boxSize),
		//	_posTreeZ1	= new Vec3(-_boxSize, -_boxSize*4, 0),
		//	_posTreeZ2	= new Vec3(+_boxSize, -_boxSize*4, 0),
		//	_posTreeZ3	= new Vec3(+_boxSize, -_boxSize*2, 0),
		//	_posTreeZ4	= new Vec3(-_boxSize, -_boxSize*2, 0),
		//	_posTreeXZ1	= new Vec3(-_boxSize*0.71, -_boxSize*4, -_boxSize*0.71),
		//	_posTreeXZ2	= new Vec3(+_boxSize*0.71, -_boxSize*4, +_boxSize*0.71),
		//	_posTreeXZ3	= new Vec3(+_boxSize*0.71, -_boxSize*2, +_boxSize*0.71),
		//	_posTreeXZ4	= new Vec3(-_boxSize*0.71, -_boxSize*2, -_boxSize*0.71),
		//	_posTreeZX1	= new Vec3(-_boxSize*0.71, -_boxSize*4, +_boxSize*0.71),
		//	_posTreeZX2	= new Vec3(+_boxSize*0.71, -_boxSize*4, -_boxSize*0.71),
		//	_posTreeZX3	= new Vec3(+_boxSize*0.71, -_boxSize*2, -_boxSize*0.71),
		//	_posTreeZX4	= new Vec3(-_boxSize*0.71, -_boxSize*2, +_boxSize*0.71),
		//	_uvTree1	= new Vec2(0.01, 0.01),
		//	_uvTree2	= new Vec2(0.49, 0.01),
		//	_uvTree3	= new Vec2(0.49, 0.49),
		//	_uvTree4	= new Vec2(0.01, 0.49);

		//mesh.AddQuad(
		//	new Vertex(_posPlaneT1, _uvPlane1, c_white, 1.0),
		//	new Vertex(_posPlaneT2, _uvPlane2, c_white, 1.0),
		//	new Vertex(_posPlaneT3, _uvPlane3, c_white, 1.0),
		//	new Vertex(_posPlaneT4, _uvPlane4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posPlaneB4, _uvPlane1, c_white, 1.0),
		//	new Vertex(_posPlaneB3, _uvPlane2, c_white, 1.0),
		//	new Vertex(_posPlaneB2, _uvPlane3, c_white, 1.0),
		//	new Vertex(_posPlaneB1, _uvPlane4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posPlaneB1, _uvPlane1, c_white, 1.0),
		//	new Vertex(_posPlaneB2, _uvPlane2, c_white, 1.0),
		//	new Vertex(_posPlaneT2, _uvPlane2, c_white, 1.0),
		//	new Vertex(_posPlaneT1, _uvPlane1, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posPlaneB2, _uvPlane2, c_white, 1.0),
		//	new Vertex(_posPlaneB3, _uvPlane3, c_white, 1.0),
		//	new Vertex(_posPlaneT3, _uvPlane3, c_white, 1.0),
		//	new Vertex(_posPlaneT2, _uvPlane2, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posPlaneB3, _uvPlane3, c_white, 1.0),
		//	new Vertex(_posPlaneB4, _uvPlane4, c_white, 1.0),
		//	new Vertex(_posPlaneT4, _uvPlane4, c_white, 1.0),
		//	new Vertex(_posPlaneT3, _uvPlane3, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posPlaneB4, _uvPlane4, c_white, 1.0),
		//	new Vertex(_posPlaneB1, _uvPlane1, c_white, 1.0),
		//	new Vertex(_posPlaneT1, _uvPlane1, c_white, 1.0),
		//	new Vertex(_posPlaneT4, _uvPlane4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posBoxB1, _uvBoxSide1, c_white, 1.0),
		//	new Vertex(_posBoxB2, _uvBoxSide2, c_white, 1.0),
		//	new Vertex(_posBoxT2, _uvBoxSide3, c_white, 1.0),
		//	new Vertex(_posBoxT1, _uvBoxSide4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posBoxB2, _uvBoxSide1, c_white, 1.0),
		//	new Vertex(_posBoxB3, _uvBoxSide2, c_white, 1.0),
		//	new Vertex(_posBoxT3, _uvBoxSide3, c_white, 1.0),
		//	new Vertex(_posBoxT2, _uvBoxSide4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posBoxB3, _uvBoxSide1, c_white, 1.0),
		//	new Vertex(_posBoxB4, _uvBoxSide2, c_white, 1.0),
		//	new Vertex(_posBoxT4, _uvBoxSide3, c_white, 1.0),
		//	new Vertex(_posBoxT3, _uvBoxSide4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posBoxB4, _uvBoxSide1, c_white, 1.0),
		//	new Vertex(_posBoxB1, _uvBoxSide2, c_white, 1.0),
		//	new Vertex(_posBoxT1, _uvBoxSide3, c_white, 1.0),
		//	new Vertex(_posBoxT4, _uvBoxSide4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posBoxT1, _uvBoxTop, c_white, 1.0),
		//	new Vertex(_posBoxT2, _uvBoxTop, c_white, 1.0),
		//	new Vertex(_posBoxT3, _uvBoxTop, c_white, 1.0),
		//	new Vertex(_posBoxT4, _uvBoxTop, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posBoxM1, _uvBoxTop, c_white, 1.0),
		//	new Vertex(_posBoxM2, _uvBoxTop, c_white, 1.0),
		//	new Vertex(_posBoxM3, _uvBoxTop, c_white, 1.0),
		//	new Vertex(_posBoxM4, _uvBoxTop, c_white, 1.0));
		//mesh.AddTriangle(
		//	new Vertex(_posRootB1, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootB2, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootT,  _uvRoot, c_white, 1.0));
		//mesh.AddTriangle(
		//	new Vertex(_posRootB2, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootB3, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootT,  _uvRoot, c_white, 1.0));
		//mesh.AddTriangle(
		//	new Vertex(_posRootB3, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootB4, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootT,  _uvRoot, c_white, 1.0));
		//mesh.AddTriangle(
		//	new Vertex(_posRootB4, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootB1, _uvRoot, c_white, 1.0),
		//	new Vertex(_posRootT,  _uvRoot, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posTreeX1, _uvTree1, c_white, 1.0),
		//	new Vertex(_posTreeX2, _uvTree2, c_white, 1.0),
		//	new Vertex(_posTreeX3, _uvTree3, c_white, 1.0),
		//	new Vertex(_posTreeX4, _uvTree4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posTreeZ1, _uvTree1, c_white, 1.0),
		//	new Vertex(_posTreeZ2, _uvTree2, c_white, 1.0),
		//	new Vertex(_posTreeZ3, _uvTree3, c_white, 1.0),
		//	new Vertex(_posTreeZ4, _uvTree4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posTreeXZ1, _uvTree1, c_white, 1.0),
		//	new Vertex(_posTreeXZ2, _uvTree2, c_white, 1.0),
		//	new Vertex(_posTreeXZ3, _uvTree3, c_white, 1.0),
		//	new Vertex(_posTreeXZ4, _uvTree4, c_white, 1.0));
		//mesh.AddQuad(
		//	new Vertex(_posTreeZX1, _uvTree1, c_white, 1.0),
		//	new Vertex(_posTreeZX2, _uvTree2, c_white, 1.0),
		//	new Vertex(_posTreeZX3, _uvTree3, c_white, 1.0),
		//	new Vertex(_posTreeZX4, _uvTree4, c_white, 1.0));

	#endregion

#endregion
#region Grid mesh

	gridCellCount	= 8;
	gridCellSize	= 50;
	gridHWidth		= gridCellCount * gridCellSize * 0.5;
	gridColor		= $CCCCCC;

	axisColorX	= $2F31B8;
	axisColorY	= $5FA841;
	axisColorZ	= $B06929;

	GUIPoint	= new Vec2(0, 0);
	right		= new Vec3(+gridHWidth, 0.0, 0.0);
	left		= new Vec3(-gridHWidth, 0.0, 0.0);
	down		= new Vec3(0.0, +gridHWidth, 0.0);
	up			= new Vec3(0.0, -gridHWidth, 0.0);
	forward		= new Vec3(0.0, 0.0, +gridHWidth);
	back		= new Vec3(0.0, 0.0, -gridHWidth);

	grid		= Create_WireMesh(_texture);
	#region Constructing grid mesh

		var _uvFrom	= new Vec2(0.50, 0.75),
			_uvMid	= new Vec2(0.75, 0.75),
			_uvTo	= new Vec2(1.00, 0.75);
	
		grid.AddLine(
			new Vertex(left,	_uvMid, axisColorX, 1.0),
			new Vertex(right,	_uvMid, axisColorX, 1.0));
		grid.AddLine(
			new Vertex(up,		_uvMid, axisColorY, 1.0),
			new Vertex(down,	_uvMid, axisColorY, 1.0));
		grid.AddLine(
			new Vertex(back,	_uvMid, axisColorZ, 1.0),
			new Vertex(forward,	_uvMid, axisColorZ, 1.0));
		for (var _pos  = -gridHWidth;
				 _pos <= +gridHWidth;
				 _pos += gridCellSize)
		{
			if (_pos == 0) continue;
	
			grid.AddLine(
				new Vertex(new Vec3(_pos, 0.0, -gridHWidth), _uvFrom, gridColor, 0.25),
				new Vertex(new Vec3(_pos, 0.0, +gridHWidth), _uvTo  , gridColor, 0.25));
			grid.AddLine(
				new Vertex(new Vec3(-gridHWidth, 0.0, _pos), _uvFrom, gridColor, 0.25),
				new Vertex(new Vec3(+gridHWidth, 0.0, _pos), _uvTo  , gridColor, 0.25));
		}

	#endregion

#endregion
#region Lights

	//Create_LightDirectional(
	//	2, 2, 1,
	//	c_navy, sp_MaskDefaultl,
	//	new Vec3(200, -200, -200),
	//	new Vec3(0, 0, 0),
	//	new Vec3(0, 1, 0));
	Create_LightSpot(
		1, 16, 1280,
		c_white, sp_MaskFlashlight,
		new Vec3(-500, 1300, 500),
		new Vec3(0, 0, 0),
		new Vec3(0, 1, 0));
	//Create_LightSpot(
	//	0.10, 8, 40,
	//	c_white, spi_dummy,
	//	new Vec3(100, 300, 100),
	//	new Vec3(0, 100, 0),
	//	new Vec3(0, 1, 0));
	
#endregion

function Draw() {
	//shader_set(sh_smf_animate);
	//matrix_set(matrix_world,mesh.mat);
	//mainInst.draw();
	//matrix_set(matrix_world,matrix_build_identity());
	//shader_reset();	
}