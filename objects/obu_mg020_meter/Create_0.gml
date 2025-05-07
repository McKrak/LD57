tol = .25;
winstart = random_range(0,1);
winend = winstart + tol;
if (winstart > (1-tol)) {
    winend = winstart - tol;
}
//winstart = 0.9;
//winend = 1;
arrow_ypos = 0;
arrow_move = 0;

border_l = x-(image_yscale*sprite_height/2)+13;
border_r = x-10;
border_u = y+8;
border_d = y+(image_xscale*sprite_width/5)-9;



