log.scrpt("parasol.lua")

Parasol = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,
}
Parasol.cls = "parasol"
Parasol.fac = Obj.fac..Parasol.cls
Cls.add(Parasol)

-- static

function Parasol.cre(p_pos, prm)
	local Cls = Parasol
	prm = prm or {}
	if not prm.animHa then prm.animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Parasol.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Airride)
	extend._(   _s, Parasol)
end

function Parasol.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Parasol.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	-- death
end

function Parasol.on_msg(_s, msg_id, prm, sndr)

	Sp.on_msg(    _s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Parasol.final(_s)

	Sp.final(    _s)
	Hldabl.final(_s)
end

