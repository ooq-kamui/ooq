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
	
	for idx, t_cls in pairs(Ply_data.zu.cls) do
		data[t_cls] = Ply_data.zu.xxx._(Ply_data._zu[t_cls])
	end
	return data
end

function Ply_data.zu.xxx._(p_ar)

	local data = {}

	for t_name, val in pairs(p_ar) do
		data[t_name] = val
	end
	return data
end

function Ply_data.zu.__(data)
	-- log.pp("Ply_data.zu.__", Ply_data.zu.cls)

	for idx, cls in pairs(Ply_data.zu.cls) do
		Ply_data.zu.xxx.__(data, cls, Ply_data._zu[cls])
	end
end

function Ply_data.zu.xxx.__(data, p_cls, p_ar)

	ar.clr(p_ar)

	if not data["zu"][p_cls] then return end

	for t_name, val in pairs(data["zu"][p_cls]) do
		p_ar[t_name] = val
	end
end

function Ply_data.zu.clr()

	for idx, cls in pairs(Ply_data.zu.cls) do
		ar.clr(Ply_data._zu[cls])
	end
end

