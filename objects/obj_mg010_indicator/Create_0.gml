w = 0;
chlen = 0;
w*=chlen;
startpos = 320;
if (instance_exists(obs_mg010)) {
    w = string_width_scribble(obs_mg010.quote)*.75;
    chlen = w/string_length_scribble(obs_mg010.quote);
    print(w);
    print(chlen);
    startpos = startpos-w;
    x = startpos;
}