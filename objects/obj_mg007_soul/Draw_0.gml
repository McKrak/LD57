matrix_set(matrix_world, matrix_build(x,y,0,45,0,0,1,1,1));
draw_sprite(sprite_index, image_index,0,0);
matrix_set(matrix_world,matrix_build_identity());
//draw_self();