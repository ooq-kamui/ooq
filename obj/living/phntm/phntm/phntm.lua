log.scrpt("phntm.lua")

Phntm = {
	act_intrvl_time = 10,
	name_idx_max    =  1,
}
Phntm.cls = "phntm"
Phntm.fac = Obj.fac..Phntm.cls
Cls.add(Phntm)

-- static

function Phntm.cre(p_pos, prm)

	local t_Cls = Phntm

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Phntm.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Phntm)
end

function Phntm.__init(_s, prm)
	
	prm._anim = prm._anim or "stand"

	Sp.__init(_s, prm)

	vec.xy__(_s._vec_mv, 0, 0.5)

	_s:upd__dly()
end

function Phntm.upd(_s, dt)

	-- _s:act_intrvl(dt)

	_s._vec_total = _s._vec_mv

	_s:pos__pls_vec_total()

	_s:upd_final()
end

function Phntm.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 10 * 100, Fire) then return end

	if _s:per_del(1 / 20 * 100) then return end


end

function Phntm.on_msg(_s, msg_id, prm, sndr_url)

	Sp.on_msg(_s, msg_id, prm, sndr_url)
end

function Phntm.final(_s)

	Sp.final(_s)
end

