gpu_push_state();
gpu_set_ztestenable(true);

matrix_set(matrix_world,mat);
VBM_Model_Submit(mdl,VBM_SUBMIT_TEXNONE);
matrix_set(matrix_world,matrix_build_identity());

gpu_pop_state();