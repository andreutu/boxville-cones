PlayerHasCone = false
IsInAnimation = false

local playerProp

local function loadPropDict(model)
    local hash = GetHashKey(model)

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(0)
    end
end

local function addPropToPlayer(prop, bone, off1, off2, off3, rot1, rot2, rot3)
	local ped = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(ped))

	if not HasModelLoaded(prop) then
		loadPropDict(prop)
	end

	prop = CreateObject(GetHashKey(prop), x, y, z + 0.2, true, true, true)
	AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false,
		true, 1, true)
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

	if not DoesEntityExist(ped) then
		return false
	end

	if IsPedArmed(ped, 7) then
		SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
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
		icon = 'custom cone-place',
		type = 'client',
		event = 'boxville-cones:Client:PlaceCone',
		shouldClose = true
	}, 'boxville-cones:placeCone')

	local propName = Config.ConeAnimation.AnimationOptions.Prop
	local propBone = Config.ConeAnimation.AnimationOptions.PropBone
	local propP1, propP2, propP3, propP4, propP5, propP6 = table.unpack(Config.ConeAnimation.AnimationOptions.PropPlacement)

	Wait(0)

	addPropToPlayer(propName, propBone, propP1, propP2, propP3, propP4, propP5, propP6)

	return true
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(0)
	end
end
