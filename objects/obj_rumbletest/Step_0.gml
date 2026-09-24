if instance_exists(obj_button)
{
	state = obj_button.image_index;
}

// Set the sprite and sound
	// OFF
	if state == 0
	{
		image_index = 0
	}
	
	// ON
	if state == 1
	{
		image_index = 1
		obj_sound.rumbleLoop = true;
	}