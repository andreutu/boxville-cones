if Config.Debug then
	RegisterCommand('cancelEmote', function(source)
		if source == 0 then
			return print("You can't use this command in the console!")
		end

		TriggerClientEvent('boxville-cones:client:placeConeInVan', source)
	end, false)
end

RegisterNetEvent('boxville-cones:debugPrint', function(prefix, text)
	print('\x1b[32m[boxville-cones:' .. prefix .. ']\x1b[0m ' .. text)
end)
