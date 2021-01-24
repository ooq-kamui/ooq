log.script("dia_gui.lua")

g.Dia = {}

-- static

function g.Dia.cre()

	local game_id = Game.id()

	if ha.is_emp(game_id) then return end

	local dia_url = url._(game_id, "fac_dia_gui")
	local dia_id  = fac.cre(dia_url)
	return dia_id
end

-- script method

function g.Dia.init(_s)
	-- log._("gui dia init")

	extend.init(_s, g.Gui)
	extend._(_s, g.Dia)

	_s._prt.dia = p.Dia.cre(_s)

	_s:opn("dia")
end

function g.Dia.on_msg(_s, msg_id, prm, sender)
	-- log._("g.dia on_msg", msg_id)

	g.Gui.on_msg(_s, msg_id, prm, sender)
	
	if ha.eq(msg_id, "chara__") then
		_s:chara__(prm.chara)
	end
end

function g.Dia.chara__(_s, chara)
	_s:actv_prt():chara__(chara)
end

function g.Dia.del(_s)
	log._("g.dia del")

	g.Gui.del(_s)

	pst._("#script", "game_dia__clr")
end

