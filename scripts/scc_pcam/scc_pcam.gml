function pjcam() : node() constructor {
	
	static remove = function() {
		toggle(false);
		search_and_remove(host,self);
	}
	
	static toggle = function(_sel = undefined) {
		if _sel == undefined sel = !sel else sel = _sel;
		
		if (instance_exists(d_sy)) {
			if (sel) {
				if (!array_contains(d_sy.selected,self)) {
					array_push(d_sy.selected,self);
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
}

