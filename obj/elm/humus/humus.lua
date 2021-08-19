log.scrpt("humus.lua")

Humus = {
	act_intrvl_time = 15,
	name_idx_max = 1,
}
Humus.cls = "humus"
Humus.fac = Obj.fac..Humus.cls
Cls.add(Humus)

-- static

function Humus.cre(p_pos)
	local t_Cls = Humus
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- script method

function Humus.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Humus)
end

function Humus.__init(_s, prm)
	
	Sp.__init(_s, prm)
end

function Humus.upd(_s, dt)
	
	-- _s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Humus.on_msg(_s, msg_id, prm, sndr_url)

	Sp.on_msg(_s, msg_id, prm, sndr_url)
end

function Humus.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_del(1 / 5 * 100) then return end

end

function Humus.final(_s)

	Sp.final(_s)
end

