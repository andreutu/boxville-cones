local cones = {}

exports['qb-target']:AddTargetBone("cone_l", {
	options = {
		{
			icon = Config.PickupIcon,
			label = Config.Lang.TakeCarLabel,
			action = function(entity)
				local netEntity = VehToNet(entity)

				if PlayerHasCone then
					return TriggerServerEvent('boxville-cones:server:PlaceConeInVan', netEntity, 'left')
				end

				TriggerServerEvent("boxville-cones:server:TakeCone", netEntity, 'left')
			end
		}
	},
	distance = Config.Distance,
})

exports['qb-target']:AddTargetBone("cone_r", {
	options = {
		{
			icon = Config.PickupIcon,
			label = Config.Lang.TakeCarLabel,
			action = function(entity)
				local netEntity = VehToNet(entity)

				if PlayerHasCone then
					return TriggerServerEvent('boxville-cones:server:PlaceConeInVan', netEntity, 'right')
				end

				TriggerServerEvent("boxville-cones:server:TakeCone", netEntity, 'right')
			end
		}
	},
	distance = Config.Distance,
})

RegisterNetEvent('boxville-cones:client:TakeCone', function()
	PlayEmote()
end)

RegisterNetEvent('boxville-cones:client:PlaceConeInVan', function()
	CancelEmote()
end)

RegisterNetEvent('boxville-cones:client:ToggleCones', function(veh, stack, toggle)
	local extra

	if stack == 'left' then
		extra = Config.LeftExtra
	elseif stack == 'right' then
		extra = Config.RightExtra
	end

	SetVehicleExtra(NetToVeh(veh), extra, toggle)
end)

RegisterNetEvent('boxville-cones:client:PlaceCone', function()
	exports['qb-radialmenu']:RemoveOption('boxville-cones:placeCone')

	local ped = PlayerPedId()

	LoadAnim(Config.DropAnimation[1])
	StopAnimTask(ped, Config.ConeAnimation[1], Config.ConeAnimation[2], 1.0)
	TaskPlayAnim(ped, Config.DropAnimation[1], Config.DropAnimation[2], 8.0, -8.0, -1, 0, 0, false, false, false)
	RemoveAnimDict(Config.DropAnimation[1])

	Wait(930)

	RequestModel(Config.ConeProp)

	while not HasModelLoaded(Config.ConeProp) do
		Wait(0)
	end

	DestroyCone()

	local coords = GetEntityCoords(ped)
	local heading = GetEntityHeading(ped)
	local vector = GetEntityForwardVector(ped)
	local x, y, z = table.unpack(coords + vector * 0.5)
	local obj = CreateObject(Config.ConeProp, x, y, z, true, true, true)
	local netId = NetworkGetNetworkIdFromEntity(obj)
	SetNetworkIdExistsOnAllMachines(netId, true)
	SetNetworkIdCanMigrate(netId, false)
	SetEntityHeading(obj, heading)
	PlaceObjectOnGroundProperly(obj)
	SetModelAsNoLongerNeeded(obj)

	Wait(100)

	TriggerServerEvent('boxville-cones:server:AddTarget', netId)

	IsInAnimation = false
end)

RegisterNetEvent('boxville-cones:client:AddTarget', function(netId)
	print('adding target')
	exports['qb-target']:AddTargetEntity(NetworkGetEntityFromNetworkId(netId), {
		options = {
			{
				icon = Config.PickupIcon,
				label = Config.Lang.TakeLabel,
				action = function(entity)
					if PlayerHasCone then return end

					TriggerServerEvent('boxville-cones:server:DeleteCone', ObjToNet(entity))
					TriggerEvent('boxville-cones:client:TakeCone')
				end
			}
		},

		distance = Config.Distance
	})
end)

RegisterNetEvent('boxville-cones:client:DeleteCone', function(entity)
	DeleteEntity(NetToObj(entity))
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	Wait(1000)
	TriggerServerEvent('boxville-cones:server:LoadCones')
end)
