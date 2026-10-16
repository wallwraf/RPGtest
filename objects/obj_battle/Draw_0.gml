// Draw Units by Depth Order
var _unitWithCurrentTurn = unitTurnOrder[turn].id;
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		draw_self();
	}
}

// Draw UI
draw_sprite_stretched(spr_battlemenu, 0, x+75, y+170, 245, 70);
draw_sprite_stretched(spr_battlemenu, 0, x, y+170, 74, 70);

// Positions
#macro COLUMN_ENEMY 15
#macro COLUMN_NAME 90
#macro COLUMN_HP 160
#macro COLUMN_MP 220

// Draw Headings
draw_set_font(fnt_items);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(#403C4C);
draw_text(x+COLUMN_ENEMY, y+172, "ENEMY");
draw_text(x+COLUMN_NAME, y+172, "NAME");
draw_text(x+COLUMN_HP, y+172, "HP");
draw_text(x+COLUMN_MP, y+172, "MP");

// Draw Enemy Names
draw_set_font(fnt_items);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
var _drawLimit = 4;
var _drawn = 0;
for (var i = 0; (i < array_length(enemyUnits)) && (_drawn < _drawLimit); i++)
{
	var _char = enemyUnits[i];
	if _char.hp > 0
	{
		_drawn++;
		draw_set_halign(fa_left);
		draw_set_colour(c_white);
		if (_char.id == _unitWithCurrentTurn) draw_set_colour(c_yellow);
		draw_text((x+COLUMN_ENEMY)-7, y+182+(i*12), string(i+1))
		draw_text(x+COLUMN_ENEMY, y+182+(i*12), _char.name);
	}
}

// Draw Party Info
for (var i = 0; i < array_length(partyUnits); i++)
{
	draw_set_halign(fa_left);
	draw_set_colour(c_white);
	var _char = partyUnits[i];
	if (_char.id == _unitWithCurrentTurn) draw_set_colour(c_yellow);
	if (_char.hp <= 0) draw_set_colour(c_red);
	draw_text(x+COLUMN_NAME, y+182+(i*12), _char.name);
	draw_set_halign(fa_right);
	
	draw_set_colour(c_white);
	if (_char.hp < (_char.hpMax * 0.5)) draw_set_colour(c_orange);
	if (_char.hp <= 0) draw_set_colour(c_red);
	draw_text(x+COLUMN_HP+50, y+182+(i*12), string(_char.hp) + "/" + string(_char.hpMax));
	
	draw_set_colour(c_white);
	if (_char.magic < (_char.magicMax * 0.5)) draw_set_colour(c_orange);
	if (_char.magic <= 0) draw_set_colour(c_red);
	draw_text(x+COLUMN_MP+50, y+182+(i*12), string(_char.magic) + "/" + string(_char.magicMax));
	
	draw_set_colour(c_white);
}

// Draw Target Cursor
if (cursor.active)
{
	with (cursor)
	{
		if (activeTarget != noone)
		{
			if (!is_array(activeTarget))
			{
				draw_sprite(spr_targetcursor, 0, activeTarget.x, activeTarget.y);
			}
			else
			{
				draw_set_alpha(sin(get_timer()/50000)+1);
				for (var i = 0; i < array_length(activeTarget); i++)
				{
					draw_sprite(spr_targetcursor, 0, activeTarget[i].x, activeTarget[i].y)
				}
				draw_set_alpha(1.0);
			}
		}
	}
}

// Draw Battle Text
if (battleText != "")
{
	var _w = string_width(battleText)+20;
	draw_sprite_stretched(spr_dialogueoption, 0, x+160-(_w*0.5), y+5, _w, 25);
	draw_set_halign(fa_center);
	draw_set_colour(c_white);
	draw_text(x+160, y+10, battleText);
}