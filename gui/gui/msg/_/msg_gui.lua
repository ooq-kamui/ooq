log.script("msg_gui.lua")

g.Msg = {
	act_interval_time = 3,
}

function g.Msg.init(_s)
	-- log._("g msg init")

	extend.init(_s, g.Gui)
	extend._(_s, g.Msg)

	_s._prt.msg = p.Msg.cre(_s)

	_s:opn("msg")
end

function g.Msg.on_msg(_s, msg_id, prm, sender)
	-- log._("g msg on_msg", msg_id)

	g.Gui.on_msg(_s, msg_id, prm, sender)

	if ha.eq(msg_id, "itm__add") then
		_s:itm__add(prm.itm)
	end
end

function g.Msg.itm__add(_s, itm)
	-- log._("g msg itm__add", itm)

	_s:actv_prt():itm__add(itm)
end

function g.Msg.del(_s)
	-- log._("g msg del")

	g.Gui.del(_s)
	
	pst._("/sys#script", "msg_id__del")
end
