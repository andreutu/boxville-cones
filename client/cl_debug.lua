if Config.Debug then
	RegisterCommand('cancelEmote', function()
		CancelEmote()
	end, false)
end