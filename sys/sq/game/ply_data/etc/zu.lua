log.scrpt("zu.lua")

Ply_data._zu = {
	
	anml   = {},
	flower = {},
	dish   = {},
}
Ply_data.zu = {
	cls = {
		"anml",
		"flower",
		"dish",
	},
}
Ply_data.zu.xxx = {}

function Ply_data.zu._()
	
	local data = {}
	
	for idx, cls in pairs(Ply_data.zu.cls) do
		data[cls] = Ply_data.zu.xxx._(Ply_data._zu[cls])
	end
	return data
end

function Ply_data.zu.xxx._(p_ar)
	local name
	local data = {}
	for nameHa, val in pairs(p_ar) do
		name = ha.de(nameHa)
		data[name] = val
	end
	return data
end

function Ply_data.zu.__(data)
	-- log.pp("Ply_data.zu.__", Ply_data.zu.cls)

	for idx, cls in pairs(Ply_data.zu.cls) do
		Ply_data.zu.xxx.__(data, cls, Ply_data._zu[cls])
	end
end

function Ply_data.zu.xxx.__(data, cls, p_ar)

	ar.clr(p_ar)

	if not data["zu"][cls] then return end

	for name, val in pairs(data["zu"][cls]) do
		p_ar[ha._(name)] = val
	end
end

function Ply_data.zu.clr()

	for idx, cls in pairs(Ply_data.zu.cls) do
		ar.clr(Ply_data._zu[cls])
	end
end
