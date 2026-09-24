right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);

// Get xspd and yspd
xspd = (right_key - left_key) * movespd;
yspd = (down_key - up_key) * movespd;

// Pause
if instance_exists(obj_pause)
	{
		xspd = 0;
		yspd = 0;
	}

// Set Sprite
mask_index = sprite[DOWN];

if yspd == 0
	{
	if xspd > 0 {face = RIGHT};
	if xspd < 0 {face = LEFT};
	} else {
		if xspd > 0 && yspd > 0 {face = DOWNRIGHT};
		if xspd < 0 && yspd > 0 {face = DOWNLEFT};
		if xspd > 0 && yspd < 0 {face = UPRIGHT};
		if xspd < 0 && yspd < 0 {face = UPLEFT};
		}

if xspd > 0 && face == LEFT {face = RIGHT};
if xspd < 0 && face == RIGHT {face = LEFT};

if xspd == 0
	{
	if yspd > 0 {face = DOWN};
	if yspd < 0 {face = UP};
	}

if yspd > 0 && face == UP {face = DOWN};
if yspd < 0 && face == DOWN {face = UP};

sprite_index = sprite[face];

// Collision with obj_collider
if place_meeting(x + xspd, y, obj_collider) == true
	{
		xspd = 0
	}
if place_meeting(x, y + yspd, obj_collider) == true
	{
		yspd = 0
	}

// Move the Player
x += xspd;
y += yspd;

// Animate
if xspd == 0 and yspd == 0
	{
		image_index = 0;
	}

// Depth
depth = -bbox_bottom;