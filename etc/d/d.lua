log.script("d.lua")

D = {
	chara = nil,
	txt = {},
}

function D.c(chara)
	-- log._("D c")
	
	D.chara = chara
	--[[
	local dia_id = Game.dia_id()
	pst.gui(dia_id, "chara__", {chara = chara})
	--]]
end

function D._(txt)
	D.txt__add(txt)
end

function D.o(txt)

	D._(txt)

	local t_url = url._(Game.id(), "fac_dia_gui")
	local t_id = fac.cre(t_url)
	pst.gui(t_id, "chara__", {chara = D.chara})
	return t_id
end

function D.txt__add(txt)
	ar.add(D.txt, txt)
end

function D.txt__del_1()
	ar.del_1(D.txt)
end
