global.res_change = false;

if ((surface_get_width(application_surface) != global.res_width 
    || surface_get_height(application_surface) != global.res_height)) 
    global.res_change = true;
