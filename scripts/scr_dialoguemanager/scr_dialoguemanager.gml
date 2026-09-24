function scr_set_defaults_for_text()
{
	line_break_pos[0, page_number] = 999;
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0;
	
	txtb_spr[page_number] = spr_menu
	speaker_sprite[page_number] = noone;
	speaker_side[page_number] = 1;
}

/// @param text
/// @param [character]
function scr_text(_text)
{
	
	scr_set_defaults_for_text()

	text[page_number] = _text;
	
	// Get Character Info
	if argument_count > 1
	{
		switch(argument[1])
		{
		
			case "NPC":
				speaker_sprite[page_number] = spr_npcport_spk
				speaker_side[page_number] = -1
				break;
			
			case "Player":
				speaker_sprite[page_number] = spr_playerport_spk
				break;
				case "Player Emotive":
				speaker_sprite[page_number] = spr_playerport_emote
					break;
		
		}
	}
	
	
	page_number++

}

/// @param option
/// @param link_id
function scr_option(_option, _link_id)
{

	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	
	option_number++;

}


/// @param text_id
function create_textbox(_text_id)
{
	
	with( instance_create_depth(0, 0, -100000, obj_textbox) )
	{
		scr_gametext(_text_id);
	}
	
}