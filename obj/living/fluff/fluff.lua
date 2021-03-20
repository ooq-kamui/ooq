log.scrpt("fluff.lua")

Fluff = {
	act_intrvl_time = 14,
	name_idx_max = 1,

	foot_dst_i = 20,
	speed = 2, -- 50,
}
Fluff.cls = "fluff"
Fluff.fac = Obj.fac..Fluff.cls
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
	extend.init(_s, Hldabl)
	extend._(_s, Fluff)
end

-- script method

function Fluff.upd(_s, dt)

	_s:act_intrvl(dt)

	-- local vec = _s:vec_mv_living(dt)
	_s:vec_mv__(dt)

	_s:pos__add(_s._vec_mv)

	_s:upd_final()
end

function Fluff.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- log._("fluff act_intrvl")
	
	-- death
	if _s:per_trnsf(1, Humus) then return end

	-- trnsf
	if _s:per_trnsf(5, Seed) then return end

	-- obj cre
	dice100.throw()
	if     dice100.chk(10) then
		Seed.cre()
	end
	
	_s:moving_prp__rnd()
end

function Fluff.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Fluff.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

