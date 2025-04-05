if (instance_exists(d_sy)) {
    print("DSY EXISTS");
    if (d_sy.context != noone) {
        print("CONTEXT EXISTS");
        if (d_sy.context[$ "add_instance"] != undefined) {
            print("ADD INSTANCE");
            d_sy.context.add_instance();
        }
    }
}