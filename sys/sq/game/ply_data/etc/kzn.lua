log.scrpt("kzn.lua")

Ply_data._kzn = {}
Ply_data.kzn  = {}

function Ply_data.kzn._()

	local data = {}
	for charaHa, point in pairs(Ply_data._kzn) do
		data[ha.de(charaHa)] = point
	end
	-- log._("kzn")
	-- pprint(Kzn_gui.kzn)
	-- pprint(data)
	return data
end

function Ply_data.kzn.__(data)
	
	ar.clr(Ply_data._kzn)
	
	for chara, point in pairs(data["kzn"]) do
		Ply_data._kzn[ha._(chara)] = point
	end
	-- log._("load kzn")
	-- pprint(data["kzn"])
	-- pprint(Kzn_gui.kzn)
end
