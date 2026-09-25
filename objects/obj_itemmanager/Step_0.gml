

// Get Selected Item
selected_item = -1;
for (var i = 0; i < array_length(inv); i++)
	{
	var _xx = screen_bord/2;
	var _yy = screen_bord/2 + sep*i;
	
	if mouse_x > _xx && mouse_x < _xx+16 && mouse_y > _yy && mouse_y < _yy+16
		{
		selected_item = i;
		}
	
	}


if selected_item != -1
	{
	
	// Use Item
	if mouse_check_button_pressed(mb_left)
		{
		inv[selected_item].effect();
		}
	
	}