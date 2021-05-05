log.scrpt("reizoko.lua")

Ply_data._reizoko = {}
Ply_data.reizoko  = {}

function Ply_data.reizoko._()

	local nameHaMap, name
	local data = {}
	for clsHa, nameHaCnts in pairs(Ply_data._reizoko) do
		local cls = Cls._(clsHa).cls

		nameHaMap = {}
		for idx = 1, Cls._(clsHa).name_idx_max do
			name = Cls._(clsHa).cls..int.pad(idx, 3)
			nameHaMap[ha._(name)] = name
		end

		data[cls] = {}
		for nameHa, cnt in pairs(nameHaCnts) do
			name = nameHaMap[nameHa]
			data[cls][name] = cnt
		end
	end
	-- log._("save reizoko", data)
	-- pprint(Ply_data._reizoko)
	-- pprint(data)
	return data
end

function Ply_data.reizoko.__add(prm)
	-- u.log("reizoko add()", food_id)

	local txtr = prm.clsHa
	local anim = prm.nameHa
	local reizoko = Ply_data._reizoko

	if not reizoko[txtr]       then reizoko[txtr]       = {} end
	if not reizoko[txtr][anim] then reizoko[txtr][anim] = 0  end

	reizoko[txtr][anim] = reizoko[txtr][anim] + 1

	Se.pst_ply("psh")
end

function Ply_data.reizoko.__new()

	local anim
	for idx = 1, 50 do
		anim = "veget"..int.pad(idx)
		Ply_data.reizoko.__add({clsHa = ha._("veget"), nameHa = ha._(anim)})
	end
end

function Ply_data.reizoko.__(data)

	ar.clr(Ply_data._reizoko)
	for cls, names in pairs(data["reizoko"]) do
		for name, cnt in pairs(names) do
			for i = 1, cnt do
				Ply_data.reizoko.__add({clsHa = ha._(cls), nameHa = ha._(name)})
			end
		end
	end
	-- log
	-- log._("load reizoko")
	-- pprint(data["reizoko"])
	-- pprint(Ply_data._reizoko)
end

