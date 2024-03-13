RegisterNetEvent("boxville-cones:setCones", function(vehicle, stack, amount)
	local entity = NetworkGetEntityFromNetworkId(vehicle)

    if stack == "left" then
        Entity(entity).state.leftCones = amount
    elseif stack == "right" then
        Entity(entity).state.rightCones = amount
    end

	if amount == 0 then
		TriggerClientEvent("boxville-cones:toggleExtra", NetworkGetEntityOwner(entity), vehicle, stack, true)
	end

	print(Entity(entity).state.leftCones, Entity(entity).state.rightCones)
end)