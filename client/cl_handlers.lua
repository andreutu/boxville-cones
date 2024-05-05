AddEventHandler('boxville-cones:client:takeCone', function()
	Notify('notify.take')
	DisableActions()
	PlayEmote()
end)

AddEventHandler('boxville-cones:client:placeConeInVan', function()
	LimitControls = false
	LocalPlayer.state:set('inv_busy', false, false)
	Notify('notify.put_back')
	CancelEmote()
end)

AddEventHandler('boxville-cones:client:toggleCones', function(veh, stack, toggle)
	local extra

	if stack == 'left' then
		extra = Config.LeftExtra
	elseif stack == 'right' then
		extra = Config.RightExtra
	end

	SetVehicleExtra(NetToVeh(veh), extra, toggle)
end)

AddEventHandler('boxville-cones:client:placeCone', function()
	LimitControls = false
	LocalPlayer.state:set('inv_busy', false, false)
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

	TriggerServerEvent('boxville-cones:server:addTarget', netId)

	IsInAnimation = false
end)

AddEventHandler('boxville-cones:client:addTarget', function(netId)
	exports['qb-target']:AddTargetEntity(NetworkGetEntityFromNetworkId(netId), {
		options = {
			{
				icon = Config.PickupIcon,
				label = Lang:t('text.take'),
				action = function(entity)
					if PlayerHasCone then
						FailNotify('notify.error_inhand')
						return
					end

					TriggerServerEvent('boxville-cones:server:deleteCone', ObjToNet(entity))
					TriggerEvent('boxville-cones:client:takeCone')
				end
			}
		},

		distance = Config.Distance
	})
end)

AddEventHandler('boxville-cones:client:deleteCone', function(entity)
	DeleteEntity(NetToObj(entity))
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	Wait(1000)
	TriggerServerEvent('boxville-cones:server:loadCones')
end)

AddEventHandler('boxville-cones:client:failNotify', function(message)
	FailNotify(message)
end)
