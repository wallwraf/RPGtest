if image_index == 0 && place_meeting(x, y, obj_player)
{
	image_index = 1;
	obj_sound.buttonDown = true;
}

if image_index == 1 && !place_meeting(x, y, obj_player)
{
	image_index = 0;
	obj_sound.buttonUp = true;
}