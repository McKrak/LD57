var mat = matrix_build(x, y, z, 0, 0, 0, 1, 1, 1);
matrix_set(matrix_world, mat);

var _tex = sprite_get_texture(spm_grid,0);

vertex_submit(buff,pr_trianglelist,_tex);

matrix_set(matrix_world, matrix_build_identity());