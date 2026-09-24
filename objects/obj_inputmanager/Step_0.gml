if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))
{
	global.accept_button = true
} else { global.accept_button = false }

if keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X"))
{
	global.cancel_button = true
} else { global.cancel_button = false }

if keyboard_check_pressed(vk_control) || keyboard_check_pressed(ord("C"))
{
	global.menu_button = true
} else { global.menu_button = false }