function debug_setup(){
	dvw_roomjump = dbg_view("Room Jump", false);
	
	dsc_general = dbg_section("Common Rooms");
	
	dbg_button("title2",function() {room_goto(scn_title2);});
	dbg_button("MainMenu",function() {room_goto(scn_mainmenu);});
	dbg_button("PartyMode",function() {room_goto(scn_mdparty);});
	
	dsc_board = dbg_section("Board");
	
	dbg_button("Board",function() {room_goto(scn_board);});
	dbg_button("BoardOld",function() {room_goto(scn_boardold);});
	dbg_button("BoardTestOld",function() {room_goto(scn_boardtestold);});
	
	dsc_debug = dbg_section("Debug");
	
	dbg_button("FontTest",function() {room_goto(scn_fnttest);});
	dbg_button("TypeTest",function() {room_goto(scn_typetest);});
	dbg_button("ButtonTest",function() {room_goto(scn_buttontest);});
	dbg_button("Nothing",function() {room_goto(scn_nothing);});
	
	dsc_minigame = dbg_section("Minigames");
	
	dbg_button("001 / Viewtest",function() {room_goto(scn_mg001);});
	dbg_button("401 / TiltGame (Texas Tilt'Em)",function() {room_goto(scn_mg401);});
	dbg_button("402 / SpaceGame (A Space Oddity)",function() {room_goto(scn_mg402);});
	
}
function debug_destroy() {
	dbg_section_delete(dsc_general);
	dbg_section_delete(dsc_board);
	dbg_section_delete(dsc_debug);
	dbg_section_delete(dsc_minigame);
	dbg_view_delete(dvw_roomjump);
}
function debug_player_setup(_index) {
	dvw_playersetup = dbg_view($"Player {index} Settings", false);
	
	dsc_p = dbg_section("Info");
	
	dbg_watch(ref_create(self, "index"), "Index");
	dbg_text_input(ref_create(self, "p_name"),"Character Name");
	dbg_watch(ref_create(self, "order"), "Order");
	dbg_watch(ref_create(self, "guild"), "Team");
	dbg_drop_down(ref_create(self, "charid"),"Zap:0,Gabe:1,Terry:2,Cal:4");
	dbg_text("Change Characters (Required if charid is changed)"); dbg_same_line(); dbg_button("Reset",function() {event_user(0);});
	dbg_sprite(ref_create(self, "sprites[0]"),0);
	dbg_watch(ref_create(self, "con"), "Controller Object");
	
	
}
function debug_player_destroy(_index) {
	dbg_section_delete(dsc_p);
}