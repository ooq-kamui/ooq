log.scrpt("gold.lua")

Ply_data._gold = 0

function Ply_data.gold()
	return Ply_data._gold
end

function Ply_data.gold__(gold)
	Ply_data._gold = gold
end

function Ply_data.gold__add(gold)
	Ply_data._gold = Ply_data._gold + gold
end

function Ply_data.gold__sub(gold)
	Ply_data._gold = Ply_data._gold - gold
end

