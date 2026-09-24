// Sound Effect Volume
var _sfxVol = global.effectVolume * global.masterVolume;
var _snd = noone;

// Door Open Sound
if doorOpen
{
	// Play sound
	_snd = audio_play_sound(sfx_dooropen, 8, false);
	audio_sound_gain(_snd, _sfxVol, 0);
	
	// Falsify var
	doorOpen = false;
}

// Door Close Sound
if doorClose
{
	// Play sound
	_snd = audio_play_sound(sfx_doorclose, 8, false);
	audio_sound_gain(_snd, _sfxVol, 0);
	
	// Falsify var
	doorClose = false;
}

// Button Press Sound
if buttonDown
{
	_snd = audio_play_sound(sfx_buttondown, 8, false);
	audio_sound_gain(_snd, _sfxVol, 0)
	buttonDown = false;
}

// Button Release Sound
if buttonUp
{
	_snd = audio_play_sound(sfx_buttonup, 8, false);
	audio_sound_gain(_snd, _sfxVol, 0)
	buttonUp = false;
}



// Loops - - - - - - - - - - - - - - - - - - - - - - - -

// Rumble
	// Rumble - on
	if rumbleLoop && !audio_is_playing(rumbleLoopInst)
	{
		rumbleLoopInst = audio_play_sound(sfx_rumble, 6, true);
	}
	// Set Volume
	if audio_is_playing(rumbleLoopInst)
	{
		audio_sound_gain(rumbleLoopInst, _sfxVol, 0)
	}
	// Rumble - off
	if !rumbleLoop && audio_is_playing(rumbleLoopInst)
	{
		audio_stop_sound(rumbleLoopInst);
	}
	rumbleLoop = false;

// test_fade_in_loop
	// test_fade_start
	if loopfadetestLoop
	{
		// test_play_sound
		if !audio_is_playing(loopfadetestLoopInst)
		{
			loopfadetestLoopInst = audio_play_sound(sfx_rumble, 6, true);
		}
		
		// test_vol_up
		if loopfadetestLoopVol < 1 { loopfadetestLoopVol += loopfadetestLoopVolSpd; }
		else { loopfadetestLoopVol = 1; };
	}
	// test_fade_off
	if !loopfadetestLoop
	{
		// test_vol_down
		if loopfadetestLoopVol > 0 { loopfadetestLoopVol -= loopfadetestLoopVolSpd; }
		else { loopfadetestLoopVol = 0; };
		
		// test_stop_sound
		if loopfadetestLoopVol <= 0
		{
			audio_stop_sound(loopfadetestLoopInst);
		}
	}
	// test_set_vol
	if audio_is_playing(loopfadetestLoopInst)
	{
		audio_sound_gain(loopfadetestLoop, loopfadetestLoopVol * _sfxVol, 0);
	}
	// test_reset_var
	loopfadetestLoop = false;

//  - - - - - - - - - - - - - - - - - - - - - - - - - - -