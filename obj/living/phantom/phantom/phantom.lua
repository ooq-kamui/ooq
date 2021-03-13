log.scrpt("phantom.lua")

Phantom = {
	act_intrvl_time = 10,
	name_idx_max = 1,
}
Phantom.cls = "phantom"
Phantom.fac = Phantom.cls.."Fac"
Phantom.Fac = Obj.fac..Phantom.cls
Cls.add(Phantom)

-- static

function Phantom.cre(p_pos, prm)
	local Cls = Phantom
	prm = prm or {}
	prm.anim = prm.anim or ha._("stand")
	-- if not prm.anim  then prm.anim  = ha._("stand") end
	local id = Sp.cre(Cls, p_pos, prm)
	return id
end

-- script method

function Phantom.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Phantom)

	-- _s._vec_mv = n.vec(0, 0.5)
	vec.xy__(_s._vec_mv, 0, 0.5)
end

function Phantom.upd(_s, dt)

	_s:act_intrvl(dt)

	_s._vec_total = _s._vec_mv

	_s:pos__add(_s._vec_total)

	_s:upd_final()
end

function Phantom.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 10 * 100, Fire) then return end

	if _s:per_del(1 / 20 * 100) then return end


end

function Phantom.on_msg(_s, msg_id, prm, sender)
end

function Phantom.final(_s)
	Sp.final(_s)
end

