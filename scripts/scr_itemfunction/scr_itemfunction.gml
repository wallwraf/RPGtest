// Pick-Up
function inv_add(_item)
	{
	
	var _added = false;
	
	if array_length( obj_itemmanager.inv ) < obj_itemmanager.inv_max
		{
		array_push( obj_itemmanager.inv, _item );
		_added = true;
		}
	
	return _added;
	
	}