log.script("mshrm.lua")

Mshrm = {
	act_interval_time = 15,
	name_idx_max = 100,
	foot_dst_i = 30,
}
Mshrm.cls = "mshrm"
Mshrm.Fac = Obj.fac..Mshrm.cls
Cls.add(Mshrm)

-- static

function Mshrm.cre(pos)
	local Cls = Mshrm
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Mshrm.init(_s)

	extend.init(_s, Sp)
	extend.init(_s, Holdable)
	extend._(_s, Mshrm)
end

function Mshrm.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Mshrm.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	if _s:per_trnsf(1 / 10 * 100, Humus) then return end

	dice100.throw()
	if     dice100.chk(15) then
		-- empty -- _s:trnsf(Veget)
	end
end

function Mshrm.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
	Holdable.on_msg(_s, msg_id, prm, sender)
end

function Mshrm.final(_s)
	Sp.final(_s)
end
