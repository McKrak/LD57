if (!set_keys) {
    for (var i = 0; i < instance_number(obj_mg005_key); i++) {
        var _inst = instance_find(obj_mg005_key,i);
        _inst.type = keytypes[i];
    }
    set_keys = true;
}
