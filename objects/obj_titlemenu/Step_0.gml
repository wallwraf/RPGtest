// Get Inputs
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(ord("Z"))

// Store Options No.
op_length = array_length(option[menu_level])

// Navigate Menus
pos += down_key - up_key;
if pos >= op_length { pos = 0 };
if pos < 0 { pos = op_length - 1 };

// Use Option
if accept_key
{

var _sml = menu_level;

switch(menu_level){
	
	// Pause Menu
	case 0:
		switch(pos){
			// Start Game
			case 0: room_goto_next(); break;
			// Settings
			case 1: menu_level = 1; break;
			// Quit Game
			case 2: game_end(); break;
			}
		break;
		
	// Settings
	case 1:
		switch(pos){
			// Fullscreen
			case 0:  break;
			// Controls
			case 1:  break;
			// Volume
			case 2:  break;
			// Back
			case 3: menu_level = 0; break;
		}
	}
	
	// Set Position Back
	if _sml != menu_level { pos = 0 };
	
	// Correct Option Length
	op_length = array_length(option[menu_level])

}