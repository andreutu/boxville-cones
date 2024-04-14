function createResupplyBox(index)
	local x, y, z, w = table.unpack(Config.ResupplyPoints[tonumber(index)])
	local prop = `cprop_box_cones`

	RequestModel(prop)

	while not HasModelLoaded(prop) do
		Wait(0)
	end

    local obj = CreateObject(prop, x, y, z, true, true, false)
	SetEntityHeading(obj, w)
	PlaceObjectOnGroundProperly(obj)
end

RegisterCommand('createRessuplyPoint', function(source, args)
	createResupplyBox(args[1])
end, false)
