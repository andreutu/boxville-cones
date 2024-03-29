PlayerHasCone = false
IsInAnimation = false

local playerProp

local function loadPropDict(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Wait(0)
	end
end

local function addPropToPlayer(prop, bone, off, rot)
	local ped = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(ped))

	loadPropDict(prop)

	local prop = CreateObject(prop, x, y, z + 0.2, true, true, true)

	AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone),
		off[1], off[2], off[3], rot[1], rot[2], rot[3],
		true, true, false, true, 1, true)

	playerProp = prop
	PlayerHasCone = true
	SetModelAsNoLongerNeeded(prop)
end

function DestroyCone()
	DeleteEntity(playerProp)
	PlayerHasCone = false
end

function CancelEmote()
	if IsInAnimation then
		ClearPedTasks(PlayerPedId())
		DestroyCone()

		IsInAnimation = false
		exports['qb-radialmenu']:RemoveOption('boxville-cones:placeCone')
	end
end

function PlayEmote()
	local ped = PlayerPedId()

	if IsPedArmed(ped, 7) then
		SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), false)

		Wait(1500)
	end

	local dict, anim = table.unpack(Config.ConeAnimation)

	if PlayerHasCone then
		DestroyCone()
	end

	LoadAnim(dict)

	TaskPlayAnim(ped, dict, anim, 2.0, 2.0, -1, 51, 0, false, false, false)
	RemoveAnimDict(dict)

	IsInAnimation = true

	exports['qb-radialmenu']:AddOption({
		id = 'placeCone',
		title = Config.Lang.PlaceLabel,
		icon = Config.PlaceIcon,
		type = 'client',
		event = 'boxville-cones:client:PlaceCone',
		shouldClose = true
	}, 'boxville-cones:placeCone')

	local propName = Config.ConeAnimation.AnimationOptions.Prop
	local propBone = Config.ConeAnimation.AnimationOptions.PropBone
	local propOffset = Config.ConeAnimation.AnimationOptions.PropOffset
	local propRotation = Config.ConeAnimation.AnimationOptions.PropRotation

	Wait(0)

	addPropToPlayer(propName, propBone, propOffset, propRotation)
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(0)
	end
end
