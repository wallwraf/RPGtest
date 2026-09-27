battleState();

// Cursor Control
if (cursor.active)
{
	with (cursor)
	{
		// Input
		var _keyUp = keyboard_check_pressed(vk_up);
		var _keyDown = keyboard_check_pressed(vk_down);
		var _keyLeft = keyboard_check_pressed(vk_left);
		var _keyRight = keyboard_check_pressed(vk_right);
		var _keyToggle = false;
		var _keyConfirm = false;
		var _keyCancel = false;
		confirmDelay++;
		if (confirmDelay > 1)
		{
			_keyConfirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
			_keyCancel = keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X"));
			_keyToggle = keyboard_check_pressed(vk_control) || keyboard_check_pressed(ord("C"));
		}
		var _moveH = _keyRight - _keyLeft;
		var _moveV = _keyDown - _keyUp;
		
		if (_moveH == -1) targetSide = obj_battle.partyUnits;
		if (_moveH == 1) targetSide = obj_battle.enemyUnits;
		
		// Verify Target List
		if (targetSide == obj_battle.enemyUnits)
		{
			targetSide = array_filter(targetSide, function(_element, _index)
			{
				return _element.hp > 0;
			});
		}
		
		// Move Between Targets
		if (targetAll == false)
		{
			if (_moveV == 1) targetIndex++;
			if (_moveV == -1) targetIndex--;
			
			// Wrap
			var _targets = array_length(targetSide);
			if (targetIndex < 0) targetIndex = _targets - 1;
			if (targetIndex > (_targets - 1)) targetIndex = 0;
			
			// Identify Target
			activeTarget = targetSide[targetIndex];
			
			// Toggle All Mode
			if (activeAction.targetAll == MODE.VARIES) && (_keyToggle) // Switch to All Mode
			{
				targetAll = true;
			}
		}
		else // Target All Mode
		{
			activeTarget = targetSide;
			if (activeAction.targetAll == MODE.VARIES) && (_keyToggle) // Switch to Single Mode
			{
				targetAll = false;
			}
		}
		
		// Confirm
		if (_keyConfirm)
		{
			with (obj_battle) begin_action(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
			with (obj_menu) instance_destroy();
			active = false;
			confirmDelay = 0;
		}
		// Cancel
		if (_keyCancel) && (!_keyConfirm)
		{
			with (obj_menu) active = true;
			active = false;
			confirmDelay = 0;
		}
	}
}