// Inherit the parent event
event_inherited();
for (var i = 0; i < 3 + floor((obs_microsys.difficulty * random_range(1,3))); i++) {
    instance_create_layer(irandom_range(128,640-128),irandom_range(64,296),layer,obj_mg002_window);
}