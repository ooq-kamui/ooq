log.scrpt("pc.lua")

Pc = {
	act_intrvl_time = 7,
	name_idx_max = 1,
	z = 0.1,

	weight = 2,
}
Pc.cls = "pc"
Pc.fac = Obj.fac..Pc.cls
Cls.add(Pc)

-- static

function Pc.cre(p_pos, prm)
	local t_Cls = Pc
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- script method

function Pc.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Pc)
end

function Pc.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Pc.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:upd_pos_static()

	_s:upd_final()
end

function Pc.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	
end

function Pc.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	
	if ha.eq(msg_id, "opn") then
		_s:opn()
	end
end

function Pc.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Pc.opn(_s)
	log._("pc opn")
	fac.cre("#fac_pc_gui")
end

