exports['qb-target']:AddTargetBone("cone_l", {
	options = {
		{
			icon = 'custom cone-pickup',
			label = Config.Lang.TakeCarLabel,
			action = function(entity)
				if PlayerHasCone then return TriggerServerEvent('boxville-cones:Server:PlaceConeInVan', VehToNet(entity), 'left') end
				TriggerServerEvent("boxville-cones:Server:TakeCone", VehToNet(entity), 'left')
			end
		}
	},
	distance = Config.Distance,
})

exports['qb-target']:AddTargetBone("cone_r", {
	options = {
		{
			icon = 'custom cone-pickup',
			label = Config.Lang.TakeCarLabel,
			action = function(entity)
				if PlayerHasCone then return TriggerServerEvent('boxville-cones:Server:PlaceConeInVan', VehToNet(entity), 'right') end
				TriggerServerEvent("boxville-cones:Server:TakeCone", VehToNet(entity), 'right')
			end
		}
	},
	distance = Config.Distance,
})

RegisterNetEvent('boxville-cones:Client:TakeCone', function()
	PlayEmote()
end)

RegisterNetEvent('boxville-cones:Client:PlaceConeInVan', function()
	CancelEmote()
end)

RegisterNetEvent('boxville-cones:Client:ToggleCones', function(veh, stack, toggle)
	local extra

	if stack == 'left' then
		extra = Config.LeftExtra
	elseif stack == 'right' then
		extra = Config.RightExtra
	end

	SetVehicleExtra(NetToVeh(veh), extra, toggle)
end)

RegisterNetEvent('boxville-cones:Client:PlaceCone', function()
	exports['qb-radialmenu']:RemoveOption('boxville-cones:placeCone')

	local ped = PlayerPedId()

	LoadAnim(Config.DropAnimation[1])
	StopAnimTask(ped, Config.ConeAnimation[1], Config.ConeAnimation[2], 1.0)
	TaskPlayAnim(ped, Config.DropAnimation[1], Config.DropAnimation[2], 8.0, -8.0, -1, 0, 0, false, false, false)
	RemoveAnimDict(Config.DropAnimation[1])

	Wait(930)

	local position = GetEntityCoords(ped)
	local fwdvector = GetEntityForwardVector(ped)

	DestroyCone()

	local obj = CreateObject('prop_mp_cone_02', position.x + fwdvector.x * 0.5, position.y + fwdvector.y * 0.5,
		position.z - 0.85, true, true, false)
	ActivatePhysics(obj)

	exports['qb-target']:AddTargetEntity(obj, {
		options = {
			{
				icon = 'custom cone-pickup',
				label = Config.Lang.TakeLabel,
				action = function(entity)
					if PlayerHasCone then return end

					DeleteEntity(entity)
					TriggerEvent('boxville-cones:Client:TakeCone')
				end
			}
		},

		distance = Config.Distance
	})

	IsInAnimation = false
end)
