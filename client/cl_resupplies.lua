local function createResupplyBox(index)
	local x, y, z, w = table.unpack(Config.ResupplyPoints[tonumber(index)])

	RequestModel(Config.RessuplyPointsProp)

	while not HasModelLoaded(Config.RessuplyPointsProp) do
		Wait(0)
	end

	local obj = CreateObject(Config.RessuplyPointsProp, x, y, z, true, true, false)
	SetEntityHeading(obj, w)
	PlaceObjectOnGroundProperly(obj)
end

RegisterCommand('createRessuplyPoint', function(source, args)
	createResupplyBox(args[1])
end, false)
