Config = {}

Config.Distance = 1.5

Config.PickupIcon = 'custom cone-pickup'
Config.PlaceIcon = 'custom cone-place'

Config.DefaultLeftCones = 6
Config.LeftExtra = 1
Config.DefaultRightCones = 5
Config.RightExtra = 2

Config.ConeProp = `prop_mp_cone_02`

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

Config.Lang = {
	TakeCarLabel = 'Take / Place Cone',
	PlaceLabel = 'Place Cone',
	TakeLabel = 'Pickup Cone'
}

Config.ResupplyPoints = {
	[1] = vector3(428.4, -647.23, 28.5),
	[2] = vector3(428.73, -637.44, 28.5),
	[3] = vector3(423.5, -631.28, 28.5)
}

Config.Debug = false
