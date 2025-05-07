text = "UNDEFINED";
inst = 0;
inst_color = false;
text_color = c_white;
if (instance_exists(obs_microsys)) {
    switch (obs_microsys.micro_playstyle) {
        case 0: inst = 0; text = loc("playstyle[0]"); break;
        case 1: inst = 1; text = loc("playstyle[1]"); break;
        case 2: inst = 2; text = loc("playstyle[2]"); break;
    }
    if (obs_microsys.micro_nightmare) {
        image_blend = #7a0529;
        inst_color = true;
    }
}