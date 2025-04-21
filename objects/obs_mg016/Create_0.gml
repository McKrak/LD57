/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

for (var i = 0; i < 3; i++) {
    instance_create_layer(irandom_range(96,room_width-96),310,"Veggies",obj_mg016_vegg,{
        type: i,    
        spd: irandom_range(2,8),
        dir: choose(0,1)
    });
    
}

