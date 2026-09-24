image_index = vol;

if keyboard_check_pressed(189)
{
	vol--;
	global.masterVolume = vol / 10;
}
if keyboard_check_pressed(187)
{
	vol++;
	global.masterVolume = vol / 10;
}

if vol < 0 { vol = 0 };
if vol > 10 { vol = 10 };