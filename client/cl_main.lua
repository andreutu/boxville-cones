exports['qb-target']:AddTargetBone("cone_l", {
	options = {
		{
			type = "client",
			event = "boxville-cones:leftCone",
			icon = Config.Icon,
			label = Config.Label,
			targeticon = Config.TargetIcon,
		}
	},
	distance = Config.Distance,
})

exports['qb-target']:AddTargetBone("cone_r", {
	options = {
		{
			type = "client",
			event = "boxville-cones:rightCone",
			icon = Config.Icon,
			label = Config.Label,
			targeticon = Config.TargetIcon,
		}
	},
	distance = Config.Distance,
})

RegisterNetEvent('boxville-cones:leftCone')
AddEventHandler('boxville-cones:leftCone', function()
	print("cone_l taken")
end)

RegisterNetEvent('boxville-cones:rightCone')
AddEventHandler('boxville-cones:rightCone', function()
	print("cone_r taken")
end)
