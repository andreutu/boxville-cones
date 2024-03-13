local holdingCone = false

exports['qb-target']:AddTargetBone("cone_l", {
	options = {
		{
			icon = Config.Icon,
			label = Config.Label,
			targeticon = Config.TargetIcon,
			action = function(entity)
				if Entity(entity).state.leftCones == nil and Entity(entity).state.leftCones ~= 0 then
					local netEntity = VehToNet(entity)

					TriggerServerEvent("boxville-cones:setCones", netEntity, "left", Config.DefaultLeftCones)
				end

				TriggerEvent("boxville-cones:leftCone", entity)
			end
		}
	},
	distance = Config.Distance,
})

exports['qb-target']:AddTargetBone("cone_r", {
	options = {
		{
			icon = Config.Icon,
			label = Config.Label,
			targeticon = Config.TargetIcon,
			action = function(entity)
				if not Entity(entity).state.rightCones == nil and Entity(entity).state.rightCones ~= 0 then
					local netEntity = VehToNet(entity)

					TriggerServerEvent("boxville-cones:setCones", netEntity, "right", Config.DefaultRightCones)
				end

				TriggerEvent("boxville-cones:rightCone", entity)
			end
		}
	},
	distance = Config.Distance,
})

RegisterNetEvent('boxville-cones:leftCone', function(veh)
	local leftCones = Entity(veh).state.leftCones

	if leftCones == nil then leftCones = Config.DefaultLeftCones end
	if leftCones == 0 then return print("No cones left!") end

	local netEntity = VehToNet(veh)

	leftCones -= 1

	TriggerServerEvent("boxville-cones:setCones", netEntity, "left", leftCones)
	print("cone_l taken, " .. leftCones .. " cones left")
end)

RegisterNetEvent('boxville-cones:rightCone', function(veh)
	local rightCones = Entity(veh).state.rightCones

	if rightCones == nil then rightCones = Config.DefaultRightCones end
	if rightCones == 0 then return print("No cones left!") end

	local netEntity = VehToNet(veh)

	rightCones -= 1

	TriggerServerEvent("boxville-cones:setCones", netEntity, "right", rightCones)
	print("cone_r taken, " .. rightCones .. " cones left")
end)

RegisterNetEvent('boxville-cones:toggleExtra', function(entity, stack, toggle)
	print("toggleing extra")
	if stack == 'left' then SetVehicleExtra(NetToVeh(entity), Config.LeftExtra, true)
	elseif stack == 'right' then SetVehicleExtra(NetToVeh(entity), Config.RightExtra, true) end
end)
