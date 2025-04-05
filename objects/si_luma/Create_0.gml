ambientColor	= new Vec3(color_get_red(amb)/255, color_get_green(amb)/255, color_get_blue(amb)/255);
u_AmbientColor	= shader_get_uniform(shm_ambient, "u_AmbientColor");