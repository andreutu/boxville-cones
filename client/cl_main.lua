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
					return TriggerServerEvent('boxville-cones:server:placeConeInVan', netEntity, 'left')
				end

				TriggerServerEvent("boxville-cones:server:takeCone", netEntity, 'left')
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
					return TriggerServerEvent('boxville-cones:server:placeConeInVan', netEntity, 'right')
				end

				TriggerServerEvent("boxville-cones:server:takeCone", netEntity, 'right')
				Notify('notify.take')
			end
		}
	},
	distance = Config.Distance,
})

exports['qb-target']:AddTargetModel(Config.RessuplyPointsProp, {
	options = {
		{
			icon = Config.PickupIcon,
			label = Lang:t('text.take'),
			action = function()
				if PlayerHasCone then
					Notify('notify.put_back')
					return CancelEmote()
				end

				TriggerEvent('boxville-cones:client:takeCone')
				Notify('notify.take')
			end
		}
	},

	distance = Config.Distance
})

RegisterNetEvent('boxville-cones:client:takeCone')
RegisterNetEvent('boxville-cones:client:placeConeInVan')
RegisterNetEvent('boxville-cones:client:toggleCones')
RegisterNetEvent('boxville-cones:client:placeCone')
RegisterNetEvent('boxville-cones:client:addTarget')
RegisterNetEvent('boxville-cones:client:deleteCone')

function Notify(message)
	QBCore.Functions.Notify(Lang:t(message), 'primary', Config.NotifyDuration)
end