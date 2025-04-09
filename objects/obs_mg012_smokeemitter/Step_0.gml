if (instance_exists(obs_microsys)) {
    if (!obs_microsys.pause) {
        part_system_update(ps_trail);
        part_particles_create(ps_trail, x,y, px_trail.emitters[0].parttype.ind, 1);
        part_system_position(ps_trail,x,y);
    }
}