// Room Saving
function save_room()
{
	
	var _interactedWith = instance_number(obj_speakblock);
	
	var _roomStruct =
	{
		
		interactedWith : _interactedWith,
		interactableData : array_create(_interactedWith),
		
	}
	
	for (var i = 0; i < _interactedWith; i++)
	{
	
		var _inst = instance_find(obj_speakblock, i);
	
	}
	
}