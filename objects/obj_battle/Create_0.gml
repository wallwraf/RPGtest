instance_deactivate_all(true);
instance_activate_object(obj_battlebg);
instance_activate_object(obj_sound);
instance_activate_object(obj_volume);
set_song_ingame(sng_ruder_buster, 10, 0, true);

units = [];
turn = 0;
turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
battleText = "";
currentUser = noone;
currentAction = -1;
currentTargets = noone;
unitTurnOrder = [];
unitRenderOrder = [];

// Create Target Cursor
cursor =
{
	activeUser : noone,
	activeTarget : noone,
	activeAction : -1,
	targetSide : -1,
	targetIndex : 0,
	targetAll : false,
	confirmDelay : 0,
	active : false
};

// Make Enemies
for (var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+260+(i*5), y+58+(i*20), depth-10, obj_battleenemy, enemies[i]);
	array_push(units, enemyUnits[i]);
}

// Make Party
for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+60-(i*5), y+58+(i*20), depth-10, obj_battlepc, global.party[i]);
	array_push(units, partyUnits[i]);
}

// Shuffle Turn Order
unitTurnOrder = array_shuffle(units);

// Get Render Order
refreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder, 0, units, 0, array_length(units));
	array_sort(unitRenderOrder, function(_1, _2)
	{
		return _1.y - _2.y;
	});
}
refreshRenderOrder();

function battle_state_select_action()
{
	if (!instance_exists(obj_menu))
	{
		// Get Current Unit
		var _unit = unitTurnOrder[turn];
	
		//
		if (!instance_exists(_unit)) || (_unit.hp <= 0)
		{
			battleState = battle_state_victory_check;
			exit;
		}
	
		//
		//begin_action(_unit.id, global.actionLibrary.attack, _unit.id);
	
		//
		if (_unit.object_index == obj_battlepc)
		{
			// Compile
			var _menuOptions = [];
			var _subMenus = {};
			
			var _actionList = _unit.actions;
			
			for (var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i];
				var _available = true;
				var _nameAndCount = _action.name;
				if (_action.subMenu == -1)
				{
					array_push(_menuOptions, [_nameAndCount, menu_select_action, [_unit, _action], _available]);
				}
				else
				{
					//
					if (is_undefined(_subMenus[$ _action.subMenu]))
					{
						variable_struct_set(_subMenus, _action.subMenu, [[_nameAndCount, menu_select_action, [_unit, _action], _available]]);
					}
					else
					{
						array_push(_menuOptions, [_nameAndCount, menu_select_action, [_unit, _action], _available]);
					}
				}
			}
			
			//
			var _subMenusArray = variable_struct_get_names(_subMenus);
			for (var i = 0; i < array_length(_subMenusArray); i++)
			{
				//
				//
				
				//
				array_push(_subMenus[$ _subMenusArray[i]], ["Back", menuback, -1, true]);
				//
				array_push(_menuOptions, [_subMenusArray[i], submenu, [_subMenus[$ _subMenusArray[i]]], true]);
			}
			
			menu(x+10, y+110, _menuOptions, , 74, 64);
		}
		else
		{
			//
			var _enemyAction = _unit.AIscript();
			if (_enemyAction != 1) begin_action(_unit.id, _enemyAction[0], _enemyAction[1]);
		}
	}
}

function begin_action(_user, _action, _targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	battleText = string_ext(_action.desc, [_user.name]);
	soundDelay = _action.soundDelay;
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with (_user)
	{
		acting = true;
		//
		if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	battleState = battle_state_perform_action;
}

function battle_state_perform_action()
{
	soundPlayed = false;
	//
	if (currentUser.acting)
	{
		//
		if (currentUser.image_index >= currentUser.image_number -1)
		{
			with (currentUser)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
			
			if (variable_struct_exists(currentAction, "effectSprite"))
			{
				if (currentAction.effectOnTarget == MODE.ALWAYS) || ( (currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1) )
				{
					for (var i = 0; i < array_length(currentTargets); i++)
					{
						instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth-1, obj_battleeffect, {sprite_index : currentAction.effectSprite});
					}
				}
				else //
				{
					var _effectSprite = currentAction.effectSprite
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
					instance_create_depth(x, y, depth-100, obj_battleeffect, {sprite_index : _effectSprite})
				}
				
			}
			currentAction.func(currentUser, currentTargets);
		}
		if !soundPlayed 
		{
			if soundDelay > 0
			{
				soundDelay--;
				if soundDelay == 0
				{
					audio_play_sound(currentAction.sound, 8, false, global.masterVolume * global.effectVolume)
					soundPlayed = true
				}
			}
		}
	}
	else //
	{
		if (!instance_exists(obj_battleeffect))
		{
			battleWaitTimeRemaining--;
			if (battleWaitTimeRemaining == 0)
			{
				battleState = battle_state_victory_check;
			}
		}
	}
}

function battle_state_victory_check()
{
	battleState = battle_state_turn_progression;
}

function battle_state_turn_progression()
{
	battleText = "";
	turnCount++;
	turn++;
	// Loop
	if (turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount++;
	}
	battleState = battle_state_select_action;
}

battleState = battle_state_select_action;