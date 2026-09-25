right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);
sprint_key = global.sprint_button;

// Get xspd and yspd
if sprint_key
{
	movespd = runspd;
}
else
{
	movespd = walkspd;
}

xspd = (right_key - left_key) * movespd;
yspd = (down_key - up_key) * movespd;

// Pause
if instance_exists(obj_pause)
	{
		xspd = 0;
		yspd = 0;
	}

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

// Set Sprite
mask_index = sprite[DOWN];

if yspd == 0
	{
	if xspd > 0 {face = RIGHT};
	if xspd < 0 {face = LEFT};
	}

else
	{
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

if !sprint_key { sprite_index = sprite[face]; }
else { sprite_index = run_sprite[face]; }

// Animate
if xspd == 0 and yspd == 0
	{
		sprite_index = sprite[face];
		image_index = 0;
	}

// Fix Shake
x[0] = round(x[0.1]);
y[0] = round(y[0.1]);

// Depth
depth = -bbox_bottom;