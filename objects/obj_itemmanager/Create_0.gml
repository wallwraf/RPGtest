depth = -10000;

// Item Constructor
function create_item(_name, _desc, _icon, _effect) constructor
	{
	name = _name;
	desc = _desc;
	icon = _icon;
	effect = _effect;
	}

// Create Items
global.item_list = 
	{
	
#region Debug
	
	test_item : new create_item(
		"Test Item",
		"An item for testing.",
		spr_test_item,
		function()
			{
			obj_player.xspd += 5;
			
			// Remove Item
			array_delete(inv, selected_item, 1);
			}
		),
		
	test_item2 : new create_item(
		"Devilish Key",
		"Opens doors. [SINGLE USE]",
		spr_test_item_2,
		function()
			{
			if instance_exists(obj_demon_door)
				{
				with(obj_demon_door)
					{
					if distance_to_object(obj_player) < 20 { instance_destroy(); };
					}
				}
			}
		),
		
#endregion
	
	}
	

// Create Inventory
inv = array_create(0);

selected_item = -1;

//
sep = 16;
screen_bord = 16;