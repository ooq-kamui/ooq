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

function Mshrm.cre(pos, prm)
	local Cls = Mshrm
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Mshrm.init(_s)

	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(   _s, Mshrm)
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

function Mshrm.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
	Hldabl.on_msg(_s, msg_id, prm, sender)
end

function Mshrm.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end
