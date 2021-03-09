log.scrpt("fire.lua")

Fire = {
	act_intrvl_time = 15,
	name_idx_max = 1,
	z = 0.4,
}
Fire.cls = "fire"
Fire.fac = Fire.cls.."Fac"
Fire.Fac = Obj.fac..Fire.cls
Cls.add(Fire)

-- static

function Fire.cre(pos)
	local id = Sp.cre(Fire, pos)
	return id
end

-- script method

function Fire.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Fire)

	Se.pst_ply("fire")
end

function Fire.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	local pos = _s:pos()
	local tile = _s:tile() -- map.tile(pos)
	
	if not tile then log._("fire upd() tile", tile) end
	
	local vec
	-- if ar.in_(tile, Tile.wood) or ar.in_(tile, Tile.wood_burn) then
	if Tile.is_wood(tile) or Tile.is_wood_burn(tile) then
		vec = n.vec()
	else
		vec = _s:vec_grv(dt)
	end
	_s:pos__add(vec)

	_s:upd_final()
end

function Fire.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	log._("fire.act_intrvl", _s:pos())
	
	-- death
	if _s:per_del(1 / 5 * 100) then return end
	
	_s:burn()
end

function Fire.burn(_s)
	
	if not rnd.by_p(60) then return end
	
	_s:burn_tile()
	_s:burn_obj()
end

function Fire.burn_tile(_s)
	log._("fire.burn_tile")
	
	-- local tilepos = _s:tilepos()
	
	local tileposs = _s:tilepos_arund()
	local tile
	for idx, tilepos in pairs(tileposs) do
		tile = map.tile_by_tilepos(tilepos)

		-- if ar.in_(tile, Tile.wood) then
		if Tile.is_wood(tile) then
			map.tile__by_tilepos(tilepos, ar.rnd(Tile.wood_burn))
			Fire.cre(map.pos_by_tilepos(tilepos))
		end
	end

	-- if ar.in_(_s:tile(), Tile.wood_burn)
	if Tile.is_wood_burn(_s:tile())
	and rnd.by_p(50)
	then
		map.tile__by_tilepos(_s:tilepos(), Tile.emp)
	end
end

function Fire.burn_obj(_s)
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

function Fire.final(_s)
	Sp.final(_s)
end
