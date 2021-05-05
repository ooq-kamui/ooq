log.scrpt("seed.lua")

Seed = {
	act_intrvl_time = 14,
	name_idx_max    =  7,

	foot_dst_i = 4,
}
Seed.cls = "seed"
Seed.fac = Obj.fac..Seed.cls
Cls.add(Seed)

-- static

function Seed.cre(p_pos, prm)
	local t_Cls = Seed
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Seed.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Seed)
end

function Seed.__init(_s, prm)
	
	Seed.grw_bear__init(_s)

	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Seed.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Seed.on_msg(_s, msg_id, prm, sndr)
	Sp    .on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Seed.final(_s)
	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Seed.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	-- log._("Seed.act_intrvl", _s._grw_clsHa, _s._grw_nameHa, _s._bear_clsHa, _s._bear_nameHa)

	-- death
	if _s:per_trnsf(1, Humus) then return end

	local grw_Cls, prm

	if     ar.inHa(_s._nameHa, {"seed001"}) then
		dice100.throw()
		if dice100.chk(20) then
			grw_Cls = Cls._(_s._grw_clsHa) or Flower
			prm = {
				_nameHa      = _s._grw_nameHa,
			}
			local t_id = _s:trnsf(grw_Cls, prm)
		end
	elseif ar.inHa(_s._nameHa, {"seed005"}) then
		dice100.throw()
		if dice100.chk(20) then
			grw_Cls = Cls._(_s._grw_clsHa) or Tree
			prm = {
				_nameHa      = _s._grw_nameHa,
				_bear_clsHa  = _s._bear_clsHa,
				_bear_nameHa = _s._bear_nameHa,
			}
			local t_id = _s:trnsf(grw_Cls, prm)
		end
	else
		dice100.throw()
		if dice100.chk(20) then
			local t_id = _s:trnsf(Plant)
		end
	end
end

function Seed.grw_bear__init(_s)

	ha.is_emp__(_s._grw_clsHa  , "tree"    )
	ha.is_emp__(_s._grw_nameHa , "tree005" )
	ha.is_emp__(_s._bear_clsHa , "fruit"   )
	ha.is_emp__(_s._bear_nameHa, "fruit007")
end

