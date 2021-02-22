log.scrpt("dia.lua")

Dia = {
	chara = nil,
	txt   = {},
}

function Dia.chara__(chara)
	-- log._("dia chara__")
	
	Dia.chara = chara
end

function Dia.txt__add(txt)

	ar.add(Dia.txt, txt)
end

function Dia.txt__add__v(txt)

	ar.add(Dia.txt, txt)
end

function Dia.txt__add__x(txt)

	Dia.txt__add(txt)

	local game_id = Game.id()

	if ha.is_emp(game_id) then return end

	pst._(game_id, "dia__opn")
end

-- alias

D   = Dia
D.c = Dia.chara__
D._ = Dia.txt__add
D.v = Dia.txt__add__v
D.x = Dia.txt__add__x

