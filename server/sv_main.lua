local cones = {}
local spawnedResupplyPoints = false

RegisterNetEvent("boxville-cones:server:placeConeInVan", function(vehicle, stack)
	local entity = NetworkGetEntityFromNetworkId(vehicle)
	local amount

	if stack == "left" then
		amount = Entity(entity).state.leftCones or Config.DefaultLeftCones

		if amount < Config.DefaultLeftCones then
			Entity(entity).state.leftCones = amount + 1
			TriggerClientEvent('boxville-cones:client:placeConeInVan', source, entity, stack)
		else
			return
		end
	elseif stack == "right" then
		amount = Entity(entity).state.rightCones or Config.DefaultRightCones

		if amount < Config.DefaultRightCones then
			Entity(entity).state.rightCones = amount + 1
			TriggerClientEvent('boxville-cones:client:placeConeInVan', source, entity, stack)
		else
			return
		end
	end

	if amount == 0 then
		TriggerClientEvent("boxville-cones:client:toggleCones", NetworkGetEntityOwner(entity), vehicle, stack, false)
	end

	if Config.Debug then
		local text = (Entity(entity).state.leftCones or -1) .. ' ' .. (Entity(entity).state.rightCones or -1)
		TriggerEvent('boxville-cones:debugPrint', 'PLACELOG', text)
	end
end)

RegisterNetEvent("boxville-cones:server:takeCone", function(vehicle, stack)
	local entity = NetworkGetEntityFromNetworkId(vehicle)
	local amount

	if stack == "left" then
		amount = Entity(entity).state.leftCones or Config.DefaultLeftCones

		if amount > 0 then
			Entity(entity).state.leftCones = amount - 1
			TriggerClientEvent('boxville-cones:client:takeCone', source, entity, stack)
		else
			return
		end
	elseif stack == "right" then
		amount = Entity(entity).state.rightCones or Config.DefaultRightCones

		if amount > 0 then
			Entity(entity).state.rightCones = amount - 1
			TriggerClientEvent('boxville-cones:client:takeCone', source, entity, stack)
		else
			return
		end
	end

	if amount - 1 == 0 then
		TriggerClientEvent("boxville-cones:client:toggleCones", NetworkGetEntityOwner(entity), vehicle, stack, true)
	end

	if Config.Debug then
		local text = (Entity(entity).state.leftCones or -1) .. ' ' .. (Entity(entity).state.rightCones or -1)
		TriggerEvent('boxville-cones:debugPrint', 'TAKELOG', text)
	end
end)

RegisterNetEvent('boxville-cones:server:addTarget', function(netId)
	table.insert(cones, netId)
	TriggerClientEvent('boxville-cones:client:addTarget', -1, netId)
end)

RegisterNetEvent('boxville-cones:server:deleteCone', function(netId)
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
	TriggerClientEvent('boxville-cones:client:deleteCone', NetworkGetEntityOwner(entity), netId)
end)

RegisterNetEvent('boxville-cones:server:loadCones', function()
	for _, netId in ipairs(cones) do
		if DoesEntityExist(NetworkGetEntityFromNetworkId(netId)) == 1 then
			TriggerClientEvent('boxville-cones:client:addTarget', source, netId)
		end
	end
end)

AddEventHandler('playerJoining', function()
	if spawnedResupplyPoints then return end

	for _, data in ipairs(Config.ResupplyPoints) do
		local x, y, z, w = table.unpack(data)
		local obj = CreateObject(Config.RessuplyPointsProp, x, y, z - 1, true, false, true)
		SetEntityHeading(obj, w)
	end

	spawnedResupplyPoints = true
end)
