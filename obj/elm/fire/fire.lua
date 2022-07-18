log.scrpt("fire.lua")

Fire = {
	act_intrvl_time = 15,
	name_idx_max = 1,
	z = 0.4,
}
Fire.cls = "fire"
Fire.fac = Obj.fac..Fire.cls
Cls.add(Fire)

-- static

function Fire.cre(p_pos)
	local t_id = Sp.cre(Fire, p_pos)
	return t_id
end

-- scrpt method

function Fire.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Fire)
end

function Fire.__init(_s, prm)
	
	Sp.__init(_s, prm)

	Se.pst_ply("fire")

	_s:upd__o()
end

function Fire.upd(_s, dt)
	
	local t_tile = _s:tile()
	
	if not t_tile then log._("fire upd() tile", t_tile) end
	
	if Tile.is_wood(t_tile) or Tile.is_wood_burn(t_tile) then
		vec.xy__clr(_s._vec_grv)
	else
		_s:vec_grv__()
	end

	_s:vec_total__()

	_s:pos__pls_vec_total()

	_s:upd_final()
end

function Fire.vec_total__(_s)

	vec.xy__vec(_s._vec_total, _s._vec_grv)
end

function Fire.act_intrvl(_s, dt)

	log._("fire.act_intrvl", _s:pos())
	
	-- death
	if _s:per_del(1 / 5 * 100) then return end
	
	_s:burn()
end

function Fire.final(_s)

	Sp.final(_s)
end

-- method

function Fire.burn(_s)
	
	if not rnd.by_p(60) then return end
	
	_s:burn_tile()
	-- _s:burn_obj()
end

function Fire.burn_tile(_s)
	log._("fire.burn_tile")
	
	local tileposs = _s:tilepos_arund()
	local t_tile
	for idx, t_tilepos in pairs(tileposs) do
		t_tile = map.tile_6_tile_xy(t_tilepos.x, t_tilepos.y, _s:map_id())

		if Tile.is_wood(t_tile) then
			map.tile__6_tilepos(t_tilepos, ar.rnd(Tile.mstr.wood_burn))
			Fire.cre(map.pos_6_tilepos(t_tilepos))
		end
	end

	if Tile.is_wood_burn(_s:tile())
	and rnd.by_p(50)
	then
		map.tile__6_tilepos(_s:tilepos(), Tile.mstr.emp)
	end
end

function Fire.burn_obj(_s) -- old
	-- log._("fire.burn_obj")
	
	local t_cls = {"wood", "dryleaf", "leaf"}
	
	local obj_arund, clsHa
	for idx, cls in pairs(t_cls) do

		clsHa = ha._(cls)
		obj_arund = _s:obj_arund(clsHa)
		-- log.pp(clsHa, obj_arund)
		
		for id, val in pairs(obj_arund) do
			pst.scrpt(id, "burn")
		end
	end
end

