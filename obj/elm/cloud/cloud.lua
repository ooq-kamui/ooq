log.scrpt("cloud.lua")

Cloud = {
	act_intrvl_time = 10,
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
	extend.init(_s, Hldabl)
	extend._(_s, Cloud)
end

-- script method

function Cloud.upd(_s, dt)

	_s:act_intrvl(dt)

	local vec = _s:vec_mv_living(dt)
	-- log._("cloud.upd", vec)

	_s:pos__add(vec)

	_s:upd_final()
end

function Cloud.act_intrvl(_s, dt)
	-- log._("Cloud.act_intrvl", _s._id)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	dice100.throw()
	if not Map.chara_is_appear_all() and dice100.chk(30) then
		Chara.cre()
	elseif dice100.chk(4) then
		Anml.cre()
	elseif dice100.chk(1) then
		Veget.cre()
	elseif dice100.chk(1) then
		Seed.cre()
	elseif dice100.chk(1) then
		Fish.cre()
	end

	_s:moving_prp__rnd()
	-- log._("cloud _dir_h", _s._dir_h)
end

function Cloud.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
	Hldabl.on_msg(_s, msg_id, prm, sender)
end

function Cloud.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end
