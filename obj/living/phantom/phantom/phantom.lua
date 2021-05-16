log.scrpt("phantom.lua")

Phantom = {
	act_intrvl_time = 10,
	name_idx_max    =  1,
}
Phantom.cls = "phantom"
Phantom.fac = Obj.fac..Phantom.cls
Cls.add(Phantom)

-- static

function Phantom.cre(p_pos, prm)

	local t_Cls = Phantom

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Phantom.init(_s)

	extend._(_s, Sp)
	extend._(_s, Phantom)
end

function Phantom.__init(_s, prm)
	
	prm._anim = prm._anim or "stand"

	Sp.__init(_s, prm)

	vec.xy__(_s._vec_mv, 0, 0.5)
end

function Phantom.upd(_s, dt)

	_s:act_intrvl(dt)

	_s._vec_total = _s._vec_mv

	_s:pos__pls(_s._vec_total)

	_s:upd_final()
end

function Phantom.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 10 * 100, Fire) then return end

	if _s:per_del(1 / 20 * 100) then return end


end

function Phantom.on_msg(_s, msg_id, prm, sndr_url)

	Sp.on_msg(_s, msg_id, prm, sndr_url)
end

function Phantom.final(_s)

	Sp.final(_s)
end

