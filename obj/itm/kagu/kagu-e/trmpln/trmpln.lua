log.scrpt("trmpln.lua")

Trmpln = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,

	jmp_lv = 7,
}
Trmpln.cls = "trmpln"
Trmpln.fac = Obj.fac..Trmpln.cls
Cls.add(Trmpln)

-- static

function Trmpln.cre(p_pos, prm)
	local Cls = Trmpln
	prm = prm or {}
	if not prm.animHa then prm.animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Trmpln.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(   _s, Trmpln)
end

function Trmpln.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Trmpln.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death

end

function Trmpln.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Trmpln.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

