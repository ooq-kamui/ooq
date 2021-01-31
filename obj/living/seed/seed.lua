log.scrpt("seed.lua")

Seed = {
	act_interval_time = 14,
	name_idx_max = 7,

	foot_dst_i = 4,
}
Seed.cls = "seed"
Seed.Fac = Obj.fac..Seed.cls
Cls.add(Seed)

-- ar.idx_2_ha(Seed.gold, "seed")

-- static

function Seed.cre(pos, prm)
	local Cls = Seed
	local id = Sp.cre(Cls, pos, prm)
	return id
end

function Seed.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Seed)
end

-- script method

function Seed.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Seed.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end
	
	-- death
	if _s:per_trnsf(1, Humus) then return end

	if     ar.inHa(_s._name, {"seed001"}) then
		dice100.throw()
		if dice100.chk(20) then
			local grw_cls  = Cls._(_s._grw_cls) or Flower
			_s:trnsf(grw_cls, {name = _s._grw_name})
		end
	elseif ar.inHa(_s._name, {"seed005"}) then
		dice100.throw()
		if dice100.chk(20) then
			local grw_Cls  = Cls._(_s._grw_cls) or Tree
			local prm = {
				name      = _s._grw_name,
				bear_cls  = _s._bear_cls,
				bear_name = _s._bear_name,
			}
			local id = _s:trnsf(grw_Cls, prm)
			-- pst.scrpt(id, "scl_anim__1")
		end
	else
		dice100.throw()
		if dice100.chk(20) then
			_s:trnsf(Plant)
		end
	end
end

function Seed.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
	Hldabl.on_msg(_s, msg_id, prm, sender)
end

function Seed.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end
