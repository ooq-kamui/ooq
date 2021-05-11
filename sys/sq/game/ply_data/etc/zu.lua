log.scrpt("zu.lua")

Ply_data.zu = {

	cls = {
		"flower",
		"dish",
		"anml",
	},

	_zu = {},
}
for idx, cls in pairs(Ply_data.zu.cls) do
	Ply_data.zu._zu[cls] = {}
end

function Ply_data.zu._(p_cls)
	
	local data

	if not p_cls then
		data = Ply_data.zu._zu
	else
		data = Ply_data.zu._zu[p_cls]
	end
	return data
end

function Ply_data.zu.__(save_data)

	Ply_data.zu._zu = save_data
end

function Ply_data.zu.cls__(p_cls, save_data_cls)

	Ply_data.zu._zu[p_cls] = save_data_cls
end

function Ply_data.zu.__init()

	for idx, cls in pairs(Ply_data.zu.cls) do
		Ply_data.zu._zu[cls] = {}
	end
end

function Ply_data.zu.__clr()

	for idx, t_cls in pairs(Ply_data.zu.cls) do
		ar.clr(Ply_data.zu._zu[t_cls])
	end
end

