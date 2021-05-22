log.scrpt("cloud.lua")

Cloud = {
	act_intrvl_time = 10,
	name_idx_max    = 1,
	speed = 2, -- 50,
}
Cloud.pos_init = n.vec(300, 300)

Cloud.cls = "cloud"
Cloud.fac = Obj.fac..Cloud.cls
Cls.add(Cloud)

-- static

function Cloud.cre(p_pos, prm)
	local t_Cls = Cloud
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Cloud.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Livingmove)
	extnd._(_s, Hldabl)
	extnd._(_s, Cloud)
end

function Cloud.__init(_s, prm)
	
	Sp        .__init(_s, prm)
	Livingmove.__init(_s)
	Hldabl    .__init(_s)
end

-- script method

function Cloud.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_movabl(dt)
	-- _s:vec_mv__(dt)
	-- _s:pos__pls(_s._vec_mv)

	_s:upd_final()
end

function Cloud.act_intrvl(_s, dt)
	-- log._("Cloud.act_intrvl", _s._id)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	dice100.throw()
	if     not Map.chara_is_appear_all()
	and    dice100.chk(20) then
		Chara.cre()

	elseif not Map.chara_clb_fe_is_appear_all()
	and    dice100.chk(20) then
		Chara_clb_fe.cre()

	elseif not Map.chara_clb_tohoku_is_appear_all()
	and    dice100.chk(20) then
		Chara_clb_tohoku.cre()

	elseif dice100.chk( 4) then
		Anml.cre()

	elseif dice100.chk( 3) then
		Seed.cre()

	elseif dice100.chk( 2) then
		Veget.cre()

	elseif dice100.chk( 2) then
		Fish.cre()
	end

	_s:moving_prp__rnd()
end

function Cloud.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Cloud.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

