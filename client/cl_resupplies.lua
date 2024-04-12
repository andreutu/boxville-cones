function createResupplyBox(index)
	local x, y, z = table.unpack(Config.ResupplyPoints[tonumber(index)])
	local prop = `prop_devin_box_01`

	RequestModel(prop)

	while not HasModelLoaded(prop) do
		Wait(0)
	end

	local obj = CreateObject(prop, x, y, z, true, true, false)
	PlaceObjectOnGroundProperly(obj)
end

RegisterCommand('createRessuplyPoint', function(source, args)
	createResupplyBox(args[1])
end, false)
