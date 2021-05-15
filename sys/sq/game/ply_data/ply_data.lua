log.scrpt("ply_data.lua")

Ply_data = {}

function Ply_data.save_data()

	local data = {}

	data["ver"] = file.ver
	
	data["plyr"] = {}
	data["plyr"]["dstrct"] = Game.dstrct()
	data["plyr"]["pos"]    = Game.plychara_pos()
	
	data["gold"] = Ply_data.gold()

	data["reizoko"] = Ply_data.reizoko.save_data()
	data["zu"]      = Ply_data.zu._()
	data["kzn"]     = Ply_data.kzn._()

	return data
end

function Ply_data.__save_data(data)

	-- log._("Ply_data.__save_data ver"..data["ver"])

	Ply_data.gold__(data["gold"])

	Ply_data.reizoko.__save_data(data)
	Ply_data.zu.__(data["zu"])
	Ply_data.kzn.__save_data(data["kzn"])
end

-- static public

function Ply_data.save(ply_slt_idx)

	if not ply_slt_idx then return end

	Msg.s("saving...")

	local data = Ply_data.save_data()

	file.ts__()
	
	file.ply_data.save(ply_slt_idx, data)
	
	local ply_data_ltst_ts = file.ts()

	Msg.s("save complete")

	return ply_data_ltst_ts
end

function Ply_data.load(ply_slt_idx, file_idx)
	
	local data = file.ply_data.load(ply_slt_idx, file_idx)

	Ply_data.__save_data(data)

	return data
end

function Ply_data.__new()

	Ply_data.__clr()
end

function Ply_data.__clr()

	Ply_data.gold__(0)

	Ply_data.reizoko.__clr()
	Ply_data.zu.__clr()
	Ply_data.kzn.__clr()
end

