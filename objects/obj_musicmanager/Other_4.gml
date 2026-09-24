/// @description Play the correct track

// Home
if room == rm_bedroom_mine
|| room == rm_home_room
{
	set_song_ingame(sng_welcome_home, 30, 30, true);
}

// Outside
if room == rm_outdoor
{
	set_song_ingame(sng_garden_of_hopes, 20, 10);
}