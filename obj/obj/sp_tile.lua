log.scrpt("sp_tile.lua")

--
-- pos, tile, etc
--

-- pos

function Sp.pos(_s)

	local t_pos = id.pos(_s._id)

	local is_nan = num.is_nan(t_pos.x)
	if is_nan then
		log._("Sp.pos is_nan", t_pos, _s._cls)
		_s:del()
		return
	end

	return t_pos
end

function Sp.pos__(_s, p_pos)
	id.pos__(_s._id, p_pos)
end

function Sp.pos_w(_s)

	local t_pos = id.pos_w(_s._id)
	return t_pos
end

function Sp.pos__pls(_s, p_vec)
	
	if _s:is_pause() then return end
	
	p_vec = _s:crct_vec(p_vec)
	
	local t_pos = _s:pos() + p_vec
	_s:pos__(t_pos)
end

function Sp.z(_s)
	local t_pos = _s:pos()
	return t_pos.z
end

function Sp.z__(_s, z)

	z = z or 0

	local t_pos = _s:pos()

	if not t_pos then return end

	t_pos.z = z
	pos.pos__(t_pos)
	_s._z = z
end

-- tile

function Sp.tile(_s, p_pos)
	
	p_pos = p_pos or _s:pos()
	
	local t_tile = map.tile(p_pos, _s._map_id, "ground")
	return t_tile
end

function Sp.tile__(_s, p_tile, p_pos)

	p_pos = p_pos or _s:pos()

	map.tile__(p_pos, p_tile, _s._map_id, "ground")
end

-- tilepos

function Sp.tilepos(_s)

	if _s._tilepos_flg then return _s._tilepos end

	_s:tilepos__()
	_s._tilepos_flg = _.t

	return _s._tilepos
end

function Sp.tilepos__(_s)

	_s._tilepos = map.pos_2_tilepos( _s:pos() )
end

function Sp.tilepos_arund(_s)
	
	local tilepos = _s:tilepos()
	local tilepos_arund = Map.tilepos_arund(tilepos)
	return tilepos_arund
end

-- pos foot

function Sp.foot_i_pos(_s)

	if _s._foot_i_pos_flg then return _s._foot_i_pos end

	local c_pos = _s:pos()
	_s._foot_i_pos.x = c_pos.x
	_s._foot_i_pos.y = c_pos.y - _s:foot_dst_i()

	_s._foot_i_pos_flg = _.t

	return _s._foot_i_pos
end

function Sp.foot_o_pos(_s)

	if _s._foot_o_pos_flg then return _s._foot_o_pos end

	local c_foot_i_pos = _s:foot_i_pos()
	_s._foot_o_pos.x = c_foot_i_pos.x
	_s._foot_o_pos.y = c_foot_i_pos.y - 1

	_s._foot_o_pos_flg = _.t

	return _s._foot_o_pos
end

function Sp.foot_dst_i(_s)
	
	local foot_dst_i

	-- if ar.inHa(_s._clsHa, {"kagu"}) then
	if ar.in_(_s._cls, {"kagu"}) then

		local h = go.get("#sprite", "size.y")
		foot_dst_i = num._2_int_d(h / 2)
	else
		foot_dst_i = _s._foot_dst_i
	end
	return foot_dst_i
end

function Sp.foot_i_tile(_s)
	
	local t_pos  = _s:foot_i_pos()
	local t_tile = _s:tile(t_pos)
	return t_tile
end

function Sp.foot_o_tile(_s)
	
	local t_pos  = _s:foot_o_pos()
	local t_tile = _s:tile(t_pos)
	return t_tile
end

function Sp.tilepos_d(_s)

	if _s._tilepos_d_flg then return _s._tilepos_d end

	_s:tilepos_d__()
	_s._tilepos_d_flg = _.t

	-- return tilepos_d
	return _s._tilepos_d
end

function Sp.tilepos_d__(_s)

	local t_tilepos = _s:tilepos()
	vec.xy__(_s._tilepos_d, t_tilepos.x, t_tilepos.y - 1)
end

-- pos head

function Sp.head_o_pos(_s)
	-- log._("sp head_o_pos ", _s._head_o_pos_flg)

	if _s._head_o_pos_flg then return _s._head_o_pos end

	local c_pos = _s:pos()

	_s._head_o_pos.x = c_pos.x
	_s._head_o_pos.y = c_pos.y + Map.sqh

	_s._head_o_pos_flg = _.t

	return _s._head_o_pos
end

function Sp.head_o_tile(_s)
	
	local t_pos  = _s:head_o_pos()
	local t_tile = _s:tile(t_pos)
	return t_tile
end

-- pos side

function Sp.side_l_pos(_s, p_vec)

	if _s._side_l_pos_flg then

		if p_vec then
			return _s._side_l_pos + p_vec
		else
			return _s._side_l_pos
		end
	end

	_s:side_l_pos__()
	_s._side_l_pos_flg = _.t

	if p_vec then
		return _s._side_l_pos + p_vec
	else
		return _s._side_l_pos
	end
end

function Sp.side_r_pos(_s, p_vec)

	if _s._side_r_pos_flg then

		if p_vec then
			return _s._side_r_pos + p_vec
		else
			return _s._side_r_pos
		end
	end

	_s:side_r_pos__()
	_s._side_r_pos_flg = _.t

	if p_vec then
		return _s._side_r_pos + p_vec
	else
		return _s._side_r_pos
	end
end

function Sp.side_l_pos__(_s)

	local c_pos = _s:pos()
	vec.xy__(_s._side_l_pos, c_pos.x - _s._w/2 - 1, c_pos.y)
end

function Sp.side_r_pos__(_s)

	local c_pos = _s:pos()

	vec.xy__(_s._side_r_pos, c_pos.x + _s._w/2    , c_pos.y)
end

function Sp.side_pos(_s, dir_h)

	if     dir_h == "l" then return _s:side_l_pos()
	elseif dir_h == "r" then return _s:side_r_pos()
	else
		log._("sp side_pos dir_h..??", dir_h)
	end
end

-- is tile

function Sp.is_block(_s, p_pos)

	local ret = _.f

	local t_tile = _s:tile(p_pos)

	if Tile.is_block(t_tile) then ret = _.t
	else                          t_tile = nil
	end

	return ret, t_tile
end

function Sp.is_clmb(_s, p_pos)
	
	local t_tile = _s:tile(p_pos)
	local ret = Tile.is_clmb(t_tile)
	return ret
end

function Sp.is_elv_u(_s, p_pos)
	
	local t_tile = _s:tile(p_pos)
	local ret = Tile.is_elv(t_tile)
	return ret
end

function Sp.is_airflw_u(_s, p_pos)
	
	local t_tile = _s:tile(p_pos)
	local ret = Tile.is_airflw_u(t_tile)
	return ret
end

function Sp.is_soil(_s, p_pos)
	
	local t_tile = _s:tile(p_pos)
	local ret = Tile.is_soil(t_tile)
	return ret
end

-- is tile foot

function Sp.foot_o_is_block(_s)

	local ret = _.f

	local foot_o_tile = _s:foot_o_tile()
	if Tile.is_block(foot_o_tile) then ret = _.t end

	return ret
end

-- is tile head

function Sp.head_o_is_block(_s)

	local t_pos = _s:head_o_pos()
	local ret = _s:is_block(t_pos)
	return ret
end

-- is tile side

function Sp.side_is_block(_s, dir_h, p_vec)
	
	p_vec = p_vec or n.vec(nil, nil, nil, "sp.side_is_block")

	local t_pos = _s:side_pos(dir_h) + p_vec
	return _s:is_block(t_pos)
end

function Sp.is_tile_grounding(_s)

	local ret = _.f

	local foot_i_tile = _s:foot_i_tile()
	local foot_o_tile = _s:foot_o_tile()
	
	if Tile.is_elv(  foot_i_tile)
	or Tile.is_elv(  foot_o_tile)
	or Tile.is_clmb( foot_i_tile)
	or Tile.is_clmb( foot_o_tile)
	or Tile.is_block(foot_o_tile) then
		ret = _.t
	end

	return ret
end

-- crct

function Sp.crct_vec(_s, p_vec)
	
	if not (_s._parent_id == _s._map_id) then return p_vec end
	
	p_vec = _s:crct_block(p_vec)
	
	p_vec = _s:crct_clmb(p_vec)
	
	p_vec = _s:crct_inside_map(p_vec)
	
	return p_vec
end

function Sp.crct_block(_s, p_vec)
	
	if ha.eq(_s._clsHa, "fire") then return p_vec end
	
	p_vec = _s:crct_block_side(p_vec)
	
	p_vec = _s:crct_block_foot(p_vec)
	
	p_vec = _s:crct_block_head(p_vec)
	
	return p_vec
end

function Sp.crct_block_foot(_s, p_vec)
	
	local foot_i_pos = _s:foot_i_pos()

	vec.xy__(_s._foot_i_pos_nxt, foot_i_pos.x + p_vec.x, foot_i_pos.y + p_vec.y)
	vec.xy__(_s._foot_i_pos_nxt_up, _s._foot_i_pos_nxt.x, _s._foot_i_pos_nxt.y + Map.sq)
	
	local is_crct =         _s:is_block(_s._foot_i_pos_nxt   )
	                and not _s:is_block(_s._foot_i_pos_nxt_up)
	if not is_crct then return p_vec end

	p_vec.y = map.pos_by_pos(_s._foot_i_pos_nxt).y + Map.sqh + _s:foot_dst_i() - _s:pos().y
	return p_vec
end

function Sp.crct_block_head(_s, p_vec)

	local head_o_pos_nxt = _s:head_o_pos() + p_vec
	
	if not _s:is_block(head_o_pos_nxt) then return p_vec end
	
	p_vec.y = map.pos_by_pos(head_o_pos_nxt).y - Map.sq - _s:pos().y
	return p_vec
end

function Sp.crct_block_side(_s, p_vec)
	
	local side_l_nxt_is_block = _s:side_is_block("l", p_vec)
	local side_r_nxt_is_block = _s:side_is_block("r", p_vec)
	
	if not side_l_nxt_is_block and not side_r_nxt_is_block then return p_vec end

	_s._accl:speed_x__clr()

	if     side_l_nxt_is_block and     side_r_nxt_is_block then return p_vec end

	local crct_pos_x
	local df_x = Map.sqh + _s._w/2

	if     side_l_nxt_is_block then
		crct_pos_x = map.pos_by_pos(_s:side_l_pos(p_vec)).x + df_x
		
	elseif side_r_nxt_is_block then
		crct_pos_x = map.pos_by_pos(_s:side_r_pos(p_vec)).x - df_x
	end
	p_vec.x = crct_pos_x - _s:pos().x
	return p_vec
end

function Sp.crct_clmb(_s, p_vec)
	
	if not (_s._moving_v and _s._dir_v == "u") then return p_vec end

	local foot_i_pos     = _s:foot_i_pos()
	local foot_i_pos_nxt =    foot_i_pos + p_vec
	
	local is_crct = _s:is_clmb(foot_i_pos) and not _s:is_clmb(foot_i_pos_nxt)
	if not is_crct then return p_vec end
	
	p_vec.y = map.pos_by_pos(foot_i_pos).y + Map.sq - _s:pos().y
	return p_vec
end

function Sp.crct_inside_map(_s, p_vec)
	
	local pos_nxt = _s:pos() + p_vec

	local is_inside, dir = _s:map_is_inside(pos_nxt)
	
	if is_inside then return p_vec end

	-- log._("crct_inside_map", dir)
	
	local inside_rng_pos = _s:map_inside_rng_pos()
	
	if     dir == "l" then pos_nxt.x = inside_rng_pos.min.x
	elseif dir == "r" then pos_nxt.x = inside_rng_pos.max.x
	elseif dir == "d" then pos_nxt.y = inside_rng_pos.min.y
	elseif dir == "u" then pos_nxt.y = inside_rng_pos.max.y
	end
	
	p_vec = pos_nxt - _s:pos()
	
	return p_vec
end

-- init, final, flg

function Sp.vec__init(_s)

	_s._accl      = n.Accl()

	_s._vec_grv   = n.vec()
	_s._vec_mv    = n.vec()
	_s._vec_tile  = n.vec()

	_s._vec_total = n.vec()

	_s._accl_speed = _s._accl._speed -- alias
end

function Sp.pos__init(_s)

	_s._foot_i_pos = n.vec()
	_s._foot_o_pos = n.vec()
	_s._head_o_pos = n.vec()

	_s._side_l_pos = n.vec()
	_s._side_r_pos = n.vec()

	_s._tilepos    = n.vec()
	_s._tilepos_d  = n.vec()

	_s:pos_flg__f()

	-- flg non
	_s._foot_i_pos_nxt    = n.vec()
	_s._foot_i_pos_nxt_up = n.vec()
end

function Sp.pos_flg__clr(_s)
	_s:pos_flg__f()
end

function Sp.pos_flg__f(_s)

	_s._foot_i_pos_flg = _.f
	_s._foot_o_pos_flg = _.f
	_s._head_o_pos_flg = _.f

	_s._side_l_pos_flg = _.f
	_s._side_r_pos_flg = _.f

	_s._tilepos_flg    = _.f
	_s._tilepos_d_flg  = _.f
end

function Sp.is_leapupabl(_s) -- alias

	return _s:is_jmpabl()
end

function Sp.is_jmpabl(_s)

	local ret = _.f

	local foot_o_tile = _s:foot_o_tile()
	local foot_i_tile = _s:foot_i_tile()
	
	if Tile.is_block(foot_o_tile)
	or Tile.is_clmb( foot_o_tile)
	or Tile.is_elv(  foot_o_tile)
	-- or _s:is_on_chara()
	-- or _s:is_on_obj_block()
	-- or _s:on_by_mapobj()
	then
		ret = _.t
	end

	return ret
end

