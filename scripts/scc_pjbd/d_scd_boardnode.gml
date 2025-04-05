function board() : node() constructor {	
	type = NODE_BOARD;
	sel = false;
	
	name = "My Board";
	author = "Me";
	content = [];
	
	ELEPHANT_SCHEMA {
		v1: {
			name: buffer_string,
			author: buffer_string,
			content: buffer_array,
			//type: buffer_u8,
		}
	}
	
	static toggle = function(_sel = undefined) {
		if _sel == undefined sel = !sel else sel = _sel;
		print("GUH1");
		if (instance_exists(d_sy)) {
			if (sel) {
				if (!array_contains(d_sy.selected,self)) {
					array_push(d_sy.selected,self);
					d_sy.context = self;
					print("GUH");
				}
			} else {
				if (array_contains(d_sy.selected,self)) {
					for (var i = 0; i < array_length(d_sy.selected); i++) {
						if (d_sy.selected[i] == self) {
							array_delete(d_sy.selected,i,1);
						}
					}
				}
			}
		}
	}
	
	static remove = function() {
		toggle(false);
		while (array_length(content) != 0) {
			content[0].remove();
		}
		if (instance_exists(d_sy)) search_and_remove(d_sy.memory,self);
	}
}

