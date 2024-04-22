Config = {}

---------------------------------------

Config.Distance = 1.5                         -- The distance at which the qb-target options will appear.
Config.NotifyDuration = 1500                  -- The notification's duration in ms.

Config.PickupIcon = 'fas fa-upload'           -- The icon to show up on the qb-target option.
Config.PlaceIcon = 'fas fa-download'          -- The icon to show up on the qb-radialmenu option.

Config.DefaultLeftCones = 6                   -- Amount of default cones on the left stack.
Config.LeftExtra = 1                          -- The extra number which will be disabled when there are no cones left on the left stack.
Config.DefaultRightCones = 5                  -- Amount of default cones on the right stack.
Config.RightExtra = 2                         -- The extra number which will be disabled when there are no cones left on the right stack.

Config.ConeProp = `prop_mp_cone_02`           -- Cone prop.
Config.RessuplyPointsProp = `cprop_box_cones` -- Resupply point prop.

---------------------------------------

-- NOTE!
-- Changing the custom resupply prop to one frequently present around the map (or a vanilla prop)
-- will lead to ALL of those instances of objects becoming resupply points.
-- A custom prop, or the one provided, is recommended.

---------------------------------------

-- Information regarding the cone holding animation.
-- Unless you know what you are doing, DON'T change this.
-- Credit to dpemotes for part of the animation handling!
Config.ConeAnimation = {
	'missfbi4prepp1',
	'_idle_garbage_man',

	AnimationOptions = {
		Prop = Config.ConeProp,
		PropBone = 57005,
		PropOffset = { 0.09, -0.6, 0.0 },
		PropRotation = { -93.0, 0.0, 0.0 },
		EmoteLoop = true,
		EmoteMoving = true
	}
}

-- Information regarding the cone drop animation.
-- Unless you know what you are doing, DON'T change this.
Config.DropAnimation = {
	'anim@narcotics@trash',
	'drop_front'
}

-- Resupply points, each represented by a vector4.
-- A good way of obtaining a vector4 is by going into qb-adminmenu -> Developer Options -> Copy vector4.
Config.ResupplyPoints = {
	[1] = vector4(428.15, -642.02, 28.5, 86.32)
}

-- A debug mode which enables some logging in the console.
Config.Debug = false
