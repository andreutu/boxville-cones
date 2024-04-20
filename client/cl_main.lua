local QBCore = exports['qb-core']:GetCoreObject()

exports['qb-target']:AddTargetBone("cone_l", {
	options = {
		{
			icon = Config.PickupIcon,
			label = Lang:t('text.take_car'),
			action = function(entity)
				local netEntity = VehToNet(entity)

				if PlayerHasCone then
					Notify('notify.put_back')
					return TriggerServerEvent('boxville-cones:server:PlaceConeInVan', netEntity, 'left')
				end

				TriggerServerEvent("boxville-cones:server:TakeCone", netEntity, 'left')
				Notify('notify.take')
			end
		}
	},
	distance = Config.Distance,
})

exports['qb-target']:AddTargetBone("cone_r", {
	options = {
		{
			icon = Config.PickupIcon,
			label = Lang:t('text.take_car'),
			action = function(entity)
				local netEntity = VehToNet(entity)

				if PlayerHasCone then
					Notify('notify.put_back')
					return TriggerServerEvent('boxville-cones:server:PlaceConeInVan', netEntity, 'right')
				end

				TriggerServerEvent("boxville-cones:server:TakeCone", netEntity, 'right')
				Notify('notify.take')
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
	Notify('notify.place')

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
	exports['qb-target']:AddTargetEntity(NetworkGetEntityFromNetworkId(netId), {
		options = {
			{
				icon = Config.PickupIcon,
				label = Lang:t('text.take'),
				action = function(entity)
					if PlayerHasCone then return end

					Notify('notify.take')
					TriggerServerEvent('boxville-cones:server:DeleteCone', ObjToNet(entity))
					TriggerEvent('boxville-cones:client:TakeCone')
				end
			}
		},

		distance = Config.Distance
	})
end)

RegisterNetEvent('boxville-cones:client:AddResupplyPointTarget', function(netId)
	exports['qb-target']:AddTargetEntity(NetworkGetEntityFromNetworkId(netId), {
		options = {
			{
				icon = Config.PickupIcon,
				label = Lang:t('text.take'),
				action = function()
					if PlayerHasCone then
						Notify('notify.put_back')
						return CancelEmote()
					end

					TriggerEvent('boxville-cones:client:TakeCone')
					Notify('notify.take')
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
	TriggerServerEvent('boxville-cones:server:LoadResupplyPoints')
end)

RegisterNetEvent('boxville-cones:client:LoadResupplyPoints', function()
	local prop = Config.RessuplyPointsProp

	RequestModel(prop)
	while not HasModelLoaded(prop) do
		Wait(0)
	end

	for _, data in ipairs(Config.ResupplyPoints) do
		local x, y, z, w = table.unpack(data)

		local obj = CreateObject(prop, x, y, z - 1, true, true, true)
		TriggerServerEvent('boxville-cones:server:AddResupplyPointTarget', NetworkGetNetworkIdFromEntity(obj))
		SetEntityHeading(obj, w)

		exports['qb-target']:AddTargetEntity(obj, {
			options = {
				{
					icon = Config.PickupIcon,
					label = Lang:t('text.resupply'),
					action = function()
						if PlayerHasCone then
							Notify('notify.put_back')
							return CancelEmote()
						end

						TriggerEvent('boxville-cones:client:TakeCone')
						Notify('notify.take')
					end
				}
			},

			distance = Config.Distance
		})
	end
end)

function Notify(message)
	QBCore.Functions.Notify(Lang:t(message), 'success', Config.NotifyDuration)
end
