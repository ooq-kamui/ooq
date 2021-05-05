log.scrpt("mshrm.lua")

Mshrm = {
	act_intrvl_time = 15,
	name_idx_max = 100,
	foot_dst_i = 30,
}
Mshrm.cls = "mshrm"
Mshrm.fac = Obj.fac..Mshrm.cls
Cls.add(Mshrm)

-- static

function Mshrm.cre(p_pos, prm)
	local t_Cls = Mshrm
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Mshrm.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Mshrm)
end

function Mshrm.__init(_s, prm)

	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Mshrm.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Mshrm.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf(1 / 10 * 100, Humus) then return end

	dice100.throw()
	if     dice100.chk(15) then
		-- empty -- _s:trnsf(Veget)
	end
end

function Mshrm.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Mshrm.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

