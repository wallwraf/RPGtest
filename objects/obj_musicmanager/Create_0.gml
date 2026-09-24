// Volume Controls
global.musicVolume = 1;
global.masterVolume = 1;

songOverlap = false;

// Information for the song playing and queued
songInst = noone;
songAsset = noone;
targetSongAsset = noone;
outFade = 0; // Frames to fade out
inFade = 0; // Frames to fade in
fadeInstVol = 1; // Volume of songInst

// For fading out and stopping
fadeOutInst = array_create(0); // Audio to fade out
fadeOutInstVol = array_create(0); // Volumes of audios
fadeOutInstTime = array_create(0); // Time it takes