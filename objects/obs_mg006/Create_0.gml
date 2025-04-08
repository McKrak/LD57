// Inherit the parent event
event_inherited();
var _cap = irandom_range(12, 16) + (irandom_range(3,7) * nightmare);

for (var i = 0; i < _cap; i++) {
    instance_create_layer(random_range(64,640-64),random_range(64,360-64),layer,obj_mg006_person,{
        is_fake: i == 0    
    });
}

timer_hovering = 25;
ds_caught = ds_list_create();