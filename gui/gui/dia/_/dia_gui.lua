log.script("dia_gui.lua")

g.Dia = {}

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
