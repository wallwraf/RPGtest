accept_key = keyboard_check_pressed(ord("Z"))
cancel_key = keyboard_check_pressed(ord("X"))

textbox_x = camera_get_view_x( view_camera[0] );
textbox_y = camera_get_view_y( view_camera[0] ) + 160;

// Setup
if !setup
{
	
	setup = true;
	draw_set_font(fnt_dialogue_font);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	// Loop the pages
	for( var p = 0; p < page_number; p++ )
	{
		// Find quantity of characters in page
		text_length[p] = string_length(text[p]);
		
		// Get the x position
			// Left-Side Speaker -- Left Aligned
			text_x_offset[p] = 96;
			portrait_x_offset[p] = 16;
			
			// Right-Side Speaker -- Right Aligned
			if speaker_side[p] == -1
			{
				text_x_offset[p] = 16;
				portrait_x_offset[p] = 224;
			}
			
			// No speaker -- Centered
			if speaker_sprite[p] == noone
			{
				text_x_offset[p] = 56;
			}
			
		// Set characters and find line breaks
		for (var c = 0; c < text_length[p]; c++)
		{
			
			var _char_pos = c+1;
			
			// Store characters
			char[c, p] = string_char_at(text[p], _char_pos);
			
			// Get current width of line
			var _txt_up_to_char = string_copy( text[p], 1, _char_pos );
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
			
			// Get the last free space
			if char[c, p] == " " { last_free_space = _char_pos+1 };
			
			// Get line breaks
			if _current_txt_w - line_break_offset[p] > line_width
			{
				line_break_pos[ line_break_num[p] , p ] = last_free_space;
				line_break_num[p]++;
				var _txt_up_to_last_space = string_copy( text[p], 1, last_free_space );
				var _last_free_space_string = string_char_at( text[p], last_free_space );
				line_break_offset[p] = string_width( _txt_up_to_last_space ) - string_width( _last_free_space_string );
			}
			
		}
		
		// Getting each characters coordinates
		for (var c = 0; c < text_length[p]; c++)
		{
			
			var _char_pos = c+1;
			var _txt_x = textbox_x + text_x_offset[p] + border;
			var _txt_y = textbox_y + border;
			// Get current width of line
			var _txt_up_to_char = string_copy( text[p], 1, _char_pos );
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
			var _txt_line = 0;
			
			// Compensate for string breaks
			for (var lb = 0; lb < line_break_num[p]; lb++)
			{
				if _char_pos >= line_break_pos[lb, p]
				{
					var _str_copy = string_copy( text[p], line_break_pos[lb, p], _char_pos-line_break_pos[lb, p] );
					_current_txt_w = string_width( _str_copy );
					
					// Record the line this character should be on
					_txt_line = lb+1; //lb + 1 since lb = 0 at first
				}
				
			}
			
			// Add to x, y based on data
			char_x[c, p] = _txt_x + _current_txt_w;
			char_y[c, p] = _txt_y + _txt_line*line_sep;
			
		}
		
	}
	
}



// Typing text
if draw_char < text_length[page]
{
	draw_char += text_speed;
	draw_char = clamp(draw_char, 0, text_length[page]);
}

// Flip through pages
if accept_key
{
	// If the typing is done, next
	if draw_char == text_length[page]
	{
		// Next Page
		if page < page_number-1
		{
			page++;
			draw_char = 0;
		}
		// Destroy Text
		else
		{
			// Link text
			if option_number > 0
			{
				create_textbox(option_link_id[option_pos]);
			}
			instance_destroy();
		}
	}
}

// Skip typewriter
if cancel_key
{
	// If not done typing
	if draw_char != text_length[page]
	{
		draw_char = text_length[page];
	}
}

// Draw Text Box - - - - - - - - - - - - - - - - -
var _txtb_x = textbox_x + text_x_offset[page];
var _txtb_y = textbox_y
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr[page]);
txtb_spr_h = sprite_get_height(txtb_spr[page]);

// Draw Speaker
var _txtb_p_offset = 8;
if speaker_sprite[page] != noone
{
	sprite_index = speaker_sprite[page];
	if draw_char == text_length[page] { image_index = 0 };
	var _speaker_x = textbox_x + portrait_x_offset[page];
	if speaker_side[page] == -1 { _speaker_x += sprite_width }
	// Draw the Speaker
	draw_sprite_ext(txtb_spr[page], txtb_img, textbox_x + portrait_x_offset[page], textbox_y, sprite_width/txtb_spr_w + 0.125, sprite_height/txtb_spr_h + 0.125, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, _speaker_x + 4, textbox_y + 4, speaker_side[page], 1, 0, c_white, 1);
	
}

// Draw Back
draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x, _txtb_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1);

// Options - - - - - - - - - - - - - - - - - - - -
if draw_char == text_length[page] && page == page_number - 1
{
	// Option Selection
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	option_pos = clamp(option_pos, 0, option_number-1);
	
	// Draw Options
	var _op_space = 20;
	var _op_bord = 8;
	for (var op = 0; op < option_number; op++)
	{
		// Option Box
		var _o_w = string_width(option[op]) + _op_bord*2;
		draw_sprite_ext(option_spr, txtb_img, _txtb_x + 16, _txtb_y - _op_space*option_number + _op_space*op, _o_w/txtb_spr_w, (_op_space-1)/txtb_spr_h, 0, c_white, 1)
		
		// Arrow
		if option_pos == op
		{
			draw_sprite(spr_optionarrow, 0, _txtb_x, _txtb_y - _op_space*option_number + _op_space*op)
		}
		
		// Option Text
		draw_text(_txtb_x + 16 + _op_bord, _txtb_y - _op_space*option_number + _op_space*op + 3, option[op]);
	}
	
}

// Draw the Text
for( var c = 0; c < draw_char; c++ )
{
	
	// Text
	draw_text( char_x[c, page], char_y[c, page], char[c, page] )
	
}
