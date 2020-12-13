log.script("ply_data.lua")

Ply_data = {}

function Ply_data._()

	local data = {}

	data["ver"] = file.ver
	
	data["plyr"] = {}
	data["plyr"]["dstrct"] = Game.dstrct()
	data["plyr"]["pos"]    = Game.plychara_pos()
	
	data["gold"] = Ply_data.gold()

	data["reizoko"] = Ply_data.reizoko._()
	data["zu"]      = Ply_data.zu._()
	data["kzn"]     = Ply_data.kzn._()

	return data
end

function Ply_data.__(data)

	-- log._("Ply_data.__() ver:"..data["ver"])

	Ply_data.gold__(data["gold"])

	Ply_data.reizoko.__(data)
	Ply_data.zu.__(data)
	Ply_data.kzn.__(data)
end

-- static public

function Ply_data.save(ply_slt_idx)

	if not ply_slt_idx then return end

	local data = Ply_data._()

	file.ts__()
	
	file.ply_data.save(ply_slt_idx, data)
	
	local ply_data_ltst_ts = file.ts()

	Se.pst_ply("exe")
	Msg.s("save complete")
	return ply_data_ltst_ts
end

function Ply_data.load(ply_slt_idx, file_idx)
	
	local data = file.ply_data.load(ply_slt_idx, file_idx)
	Ply_data.__(data)
	return data
end

function Ply_data.new()
	Ply_data.clr()
end

function Ply_data.clr()

	Ply_data.gold__(0)

	ar.clr(Ply_data._reizoko)
	Ply_data.zu.clr()
	ar.clr(Ply_data._kzn)
end
