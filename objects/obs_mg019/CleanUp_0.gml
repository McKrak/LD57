// Inherit the parent event
event_inherited();
if surface_exists(surf_cut) surface_free(surf_cut);
    if (buffer_exists(tmpsrf)) buffer_delete(tmpsrf);
if surface_exists(surf_target) surface_free(surf_target);
    if (buffer_exists(tmptarget)) buffer_delete(tmptarget);