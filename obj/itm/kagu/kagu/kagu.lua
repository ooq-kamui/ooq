log.scrpt("kagu.lua")

Kagu = {
	act_intrvl_time = 10,
	name_idx_max = 104,
	z = 0.1,
}
Kagu.cls = "kagu"
Kagu.fac = Obj.fac..Kagu.cls
Cls.add(Kagu)

-- static

function Kagu.cre(p_pos, prm)
	local Cls = Kagu
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Kagu.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Kagu)
end

function Kagu.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Kagu.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	
end

function Kagu.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Kagu.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

