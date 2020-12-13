log.script("cloud.lua")

Cloud = {
	act_interval_time = 10,
	name_idx_max = 1,
	speed = 50,
}
Cloud.pos_init = n.vec(300, 300)

Cloud.cls = "cloud"
Cloud.fac = Cloud.cls.."Fac"
Cloud.Fac = Obj.fac..Cloud.cls
Cls.add(Cloud)

-- static

function Cloud.cre(pos, prm)
	local Cls = Cloud
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Cloud.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Livingmove)
	extend.init(_s, Holdable)
	extend._(_s, Cloud)
end

-- script method

function Cloud.upd(_s, dt)

	_s:act_interval(dt)

	local vec = _s:vec_mv_living(dt)
	log._("cloud.upd", vec)
	_s:pos__add(vec)
end

function Cloud.act_interval(_s, dt)
	-- log._("Cloud.act_interval", _s._id)

	if not _s:is_loop__act_interval__(dt) then return end
	
	dice100.throw()
	if not Map.chara_is_appear_all() and dice100.chk(7) then
		Chara.cre()
	elseif dice100.chk(4) then
		Animal.cre()
	elseif dice100.chk(1) then
		Veget.cre()
	elseif dice100.chk(1) then
		Seed.cre()
	elseif dice100.chk(1) then
		Fish.cre()
	end

	-- _s._speed = rnd.int(10, 50)
	_s:moving_prp__rnd()
end

function Cloud.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
	Holdable.on_msg(_s, msg_id, prm, sender)
end

function Cloud.final(_s)
	Sp.final(_s)
	Holdable.final(_s)
end
