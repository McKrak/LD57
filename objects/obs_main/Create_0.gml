seq = layer_sequence_create(layer,0,0,sql_main);

seqinst = layer_sequence_get_instance(seq);
alarm[0] = 2;

act_exit = function() {
    game_end();
}


