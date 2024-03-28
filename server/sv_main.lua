RegisterNetEvent("boxville-cones:Server:PlaceConeInVan", function(vehicle, stack)
	local entity = NetworkGetEntityFromNetworkId(vehicle)
	local amount

	-- Stack check
	if stack == "left" then
		amount = Entity(entity).state.leftCones or Config.DefaultLeftCones

		if amount < Config.DefaultLeftCones then
            Entity(entity).state.leftCones = amount + 1
			TriggerClientEvent('boxville-cones:Client:PlaceConeInVan', source, entity, stack)
        else
			return
		end
    elseif stack == "right" then
		amount = Entity(entity).state.rightCones or Config.DefaultRightCones

		if amount < Config.DefaultRightCones then
            Entity(entity).state.rightCones = amount + 1
			TriggerClientEvent('boxville-cones:Client:PlaceConeInVan', source, entity, stack)
        else
			return
		end
    end

	-- Extra check
	if amount == 0 then
		TriggerClientEvent("boxville-cones:Client:ToggleCones", NetworkGetEntityOwner(entity), vehicle, stack, false)
	end

	if Config.Debug then
		-- Debug display
		print('\x1b[32m[boxville-cones:PLACELOG]\x1b[0m ' .. (Entity(entity).state.leftCones or -1) .. ' ' .. (Entity(entity).state.rightCones or -1))
	end
end)

RegisterNetEvent("boxville-cones:Server:TakeCone", function(vehicle, stack)
	local entity = NetworkGetEntityFromNetworkId(vehicle)
    local amount

	-- Stack check
    if stack == "left" then
        amount = Entity(entity).state.leftCones or Config.DefaultLeftCones

        if amount > 0 then
			Entity(entity).state.leftCones = amount - 1
			TriggerClientEvent('boxville-cones:Client:TakeCone', source, entity, stack)
		else
			return
        end
    elseif stack == "right" then
        amount = Entity(entity).state.rightCones or Config.DefaultRightCones

        if amount > 0 then
			Entity(entity).state.rightCones = amount - 1
			TriggerClientEvent('boxville-cones:Client:TakeCone', source, entity, stack)
		else
			return
        end
    end

	-- Extra check
    if amount - 1 == 0 then
        TriggerClientEvent("boxville-cones:Client:ToggleCones", NetworkGetEntityOwner(entity), vehicle, stack, true)
    end

	-- Debug display
	if Config.Debug then
		print('\x1b[32m[boxville-cones:TAKELOG]\x1b[0m ' .. (Entity(entity).state.leftCones or -1) .. ' ' .. (Entity(entity).state.rightCones or -1))
	end
end)