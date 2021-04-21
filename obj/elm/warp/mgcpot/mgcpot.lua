log.scrpt("mgcpot.lua")

Mgcpot = {
	act_intrvl_time = 50,
	name_idx_max = 1,
}
Mgcpot.cls = "mgcpot"
Mgcpot.fac = Obj.fac..Mgcpot.cls
Cls.add(Mgcpot)

function Mgcpot.cre(p_pos, prm)
	local Cls = Mgcpot
	prm = prm or {}
	if not prm._animHa then prm._animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Mgcpot.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Warp)
	extend._(   _s, Mgcpot)
end

function Mgcpot.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Mgcpot.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
end

function Mgcpot.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(    _s, msg_id, prm, sndr)
	
	Hldabl.on_msg(_s, msg_id, prm, sndr)

	_s:on_msg_clsn(   msg_id, prm, sndr) -- warp
end

function Mgcpot.final(_s)

	Sp.final(    _s)
	Hldabl.final(_s)
end

