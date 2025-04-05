//Begin defining a format
vertex_format_begin();
vertex_format_add_position_3d();//Add 3D position info
vertex_format_add_color();//Add color info
vertex_format_add_texcoord();//Texture coordinate info
//End building the format, and assign the format to the variable "format"
form = vertex_format_end();
//buff = model_load($"Kahuna/ModelData/{model}.dat",form);

//Create the vertex buffer. Another function, vetex_create_buffer_ext can be used to create the buffer with its size predefined and fixed.
//With the standard vertex_create_buffer, the buffer will just grow automatically as needed.
buff = vertex_create_buffer();
//Begin building the buffer using the format defined previously
vertex_begin(buff, form);
//Using size to keep it square if we decide to change how bug it is.
var size = 48;
//Add the six vertices needed to draw a simple square plane.
//The first triangle
vertex_position_3d(buff, -size, -size, 0);
vertex_color(buff, c_white, 1);
vertex_texcoord(buff, 0, 0);
vertex_position_3d(buff, size, -size, 0);
vertex_color(buff, c_white, 1);
vertex_texcoord(buff, 1, 0);
vertex_position_3d(buff, -size, size, 0);
vertex_color(buff, c_white, 1);
vertex_texcoord(buff, 0, 1);
//The second triangle. The winding order has been maintained so drawing is consistent if culling is enabled.
vertex_position_3d(buff, -size, size, 0);
vertex_color(buff, c_white, 1);
vertex_texcoord(buff, 0, 1);
vertex_position_3d(buff, size, -size, 0);
vertex_color(buff, c_white, 1);
vertex_texcoord(buff, 1, 0);
vertex_position_3d(buff, size, size, 0);
vertex_color(buff, c_white, 1);
vertex_texcoord(buff, 1, 1);
//Finish building the buffer.
vertex_end(buff);

if (sprite_exists(texture)) {
	tex = sprite_get_texture(texture,pattern);
} else tex = -1;

mat = matrix_build_identity();

//ambientColor	= new Vec3(amb_r, amb_g, amb_b);
//u_AmbientColor	= shader_get_uniform(shm_ambient, "u_AmbientColor");
mat = matrix_build(x, y, z, xrot, yrot, zrot, xscale, yscale, zscale);

function Draw(_use_shader = false) {
	gpu_set_cullmode(culling);
	gpu_set_texrepeat(tex_repeat);
	gpu_set_ztestenable(depth_test);
	
	if (_use_shader) {
		if (shader!= -4) shader_set(shader);
		switch(shader) {
			case shm_ambient:
				u_AmbientColor	= shader_get_uniform(shm_ambient, "u_AmbientColor");
				if (use_global_ambience) {
					shader_set_uniform_f(u_AmbientColor,color_get_red(si_luma.amb)/255,color_get_green(si_luma.amb)/255,color_get_blue(si_luma.amb)/255);
				} else {
					shader_set_uniform_f(u_AmbientColor,color_get_red(amb_color)/255,color_get_green(amb_color)/255,color_get_blue(amb_color)/255);
				}
			break;
		}
	}
	
	matrix_set(matrix_world, mat);
	vertex_submit(buff, pr_trianglelist, tex);
	
	if (_use_shader) shader_reset();
	
	gpu_set_cullmode(cull_noculling);
	gpu_set_texrepeat(false);
	gpu_set_ztestenable(false);
}

function Update() {
	mat = matrix_build(x, y, z, xrot, yrot, zrot, xscale, yscale, zscale);
}

//Update();