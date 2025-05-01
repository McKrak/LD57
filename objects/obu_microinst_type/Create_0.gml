text = "UNDEFINED";
inst = 0;
if (instance_exists(obs_microsys)) {
    switch (obs_microsys.micro_playstyle) {
        case 0: inst = 0; text = loc("playstyle[0]"); break;
        case 1: inst = 1; text = loc("playstyle[1]"); break;
        case 2: inst = 2; text = loc("playstyle[2]"); break;
    }
}