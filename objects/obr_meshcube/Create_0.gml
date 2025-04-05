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

mat = matrix_build_identity();
tex = sprite_get_texture(texture,pattern);

//ambientColor	= new Vec3(amb_r, amb_g, amb_b);
//u_AmbientColor	= shader_get_uniform(shm_ambient, "u_AmbientColor");
	mat = matrix_build(x, y, z, xrot, yrot, zrot, xscale, yscale, zscale);
function Draw() {

	matrix_set(matrix_world, mat);
	vertex_submit(buff, pr_trianglelist, tex);
}