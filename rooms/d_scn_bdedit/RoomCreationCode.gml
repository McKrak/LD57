if (instance_exists(d_sy)) {
    if (rpk_get_node_type(d_sy.context) == NODE_PJ_BOARD) {
        for (var i = 0; i < array_length(d_sy.context.content); i++) {
            d_sy.context.content[i].refresh();
        }
    }
}