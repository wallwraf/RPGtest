// Room Saving
function save_room()
{
	
	var _interactedWith = instance_number(obj_speakblock);
	var _itemNum = instance_number(obj_world_item);
	
	var _inv = global.item_inv;
	
	var _roomStruct =
	{
		
		inventory : _inv,
		intrNum : _interactedWith,
		intrData : array_create(_interactedWith),
		itemNum : _itemNum,
		itemData : array_create(_itemNum),
		
	}
	
	// Interactables
	for (var i = 0; i < _interactedWith; i++)
		{
	
		var _inst = instance_find(obj_speakblock, i);
		
		_roomStruct.intrData[i] = {
			x : _inst.x,
			y : _inst.y,
			}
	
		}
	// Items
	for (var i = 0; i < _itemNum; i++)
		{
		
		var _inst = instance_find(obj_world_item, i);
		
		_roomStruct.itemData[i] = {
			x : _inst.x,
			y : _inst.y,
			item : _inst.item,
			name : _inst.item.name,
			icon : _inst.item.icon,
			desc : _inst.item.desc,
			droppable : _inst.item.droppable,
			effect : _inst.item.effect,
			}
		
		}
	
	// Store Room
	if room == rm_bedroom_mine { global.levelData.level_1 = _roomStruct; };
	if room == rm_home_room { global.levelData.level_2 = _roomStruct; };
	if room == rm_outdoor { global.levelData.level_3 = _roomStruct; };
	
}

function load_room()
{

	var _roomStruct = 0;
	
	// Get Struct
	if room == rm_bedroom_mine { _roomStruct = global.levelData.level_1; };
	if room == rm_home_room { _roomStruct = global.levelData.level_2; };
	if room == rm_outdoor { _roomStruct = global.levelData.level_3; };
	
	// Exit if _roomStruct false
	if !is_struct(_roomStruct) {exit;};
	
// Dialogue/Interact blocks
	// Replace interactables with saved
	if instance_exists(obj_speakblock) { instance_destroy(obj_speakblock); };
	for (var i = 0; i < _roomStruct.intrNum ; i++)
		{
		instance_create_depth(_roomStruct.intrData[i].x, _roomStruct.intrData[i].y, depth, obj_speakblock);
		}
// Items
	if instance_exists(obj_world_item) { instance_destroy(obj_world_item); };
	for (var i = 0; i < _roomStruct.itemNum ; i++)
		{
		with( instance_create_depth(_roomStruct.itemData[i].x, _roomStruct.itemData[i].y, depth, obj_world_item) )
			{
			obj_world_item.item = _roomStruct.itemData[i].item;
			obj_world_item.item.name = _roomStruct.itemData[i].name;
			obj_world_item.item.icon = _roomStruct.itemData[i].icon;
			obj_world_item.item.desc = _roomStruct.itemData[i].desc;
			obj_world_item.item.droppable = _roomStruct.itemData[i].droppable;
			obj_world_item.item.effect = _roomStruct.itemData[i].effect;
			}
		}

}