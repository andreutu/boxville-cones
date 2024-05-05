local QBCore = exports['qb-core']:GetCoreObject()
LimitControls = false

exports['qb-target']:AddTargetBone("cone_l", {
	options = {
		{
			icon = Config.PickupIcon,
			label = Lang:t('text.take_car'),
			action = function(entity)
				local netEntity = VehToNet(entity)

				if PlayerHasCone then
					return TriggerServerEvent('boxville-cones:server:placeConeInVan', netEntity, 'left')
				end

				TriggerServerEvent("boxville-cones:server:takeCone", netEntity, 'left')
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
					return TriggerServerEvent('boxville-cones:server:placeConeInVan', netEntity, 'right')
				end

				TriggerServerEvent("boxville-cones:server:takeCone", netEntity, 'right')
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
RegisterNetEvent('boxville-cones:client:failNotify')

function Notify(message)
	QBCore.Functions.Notify(Lang:t(message), 'primary', Config.NotifyDuration)
end

function FailNotify(message)
	QBCore.Functions.Notify(Lang:t(message), 'error', Config.NotifyDuration)
end

function DisableActions()
	LimitControls = true
	LocalPlayer.state:set('inv_busy', true, false)

	Citizen.CreateThread(function()
		while LimitControls do
			Citizen.Wait(0)

			DisableControlAction(0, 75, true) -- Vehicle Exit
			DisableControlAction(0, 23, true) -- Vehicle Enter
			DisableControlAction(0, 22, true) -- Jumping

			-- Melee
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 47, true)
			DisableControlAction(0, 58, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 143, true)
		end
	end)
end
