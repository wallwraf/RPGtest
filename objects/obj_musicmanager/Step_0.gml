var _finalVol = global.musicVolume * global.masterVolume;


// Play target song
if songAsset != targetSongAsset
{
	// Tell the old song to fade
	if audio_is_playing(songInst)
	{
		array_push(fadeOutInst, songInst);
		array_push(fadeOutInstVol, fadeInstVol);
		array_push(fadeOutInstTime, outFade);
		
		songInst = noone;
		songAsset = noone;
	}
	
	
	// Play the song, if old song is faded
	if array_length(fadeOutInst) == 0 || songOverlap
	{
		if audio_exists(targetSongAsset)
		{
			// Play song
			songInst = audio_play_sound(targetSongAsset, 4, true);
	
			// Begin at volume 0
			audio_sound_gain(songInst, 0, 0);
			fadeInstVol = 0;
		}
	
		// Set songAsset = targetSongAsset
		songAsset = targetSongAsset;
		songOverlap = false;
	}
}

// Volume Control
	// Main Song Volume
	if audio_is_playing(songInst)
	{
		// Fade song in
		if inFade > 0
		{
			if fadeInstVol < 1 { fadeInstVol += 1/inFade } else fadeInstVol = 1;
		}
		// Instantly begin song if fade in is 0
		else
		{
			fadeInstVol = 1;
		}
	
		// Set the gain
		audio_sound_gain(songInst, fadeInstVol * _finalVol, 0);
	}
	
	// Fade Out
	for( var i = 0; i < array_length(fadeOutInst); i++ )
	{
		// Fade the volume
		if fadeOutInst[i] > 0
		{
			if fadeOutInstVol[i] > 0 { fadeOutInstVol[i] -= 1/fadeOutInstTime[i]; };
		}
		// Instantly set volume to 0
		else
		{
			fadeOutInstVol[i] = 0
		}
		
		// Set the gain
		audio_sound_gain(fadeOutInst[i], fadeOutInstVol[i] * _finalVol, 0);
		
		// Stop song when at 0
		if fadeOutInstVol[i] <= 0
		{
			if audio_is_playing(fadeOutInst[i]) { audio_stop_sound(fadeOutInst[i]); };
			array_delete(fadeOutInst, i, 1);
			array_delete(fadeOutInstVol, i, 1);
			array_delete(fadeOutInstTime, i, 1);
			i--;
		}
	}