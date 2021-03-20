log.scrpt("pc.lua")

Pc = {
	act_intrvl_time = 7,
	name_idx_max = 1,
	z = 0.1,
}
Pc.cls = "pc"
Pc.fac = Obj.fac..Pc.cls
Cls.add(Pc)

-- static

function Pc.cre(pos, prm)
	local Cls = Pc
	local t_id = Sp.cre(Cls, pos)
	return t_id
end

-- script method

function Pc.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Pc)
end

function Pc.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Pc.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	
end

function Pc.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
	
	if ha.eq(msg_id, "opn") then
		_s:opn()
	end
end

function Pc.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

-- method

function Pc.opn(_s)
	log._("pc opn")
	fac.cre("#fac_pc_gui")
end

