if room == target_rm && image_index < 1
	{
		instance_destroy();
	}

if ( room == target_rm ) && ( !hasPlayed ) && ( warp_type == "door" )
{
	obj_sound.doorClose = true;
	hasPlayed = true;
}