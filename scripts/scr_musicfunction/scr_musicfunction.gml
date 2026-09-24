function set_song_ingame( _song, _fadeOutCurrent = 0, _fadeInNew = 0, _songOverlap = false )
{
	// _song = Set to track to play or noone to disable
	// _fadeOutCurrent = Time (in frames) the current track will take to fade to 0
	// _fadeInNew = Time (in frames) the new track will take to fade to 1
	// _songOverlap = Dictates if the song should overlap the previous track
	
	with( obj_musicmanager )
	{
		targetSongAsset = _song;
		outFade = _fadeOutCurrent;
		inFade = _fadeInNew;
		songOverlap = _songOverlap;
	}
}