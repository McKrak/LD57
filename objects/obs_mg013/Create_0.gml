
// Inherit the parent event
event_inherited();

time_spawndroplet = nightmare ? 2 : 1;
timer_spawndroplet = time_spawndroplet;

if (nightmare) {
    layer_background_sprite(layer_background_get_id("Background"),spb_mg013n_bg);
    layer_background_sprite(layer_background_get_id("BG_GROUND"),spb_mg013n_ground);
    layer_background_sprite(layer_background_get_id("BG_CLOUDS_LAYERA"),spb_mg013n_clouda);
    layer_background_sprite(layer_background_get_id("BG_CLOUDS_LAYERB"),spb_mg013n_cloudb);
}