log.scrpt("msg_gui.lua")

g.Msg = {
	act_intrvl_time = 3,
}

function g.Msg.init(_s)
	-- log._("g msg init")

	extnd.init(_s, g.Gui)
	extnd._(   _s, g.Msg)

	_s._prt.msg = p.Msg.cre(_s)

	_s:opn("msg")
end

function g.Msg.on_msg(_s, msg_id, prm, sndr_url)
	-- log._("g msg on_msg", msg_id)

	g.Gui.on_msg(_s, msg_id, prm, sndr_url)

	if     ha.eq(msg_id, "itm__add"   ) then
		_s:itm__add(prm.itm)

	elseif ha.eq(msg_id, "base_pos__" ) then
		_s:base_pos__()

	elseif ha.eq(msg_id, "base_pos__d") then
		_s:base_pos__d()
	end
end

function g.Msg.itm__add(_s, itm)
	log._("g.Msg.itm__add", itm)

	_s:actv_prt():itm__add(itm)
end

function g.Msg.base_pos__(_s)
	-- log._("g msg base_pos__")

	_s:actv_prt():base_pos__()
end

function g.Msg.base_pos__d(_s)
	-- log._("g msg base_pos__d")

	_s:actv_prt():base_pos__d()
end

function g.Msg.del(_s)
	-- log._("g msg del")

	g.Gui.del(_s)
	
	pst._("/sys#script", "msg_id__del")
end

