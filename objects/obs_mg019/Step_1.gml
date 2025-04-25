if (global.res_change) {
    if (surface_exists(surf_cut)) {
        if (!buffer_exists(tmpsrf)) {
            print("GURT");
            tmpsrf = buffer_create(0,buffer_grow,1);
            buffer_get_surface(tmpsrf,surf_cut,0);
        }
    }
    if (surface_exists(surf_target)) {
        if (!buffer_exists(tmptarget)) {
            print("GURT2");
            tmptarget = buffer_create(0,buffer_grow,1);
            buffer_get_surface(tmptarget,surf_target,0);
        }
    }
}