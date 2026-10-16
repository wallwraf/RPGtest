// Action Library
global.actionLibrary =
{
	#region Basic
	attack :
	{
		name : "Attack",
		desc : "{0} attacks!",
		sound : sfx_hit,
		soundDelay : 10, // How many frames before the sound plays.
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		effectSprite : vfx_hit_ord,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.attack + random_range(-_user.attack * 0.25, _user.attack * 0.25));
			battle_change_hp(_targets[0], -_damage, 0);
		}
		
	},
	#endregion
#region Magical
	#region Element - Fire
	fireshock :
	{
		name : "FireShock",
		desc : "{0} casts FireShock!",
		subMenu : -1,
		sound : sfx_fireshock,
		soundDelay : 10,
		mpCost : 8,
		targetRequired : true,
		targetEnemyByDefault : true, // 0: Party/Self, 1: Enemy
		targetAll : MODE.NEVER,
		userAnimation : "cast",
		effectSprite : vfx_fireshock,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = irandom_range(15,20);
			battle_change_hp(_targets[0], -_damage);
			battle_change_mp(_user, -mpCost)
		}
	},
	firegrave :
	{
		name : "FireGrave",
		desc : "{0} casts FireGrave!",
		subMenu : "Magic",
		sound : sfx_firegrave,
		soundDelay : 10,
		mpCost : 15,
		targetRequired : true,
		targetEnemyByDefault : true, // 0: Party/Self, 1: Enemy
		targetAll : MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite : vfx_fireshock,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(40,45);
				if (array_length(_targets) > 1) _damage = ceil(_damage * 0.95);
				battle_change_hp(_targets[i], -_damage);
			}
			battle_change_mp(_user, -mpCost)
		}
	},
	#endregion
	#region Element - Cold
	iceshock :
	{
		name : "IceShock",
		desc : "{0} casts IceShock!",
		subMenu : "Magic",
		sound : sfx_firegrave,
		soundDelay : 10,
		mpCost : 4,
		targetRequired : true,
		targetEnemyByDefault : true, // 0: Party/Self, 1: Enemy
		targetAll : MODE.NEVER,
		userAnimation : "cast",
		effectSprite : vfx_fireshock,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = irandom_range(12,14);
			battle_change_hp(_targets[0], -_damage);
			battle_change_mp(_user, -mpCost)
		}
	},
	snowgrave :
	{
		name : "SnowGrave",
		desc : "{0} casts SnowGrave!",
		subMenu : "Magic",
		sound : sfx_firegrave,
		soundDelay : 10,
		mpCost : 40,
		targetRequired : true,
		targetEnemyByDefault : true, // 0: Party/Self, 1: Enemy
		targetAll : MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite : vfx_fireshock,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(100,100);
				if (array_length(_targets) > 1) _damage = ceil(_damage * 0.95);
				battle_change_hp(_targets[i], -_damage);
			}
			battle_change_mp(_user, -mpCost)
		}
	},
	#endregion
	#region Element - Force
	forceblaster :
	{
		name : "ForceBlaster",
		desc : "{0} casts ForceBlaster!",
		subMenu : "Magic",
		sound : sfx_firegrave,
		soundDelay : 10,
		mpCost : 8,
		targetRequired : true,
		targetEnemyByDefault : true, // 0: Party/Self, 1: Enemy
		targetAll : MODE.NEVER,
		userAnimation : "cast",
		effectSprite : vfx_hit_orng,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(12,14)*(_user.attack/10);
				if (array_length(_targets) > 1) _damage = ceil(_damage * 0.95);
				battle_change_hp(_targets[i], -_damage);
			}
			battle_change_mp(_user, -mpCost)
		}
	},
	multiblaster :
	{
		name : "MultiBlaster",
		desc : "{0} shoots MultiBlaster!",
		subMenu : "Magic",
		sound : sfx_firegrave,
		soundDelay : 10,
		mpCost : 12,
		targetRequired : true,
		targetEnemyByDefault : true, // 0: Party/Self, 1: Enemy
		targetAll : MODE.VARIES,
		userAnimation : "cast",
		effectSprite : vfx_hit_orng,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(18,21)*(_user.attack/10);
				if (array_length(_targets) > 1) _damage = ceil(_damage * 0.65);
				battle_change_hp(_targets[i], -_damage);
			}
			battle_change_mp(_user, -mpCost)
		}
	},
	#endregion
	#region Element - Magical
	
	#endregion
	#region Element - Earth
	
	#endregion
	#region Element - Lightning
	
	#endregion
	#region Element - Poison
	
	#endregion
#endregion
#region Physical
	#region Element - Sharp

	#endregion
	#region Element - Blunt

	#endregion
#endregion
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

// Party Data
global.party =
[
	{
		name : "Char1",
		hp : 90,
		hpMax : 90,
		magic : 0,
		magicMax : 0,
		attack : 12,
		defense : 12,
		
		sprites : { idle: spr_bplayer_idle, attack: spr_bplayer_attack, cast: spr_bplayer_cast, defend: spr_bplayer_defend, down: spr_bplayer_down },
		actions : [global.actionLibrary.attack]
	}
	,
	{
		name : "Char2",
		hp : 70,
		hpMax : 70,
		magic : 15,
		magicMax : 15,
		attack : 6,
		defense : 9,
		
		sprites : { idle: spr_bchar2_idle, attack: spr_bchar2_attack, cast: spr_bchar2_cast, defend: spr_bchar2_defend, down: spr_bchar2_down },
		actions : [global.actionLibrary.attack, global.actionLibrary.fireshock, global.actionLibrary.firegrave, global.actionLibrary.iceshock, global.actionLibrary.snowgrave]
	}
	,
	{
		name : "Char3",
		hp : 105,
		hpMax : 105,
		magic : 3,
		magicMax : 3,
		attack : 15,
		defense : 6,
		
		sprites : { idle: spr_bchar3_idle, attack: spr_bchar3_attack, cast: spr_bchar3_cast, defend: spr_bchar3_defend, down: spr_bchar3_down },
		actions : [global.actionLibrary.attack, global.actionLibrary.forceblaster, global.actionLibrary.multiblaster]
	}
];

// Enemies
global.enemies =
{
	orc:
	{
		name : "Orc",
		hp : 130,
		hpMax : 130,
		magic : 0,
		magicMax : 0,
		attack : 13,
		defense : 9,
		
		sprites : { idle: spr_orc_idle, attack : spr_orc_attack },
		actions : [global.actionLibrary.attack],
		
		xpValue : 15,
		AIscript : function()
		{
			// Attack Random
			var _action = actions[0];
			var _possibleTargets = array_filter(obj_battle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
}