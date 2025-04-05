x = obu_cursor.x;
y = obu_cursor.y;

shoottimer -= 1*sy.dt;
if (shoottimer < 0) {
    instance_create_layer(x,y,layer,obj_mg001_bullet);
    shoottimer = 60;
}

