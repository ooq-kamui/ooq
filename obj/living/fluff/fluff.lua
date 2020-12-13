log.script("fluff.lua")

Fluff = {
	act_interval_time = 14,
	name_idx_max = 1,

	foot_dst_i = 20,
	speed = 50,
}
Fluff.cls = "fluff"
Fluff.Fac = Obj.fac..Fluff.cls
Cls.add(Fluff)

-- ar.idx_2_ha(Fluff.gold, "fluff")

-- static

function Fluff.cre(pos, prm)
	local Cls = Fluff
	local id = Sp.cre(Cls, pos, prm)
	return id
end

function Fluff.init(_s)

	extend.init(_s, Sp)
	extend.init(_s, Livingmove)
	extend.init(_s, Holdable)
	extend._(_s, Fluff)
end

-- script method

function Fluff.upd(_s, dt)

	_s:act_interval(dt)

	local vec = _s:vec_mv_living(dt)
	-- log._("fluff vec", vec)
	_s:pos__add(vec)
end

function Fluff.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_trnsf(1, Humus) then return end

	-- trnsf
	if _s:per_trnsf(5, Seed) then return end

	
	_s:moving_prp__rnd()
end

function Fluff.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
	Holdable.on_msg(_s, msg_id, prm, sender)
end

function Fluff.final(_s)
	Sp.final(_s)
	Holdable.final(_s)
end
