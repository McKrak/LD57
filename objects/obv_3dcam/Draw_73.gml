if (!surface_exists(output)) {
        if (res_width*output_xscale > 0) && (res_height*output_yscale > 0) {
            output = surface_create(res_width*output_xscale, res_height*output_yscale);
            view_surface_id[view] = output;
        }
    }
