log.scrpt("parasail.lua")

Parasail = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,
}
Parasail.cls = "parasail"
Parasail.fac = Obj.fac..Parasail.cls
Cls.add(Parasail)

-- static

function Parasail.cre(p_pos, prm)
	local Cls = Parasail
	prm = prm or {}
	if not prm.animHa then prm.animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Parasail.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Airride)
	extend._(   _s, Parasail)
end

function Parasail.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Parasail.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	-- death
end

function Parasail.on_msg(_s, msg_id, prm, sndr)

	Sp.on_msg(    _s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Parasail.final(_s)

	Sp.final(    _s)
	Hldabl.final(_s)
end

