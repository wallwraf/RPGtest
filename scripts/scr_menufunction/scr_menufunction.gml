/// @desc Menu
function menu(_x, _y, _options, _description = -1, _width = undefined, _height = undefined)
{
	with (instance_create_depth(_x, _y, -10000000, obj_menu))
	{
		options = _options;
		desc = _description;
		var _optionsCount = array_length(_options);
		visibleOptionsMax = _optionsCount;
		
		//
		xmargin = 14;
		ymargin = 8;
		draw_set_font(fnt_items);
		heightLine = 10;
		
		// Auto Width
		if (_width == undefined)
		{
			width = 1;
			if (desc != -1) width = max(width, string_width(_description));
			for (var i = 0; i < _optionsCount; i++)
			{
				width = max(width, string_width(_options[i][0]));
			}
			widthFull = width + xmargin * 2;
		} else widthFull = _width;
		
		// Auto Height
		if (_height == undefined)
		{
			height = heightLine * (_optionsCount + !(desc == -1));
			heightFull = height + ymargin * 2;
		}
		else
		{
			heightFull = _height;
			// Scrolling?
			if (heightLine * (_optionsCount + !(desc == -1)) > _height - (ymargin*2))
			{
				scrolling = true;
				visibleOptionsMax = (_height - ymargin * 2) div heightLine;
			}
		}
	}
}

function submenu(_options)
{
	// Store Old Options
	optionsAbove[submenuLevel] = options;
	submenuLevel++;
	options = _options
	hover = 0;
}

function menuback()
{
	submenuLevel--;
	options = optionsAbove[submenuLevel];
	hover = 0;
}

function menu_select_action(_user, _action)
{
	with (obj_menu) active = false;
	
	//
	with (obj_battle)
	{
		if (_action.targetRequired)
		{
			with (cursor)
			{
				active = true;
				activeAction = _action;
				targetAll = _action.targetAll
				if (targetAll == MODE.VARIES) targetAll = true;
				activeUser = _user;
				
				// Default Targetting Side
				if (_action.targetEnemyByDefault)
				{
					targetIndex = 0;
					targetSide = obj_battle.enemyUnits;
					activeTarget = obj_battle.enemyUnits[targetIndex];
				}
				else // Target Self by Default
				{
					targetSide = obj_battle.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element)
					{
						return (_element == activeTarget)
					}
					targetIndex = array_find_index(obj_battle.partyUnits, _findSelf);
				}
			}
		}
		else
		{
			// No Target
			begin_action(_user, _action, -1);
			with (obj_menu) instance_destroy();
		}
	}
}