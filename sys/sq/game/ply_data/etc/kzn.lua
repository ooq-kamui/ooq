log.scrpt("kzn.lua")

Ply_data.kzn = {}
Ply_data.kzn._kzn = {}

function Ply_data.kzn._()

	local data = Ply_data.kzn._kzn
	return data
end

function Ply_data.kzn.__save_data(save_data)
	
	Ply_data.kzn._kzn = save_data
end

function Ply_data.kzn.__pls(chara, point)

	point = point or Mstr.kzn.point

	if not Ply_data.kzn._kzn[chara] then
		Ply_data.kzn._kzn[chara] = 0
	end

	Ply_data.kzn._kzn[chara] = Ply_data.kzn._kzn[chara] + point
end

function Ply_data.kzn.__clr()
	ar.clr(Ply_data.kzn._kzn)
end

