wander_x = irandom_range(x-room_width/2.3,x+room_width/2.3);
wander_time = irandom_range(50,110);
wander_timer = wander_time;
wander_sprite = spr_mg013_rainpup_lwalk;
if (sign(x - wander_x) == -1) wander_sprite = spr_mg013_rainpup_rwalk;