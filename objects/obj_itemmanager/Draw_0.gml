draw_set_font(fnt_items)
draw_set_halign(fa_left)
draw_set_valign(fa_top)


for (var i = 0; i < array_length(inv); i++)
	{
	var _xx = screen_bord;
	var _yy = screen_bord;
	var _sep = sep;
	var _col = c_white;
	
	// Draw Icon
	draw_sprite( inv[i].icon, 0, camera_get_view_x(view_camera[0]) + _xx, camera_get_view_y(view_camera[0]) + _yy + _sep*i );
	
	// Get Selected Colour
	if selected_item == i { _col = c_yellow };
	draw_set_colour(_col);
	
	// Draw Name
	draw_text( camera_get_view_x(view_camera[0]) + _xx + 12, camera_get_view_y(view_camera[0]) + _yy/2 + _sep*i, inv[i].name );
	
	// Draw Description
	if selected_item == i
		{
		draw_text_ext( camera_get_view_x(view_camera[0]) + _xx, camera_get_view_y(view_camera[0]) + _yy/2 + _sep*array_length(inv), inv[i].desc, 12, 80 );
		}
	
	// Reset Colour to White
	draw_set_colour(c_white);
	}