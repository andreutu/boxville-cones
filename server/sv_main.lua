local cones = {}

RegisterNetEvent("boxville-cones:server:PlaceConeInVan", function(vehicle, stack)
	local entity = NetworkGetEntityFromNetworkId(vehicle)
	local amount

	if stack == "left" then
		amount = Entity(entity).state.leftCones or Config.DefaultLeftCones

		if amount < Config.DefaultLeftCones then
			Entity(entity).state.leftCones = amount + 1
			TriggerClientEvent('boxville-cones:client:PlaceConeInVan', source, entity, stack)
		else
			return
		end
	elseif stack == "right" then
		amount = Entity(entity).state.rightCones or Config.DefaultRightCones

		if amount < Config.DefaultRightCones then
			Entity(entity).state.rightCones = amount + 1
			TriggerClientEvent('boxville-cones:client:PlaceConeInVan', source, entity, stack)
		else
			return
		end
	end

	if amount == 0 then
		TriggerClientEvent("boxville-cones:client:ToggleCones", NetworkGetEntityOwner(entity), vehicle, stack, false)
	end

	if Config.Debug then
		local text = (Entity(entity).state.leftCones or -1) .. ' ' .. (Entity(entity).state.rightCones or -1)
		TriggerEvent('boxville-cones:DebugPrint', 'PLACELOG', text)
	end
end)

RegisterNetEvent("boxville-cones:server:TakeCone", function(vehicle, stack)
	local entity = NetworkGetEntityFromNetworkId(vehicle)
	local amount

	if stack == "left" then
		amount = Entity(entity).state.leftCones or Config.DefaultLeftCones

		if amount > 0 then
			Entity(entity).state.leftCones = amount - 1
			TriggerClientEvent('boxville-cones:client:TakeCone', source, entity, stack)
		else
			return
		end
	elseif stack == "right" then
		amount = Entity(entity).state.rightCones or Config.DefaultRightCones

		if amount > 0 then
			Entity(entity).state.rightCones = amount - 1
			TriggerClientEvent('boxville-cones:client:TakeCone', source, entity, stack)
		else
			return
		end
	end

	if amount - 1 == 0 then
		TriggerClientEvent("boxville-cones:client:ToggleCones", NetworkGetEntityOwner(entity), vehicle, stack, true)
	end

	if Config.Debug then
		local text = (Entity(entity).state.leftCones or -1) .. ' ' .. (Entity(entity).state.rightCones or -1)
		TriggerEvent('boxville-cones:DebugPrint', 'TAKELOG', text)
	end
end)

RegisterNetEvent('boxville-cones:server:AddTarget', function(netId)
	table.insert(cones, netId)
	TriggerClientEvent('boxville-cones:client:AddTarget', -1, netId)
end)

RegisterNetEvent('boxville-cones:server:DeleteCone', function(netId)
	local pos

	for index, id in ipairs(cones) do
		if id == netId then
			pos = index
			break
		end
	end

	if not pos then
		return
	end

	local entity = NetworkGetEntityFromNetworkId(netId)
	TriggerClientEvent('boxville-cones:client:DeleteCone', NetworkGetEntityOwner(entity), netId)
end)

RegisterNetEvent('boxville-cones:server:LoadCones', function()
	for _, netId in ipairs(cones) do
		if DoesEntityExist(NetworkGetEntityFromNetworkId(netId)) == 1 then
			TriggerClientEvent('boxville-cones:client:AddTarget', source, netId)
		end
	end
end)