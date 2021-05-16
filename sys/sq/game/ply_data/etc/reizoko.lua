log.scrpt("reizoko.lua")

Ply_data.reizoko       = {}
Ply_data.reizoko._data = {}
Ply_data._reizoko = Ply_data.reizoko._data -- old

function Ply_data.reizoko._()

	return Ply_data.reizoko._data
end

function Ply_data.reizoko.save_data()

	local data = Ply_data.reizoko._()

	-- log.pp("Ply_data.reizoko.save_data", data)
	return data
end

function Ply_data.reizoko.__add(prm)
	-- log._("Ply_data.reizoko.__add")

	local t_cls  = prm._cls
	local t_name = prm._name

	local data = Ply_data.reizoko._data

	if not data[t_cls]         then data[t_cls]         = {} end

	if not data[t_cls][t_name] then data[t_cls][t_name] = 0  end

	data[t_cls][t_name] = data[t_cls][t_name] + 1

	-- Se.pst_ply("psh")
end

function Ply_data.reizoko.__new()

	local t_name

	for idx = 1, 50 do

		t_name = "veget"..int.pad(idx)
		Ply_data.reizoko.__add({_cls = "veget", _name = t_name})
	end
end

function Ply_data.reizoko.__save_data(data)

	Ply_data.reizoko.__clr()

	-- for t_cls, t_name_ar in pairs(data["reizoko"]) do
	for t_cls, t_name_ar in pairs(data) do

		for t_name, cnt in pairs(t_name_ar) do

			for i = 1, cnt do
				Ply_data.reizoko.__add({_cls = t_cls, _name = t_name})
			end
		end
	end

	-- log.pp("Ply_data.reizoko.__save_data", Ply_data.reizoko._())
end

function Ply_data.reizoko.__clr()

	-- ar.clr(Ply_data._reizoko)
	ar.clr(Ply_data.reizoko._data)
end

