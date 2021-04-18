log.scrpt("broom.lua")

Broom = {
	act_intrvl_time = 10,
	name_idx_max    =  1,
}
Broom.cls = "broom"
Broom.fac = Obj.fac..Broom.cls
Cls.add(Broom)

-- static

function Broom.cre(p_pos, prm)
	local Cls = Broom
	prm = prm or {}
	if not prm.animHa then prm.animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Broom.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(   _s, Broom)
end

function Broom.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Broom.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death

end

function Broom.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(    _s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Broom.final(_s)
	Sp.final(    _s)
	Hldabl.final(_s)
end

