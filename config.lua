Config = {}

Config.Distance = 1.5

Config.PickupIcon = 'custom cone-pickup'
Config.PlaceIcon = 'custom cone-place'

Config.DefaultLeftCones = 6
Config.LeftExtra = 1
Config.DefaultRightCones = 5
Config.RightExtra = 2

Config.ConeProp = `prop_mp_cone_02`
Config.RessuplyPointsProp = `cprop_box_cones`

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

Config.DropAnimation = {
	'anim@narcotics@trash',
	'drop_front'
}

Config.ResupplyPoints = {
	[1] = vector4(428.15, -642.02, 28.5, 86.32),
	[2] = vector4(428.52, -639.43, 28.5, 354.38),
	[3] = vector4(424.43, -643.43, 28.5, 131.89)
}

Config.Debug = false
