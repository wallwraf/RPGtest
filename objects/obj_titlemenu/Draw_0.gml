draw_set_font(fnt_main_font);

// Dynamically Get Width & Height of Menu
height = op_border*2 + string_height(option[0, 0]) + (op_length - 0.5) * op_space

// Center Menu
x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - width/2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2 - height/2;

// Draw Menu BG
draw_sprite_ext(sprite_index, image_index, x, y, width / sprite_width, height / sprite_height, 0, c_white, 1);

// Draw Options
draw_set_valign(fa_top);
draw_set_halign(fa_center);

for ( var i = 0; i < op_length; i++ )
	{
		var _c = c_white;
		if pos == i { _c = c_yellow }
		draw_text_colour(x+(op_border*5), y+(op_border*1.5) + op_space*i, option[menu_level, i], _c, _c, _c, _c, 1);
	}