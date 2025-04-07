draw_self();
if (instance_exists(obs_mg010)) {
    scribble($"[fnt_typewriter][fa_middle][fa_center]{obs_mg010.original}").blend(c_grey,.75).scale(.35).draw(x,y-64);  
    scribble($"[fnt_typewriter][fa_middle][fa_center]{obs_mg010.displayquote}").blend(c_black,1).scale(.35).draw(x,y-64);   
     
}