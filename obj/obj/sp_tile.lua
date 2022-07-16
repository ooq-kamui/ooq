log.scrpt("sp_tile.lua")

--
-- tile, pos, etc
--

-- crnt pos

function Sp.pos(_s)

	-- if _s._pos then return _s._pos end

	local t_pos = id.pos(_s._id)
	-- log._("Sp.pos")

	local is_nan = num.is_nan(t_pos.x)
	if is_nan then
		log._("Sp.pos is_nan", t_pos, _s._cls)
		_s:del()
		return
	end

	return t_pos
end

function Sp.pos__(_s, p_pos)

	local pos_c = _s:pos()

	id.pos__(_s._id, p_pos)

	-- if u.is_emp(_s:map_id()) then return end

	local prm = {id = _s._id, cls = _s._cls, pos_c = pos_c, pos_n = p_pos}
	pst.scrpt(_s:map_id(), "tile_xy_obj__del_add", prm)
end

function Sp.pos__y(_s, p_pos_y)

	local t_pos = _s:pos()
	vec.y__(t_pos, p_pos_y)

	_s:pos__(t_pos)
	-- id.pos__(_s._id, t_pos)
end

function Sp.pos__pls_y(_s, p_pos_y)

	local t_pos = _s:pos()
	vec.y__(t_pos, t_pos.y + p_pos_y)

	_s:pos__(t_pos)
	-- id.pos__(_s._id, t_pos)
end

function Sp.pos__pls(_s, p_vec)

	local t_pos = _s:pos()
	vec.xy__pls(t_pos, p_vec.x, p_vec.y)

	_s:pos__(t_pos)
	-- id.pos__(_s._id, t_pos)
end

function Sp.pos__pls_vec_total(_s) -- 3sec
	-- log._("Sp.pos__pls_vec_total")
	
	if _s:is_pause() then return end
	
	_s:vec_total__crct() -- 3sec
	
	_s:pos__pls(_s._vec_total)
end

function Sp.pos__tile(_s)
	-- log._("Sp.vec_tile__")
	
	if not u.eq(_s:map_id(), _s:parent_id()) then return end

	if     _s:foot_i_is_elv_u() then

		_s:pos__pls_y(1)

	elseif _s:is_airflw_u() then

		_s:pos__pls_y(Sp.airflw_u_vec_y)
	end
end

function Sp.pos_w(_s)
	local t_pos = id.pos_w(_s._id)
	return t_pos
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

-- crnt tile

function Sp.tile_6_pos(_s, p_pos) -- alias

	if not p_pos then return end

	local t_tile = map.tile(p_pos, _s._map_id, "ground", nil, _s._id)
	return t_tile
end

function Sp.tile(_s)
	-- log._("Sp.tile")
	
	if _s._c_tile_flg then return _s._c_tile end
	
	_s._c_tile = _s:tile_6_pos(_s:pos())
	_s._c_tile_flg = _.t

	return _s._c_tile
end

function Sp.map_tile__(_s, p_tile, p_pos)

	p_pos = p_pos or _s:pos()

	map.tile__(p_pos, p_tile, _s._map_id, "ground")
end

-- crnt tilepos

function Sp.tilepos(_s)

	if _s._tilepos_flg then return _s._tilepos end

	_s:tilepos__()

	return _s._tilepos
end

function Sp.tilepos__(_s)

	local x, y = map.tilepos_xy_6_pos_xy(_s:pos().x, _s:pos().y)
	vec.xy__(_s._tilepos, x, y)

	_s._tilepos_flg = _.t
end

function Sp.tilepos_arund(_s)
	
	local tilepos = _s:tilepos()
	local tilepos_arund = Map.tilepos_arund(tilepos)
	return tilepos_arund
end

function Sp.tilepos_d(_s)

	if _s._tilepos_d_flg then return _s._tilepos_d end

	_s:tilepos_d__()

	return _s._tilepos_d
end

function Sp.tilepos_d__(_s)

	vec.xy__vec(_s._tilepos_d, _s:tilepos())
	vec.xy__pls(_s._tilepos_d, 0, - 1)

	_s._tilepos_d_flg = _.t
end

-- crnt is tile

function Sp.is_airflw_u(_s)
	
	local t_tile = _s:tile()
	local ret = Tile.is_airflw_u(t_tile)
	return ret
end

function Sp.is_soil(_s)
	
	local t_tile = _s:tile()
	local ret = Tile.is_soil(t_tile)
	return ret
end

-- foot pos, tile

function Sp.foot_i_pos(_s)

	if _s._foot_i_pos_flg then return _s._foot_i_pos end

	_s:foot_i_pos__()

	return _s._foot_i_pos
end

function Sp.foot_i_pos__(_s)

	local c_pos = _s:pos()

	local x = c_pos.x
	local y = c_pos.y - _s:foot_dst_i()
	vec.xy__(_s._foot_i_pos, x, y)

	_s._foot_i_pos_flg = _.t
end

function Sp.foot_i_tile(_s)
	
	if _s._c_foot_i_tile_flg then return _s._c_foot_i_tile end

	_s:foot_i_tile__()

	return _s._c_foot_i_tile
end

function Sp.foot_i_tile__(_s)

	_s._c_foot_i_tile = _s:tile_6_pos(_s:foot_i_pos())
	_s._c_foot_i_tile_flg = _.t
end

function Sp.foot_i_is_clmb(_s)

	local t_tile = _s:foot_i_tile()
	local ret = Tile.is_clmb(t_tile)
	return ret
end

function Sp.foot_i_is_elv_u(_s)

	local t_tile = _s:foot_i_tile()
	local ret = Tile.is_elv(t_tile)
	return ret
end

-- foot o

function Sp.foot_o_pos(_s)

	if _s._foot_o_pos_flg then return _s._foot_o_pos end

	_s:foot_o_pos__()

	return _s._foot_o_pos
end

function Sp.foot_o_pos__(_s)

	vec.xy__vec(_s._foot_o_pos, _s:foot_i_pos())
	vec.xy__pls(_s._foot_o_pos, 0, - 1)

	_s._foot_o_pos_flg = _.t
end

function Sp.foot_dst_i(_s) -- todo cache
	
	local foot_dst_i

	if ar.in_(_s._cls, {"kagu"}) then

		local h = go.get("#sprite", "size.y")
		foot_dst_i = num._2_int_d(h / 2)
	else
		foot_dst_i = _s._foot_dst_i
	end
	return foot_dst_i
end

function Sp.foot_o_tile(_s)
	
	if _s._c_foot_o_tile_flg then return _s._c_foot_o_tile end

	_s:foot_o_tile__()

	return _s._c_foot_o_tile
end

function Sp.foot_o_tile__(_s)

	_s._c_foot_o_tile = _s:tile_6_pos(_s:foot_o_pos())
	_s._c_foot_o_tile_flg = _.t
end

function Sp.foot_o_is_block(_s)

	local t_tile = _s:foot_o_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

-- head pos, tile

function Sp.head_o_pos(_s)

	if _s._head_o_pos_flg then return _s._head_o_pos end

	_s:head_o_pos__()

	return _s._head_o_pos
end

function Sp.head_o_pos__(_s)

	local c_pos = _s:pos()
	_s._head_o_pos.x = c_pos.x
	_s._head_o_pos.y = c_pos.y + Map.sqh

	_s._head_o_pos_flg = _.t
end

function Sp.head_o_tile(_s)
	
	if _s._c_head_o_tile_flg then return _s._c_head_o_tile end

	_s:head_o_tile__()

	return _s._c_head_o_tile
end

function Sp.head_o_tile__(_s)

	_s._c_head_o_tile = _s:tile_6_pos(_s:head_o_pos())
	_s._c_head_o_tile_flg = _.t
end

function Sp.head_o_is_block(_s)

	local t_tile = _s:head_o_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

-- side pos

function Sp.side_pos(_s, dir_h)

	if     dir_h == "l" then return _s:side_l_pos()
	elseif dir_h == "r" then return _s:side_r_pos()
	else
		log._("sp side_pos dir_h..??", dir_h)
	end
end

-- side is tile

function Sp.side_is_block(_s, dir_h)
	
	local t_pos = _s:side_pos(dir_h)
	local t_tile = _s:tile_6_pos(t_pos)
	local ret = Tile.is_block(t_tile)
	return ret
end

-- side l

function Sp.side_l_pos(_s)

	if _s._side_l_pos_flg then return _s._side_l_pos end

	_s:side_l_pos__()

	return _s._side_l_pos
end

function Sp.side_l_pos__(_s)

	local c_pos = _s:pos()
	vec.xy__(_s._side_l_pos, c_pos.x - _s._w/2 - 1, c_pos.y)

	_s._side_l_pos_flg = _.t
end

function Sp.side_l_tile(_s)

	if _s._side_l_tile_flg then return _s._side_l_tile end

	_s:side_l_tile__()

	return _s._side_l_tile
end

function Sp.side_l_tile__(_s)

	_s._side_l_tile = _s:tile_6_pos(_s:side_l_pos())
	_s._side_l_tile_flg = _.t
end

function Sp.side_l_is_block(_s)

	local t_tile = _s:side_l_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

-- side r

function Sp.side_r_pos(_s)

	if _s._side_r_pos_flg then return _s._side_r_pos end

	_s:side_r_pos__()

	return _s._side_r_pos
end

function Sp.side_r_pos__(_s)

	local c_pos = _s:pos()
	vec.xy__(_s._side_r_pos, c_pos.x + _s._w/2    , c_pos.y)
	_s._side_r_pos_flg = _.t
end

function Sp.side_r_tile(_s)

	if _s._side_r_tile_flg then return _s._side_r_tile end

	_s:side_r_tile__()

	return _s._side_r_tile
end

function Sp.side_r_tile__(_s)

	_s._side_r_tile = _s:tile_6_pos(_s:side_r_pos())
	_s._side_r_tile_flg = _.t
end

function Sp.side_r_is_block(_s)

	local t_tile = _s:side_r_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

-- is grounding

function Sp.is_grounding(_s)

	local ret = _.f

	if _s._accl._speed.y > 0 then return ret end

	local foot_o_tile = _s:foot_o_tile()

	if Tile.is_block(foot_o_tile)
	then
		_s:foot_o__crct()

		ret = _.t
		return ret
	end

	if Tile.is_elv(  foot_o_tile)
	or Tile.is_clmb( foot_o_tile)
	then ret = _.t return ret end

	local foot_i_tile = _s:foot_i_tile()
	
	if Tile.is_elv(  foot_i_tile)
	or Tile.is_clmb( foot_i_tile)
	then ret = _.t return ret end

	return ret
end

function Sp.foot_o__crct(_s)

	local x, y = map.tile_pos_xy_6_pos(_s:foot_o_pos())
	local crct_y = y + Map.sqh + _s:foot_dst_i()
	_s:pos__y(crct_y)
end

-- crct

function Sp.vec_total__crct(_s) -- 3sec
	-- log._("Sp.vec_total__crct")
	
	if not (_s._parent_id == _s._map_id) then return end
	
	_s:vec_total__crct_block() -- 3sec heavy
	
	_s:vec_total__crct_clmb() -- 3sec
	
	_s:vec_total__crct_inside_map() -- 3sec
end

function Sp.vec_total__crct_block(_s) -- 3sec heavy
	-- log._("Sp.vec_total__crct_block")
	
	if ha.eq(_s._clsHa, "fire") then return end
	
	_s:vec_total__crct_block_side() -- 3sec heavy

	_s:vec_total__crct_block_foot() -- 3sec heavy
	
	_s:vec_total__crct_block_head() -- 3sec heavy
end

function Sp.vec_total__crct_block_foot(_s) -- 3sec
	-- log._("Sp.vec_total__crct_block_foot")
	
	_s:nxt_foot_i__clr()
	_s:nxt_foot_i_up__clr()

	local is_crct =         _s:nxt_foot_i_is_block()
	                and not _s:nxt_foot_i_up_is_block()

	if not is_crct then return end

	local x, y = map.pos_xy_6_pos(_s:nxt_foot_i_pos())
	_s._vec_total.y = y + Map.sqh + _s:foot_dst_i() - _s:pos().y
end

function Sp.vec_total__crct_block_head(_s) -- 3sec
	-- log._("Sp.vec_total__crct_block_head")

	_s:nxt_head_o__clr()

	if not _s:nxt_head_o_is_block() then return end
	
	local x, y = map.pos_xy_6_pos(_s:nxt_head_o_pos())
	_s._vec_total.y = y - Map.sq - _s:pos().y
end

function Sp.vec_total__crct_block_side(_s) -- 3sec heavy
	-- log._("Sp.vec_total__crct_block_side")
	
	_s:nxt_side_l__clr()
	_s:nxt_side_r__clr()

	local nxt_side_l_is_block = _s:nxt_side_l_is_block()
	local nxt_side_r_is_block = _s:nxt_side_r_is_block()

	if not nxt_side_l_is_block and not nxt_side_r_is_block then return end

	_s._accl:speed_x__clr()

	if     nxt_side_l_is_block and     nxt_side_r_is_block then return end

	local crct_pos_x, x, y
	local df_x = Map.sqh + _s._w/2

	if     nxt_side_l_is_block then
		x, y = map.pos_xy_6_pos(_s:nxt_side_l_pos())
		crct_pos_x = x + df_x
		
	elseif nxt_side_r_is_block then
		x, y = map.pos_xy_6_pos(_s:nxt_side_r_pos())
		crct_pos_x = x - df_x
	end

	_s._vec_total.x = crct_pos_x - _s:pos().x
end

function Sp.vec_total__crct_clmb(_s ) -- 3sec
	-- log._("Sp.vec_total__crct_clmb")
	
	if not (_s._moving_v and _s._dir_v == "u") then return end
	
	_s:nxt_foot_i__clr()

	local is_crct = _s:foot_i_is_clmb() and not _s:nxt_foot_i_is_clmb()

	if not is_crct then return end

	local x, y = map.pos_xy_6_pos(_s:foot_i_pos())
	_s._vec_total.y = y + Map.sq - _s:pos().y
end

function Sp.vec_total__crct_inside_map(_s ) -- 3sec
	-- log._("Sp.vec_total__crct_inside_map")
	
	_s:nxt_pos__() -- todo cache

	local is_inside, dir = _s:map_is_inside(_s:nxt_pos())
	
	if is_inside then return end
	
	local inside_rng_pos = _s:map_inside_rng_pos()
	
	if     dir == "l" then _s._nxt_pos.x = inside_rng_pos.min.x
	elseif dir == "r" then _s._nxt_pos.x = inside_rng_pos.max.x
	elseif dir == "d" then _s._nxt_pos.y = inside_rng_pos.min.y
	elseif dir == "u" then _s._nxt_pos.y = inside_rng_pos.max.y
	end
	
	-- _s._vec_total = nxt_pos - _s:pos()
	vec.xy__vec(_s:vec_total(), _s:nxt_pos())
	vec.xy__pls(_s:vec_total(), - _s:pos().x, - _s:pos().y)
end

-- nxt

function Sp.nxt_pos(_s)

	return _s._nxt_pos
end

function Sp.nxt_pos__(_s)

	-- local nxt_pos = _s:pos() + _s._vec_total
	vec.xy__vec(    _s:nxt_pos(), _s:pos())
	vec.xy__pls_vec(_s:nxt_pos(), _s._vec_total)
end

function Sp.nxt_foot_i_pos(_s)

	if _s._nxt_foot_i_pos_flg then return _s._nxt_foot_i_pos end

	_s:nxt_foot_i_pos__()

	return _s._nxt_foot_i_pos
end

function Sp.nxt_foot_i_pos__(_s)

	vec.xy__vec(_s._nxt_foot_i_pos, _s:foot_i_pos())
	vec.xy__pls(_s._nxt_foot_i_pos, _s._vec_total.x, _s._vec_total.y)

	_s._nxt_foot_i_pos_flg = _.t
end

function Sp.nxt_foot_i_tile(_s)

	if _s._nxt_foot_i_tile_flg then return _s._nxt_foot_i_tile end

	_s:nxt_foot_i_tile__()

	return _s._nxt_foot_i_tile
end

function Sp.nxt_foot_i_tile__(_s)

	_s._nxt_foot_i_tile = _s:tile_6_pos(_s:nxt_foot_i_pos())
	_s._nxt_foot_i_tile_flg = _.t
end

function Sp.nxt_foot_i_is_block(_s)

	local t_tile = _s:nxt_foot_i_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

function Sp.nxt_foot_i_is_clmb(_s)

	local t_tile = _s:nxt_foot_i_tile()
	local ret = Tile.is_clmb(t_tile)
	return ret
end

function Sp.nxt_foot_i__clr(_s)
	_s._nxt_foot_i_pos_flg  = _.f
	_s._nxt_foot_i_tile_flg = _.f
end

function Sp.nxt_foot_i_up_pos(_s)

	if _s._nxt_foot_i_up_pos_flg then return _s._nxt_foot_i_up_pos end

	_s:nxt_foot_i_up_pos__()

	return _s._nxt_foot_i_up_pos
end

function Sp.nxt_foot_i_up_pos__(_s)

	vec.xy__vec(_s._nxt_foot_i_up_pos, _s:nxt_foot_i_pos())
	vec.xy__pls(_s._nxt_foot_i_up_pos, 0, Map.sq)

	_s._nxt_foot_i_up_pos_flg = _.t
end

function Sp.nxt_foot_i_up_tile(_s)

	if _s._nxt_foot_i_up_tile_flg then return _s._nxt_foot_i_up_tile end

	_s:nxt_foot_i_up_tile__()

	return _s._nxt_foot_i_up_tile
end

function Sp.nxt_foot_i_up_tile__(_s)

	_s._nxt_foot_i_up_tile = _s:tile_6_pos(_s:nxt_foot_i_up_pos())
	_s._nxt_foot_i_up_tile_flg = _.t
end

function Sp.nxt_foot_i_up_is_block(_s)

	local t_tile = _s:nxt_foot_i_up_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

function Sp.nxt_foot_i_up__clr(_s)
	_s._nxt_foot_i_up_pos_flg  = _.f
	_s._nxt_foot_i_up_tile_flg = _.f
end

function Sp.nxt_head_o_pos(_s)

	if _s._nxt_head_o_pos_flg then return _s._nxt_head_o_pos end

	_s:nxt_head_o_pos__()

	return _s._nxt_head_o_pos
end

function Sp.nxt_head_o_pos__(_s)

	vec.xy__vec(_s._nxt_head_o_pos, _s:head_o_pos())
	vec.xy__pls(_s._nxt_head_o_pos, _s._vec_total.x, _s._vec_total.y)

	_s._nxt_head_o_pos_flg = _.t
end

function Sp.nxt_head_o_tile(_s)

	if _s._nxt_head_o_tile_flg then return _s._nxt_head_o_tile end

	_s:nxt_head_o_tile__()

	return _s._nxt_head_o_tile
end

function Sp.nxt_head_o_tile__(_s)

	_s._nxt_head_o_tile = _s:tile_6_pos(_s:nxt_head_o_pos())
	_s._nxt_head_o_tile_flg = _.t
end

function Sp.nxt_head_o_is_block(_s)

	local t_tile = _s:nxt_head_o_tile()
	-- log._("Sp.nxt_head_o_is_block", t_tile)
	local ret = Tile.is_block(t_tile)
	return ret
end

function Sp.nxt_head_o__clr(_s)
	_s._nxt_head_o_pos_flg  = _.f
	_s._nxt_head_o_tile_flg = _.f
end

-- nxt side

function Sp.nxt_side_l_pos(_s)

	if _s._nxt_side_l_pos_flg then return _s._nxt_side_l_pos end

	_s:nxt_side_l_pos__()

	return _s._nxt_side_l_pos
end

function Sp.nxt_side_l_pos__(_s)

	vec.xy__vec(    _s._nxt_side_l_pos, _s:side_l_pos())
	vec.xy__pls_vec(_s._nxt_side_l_pos, _s:vec_total() )

	_s._nxt_side_l_pos_flg = _.t
end

function Sp.nxt_side_l_tile(_s)

	if _s._nxt_side_l_tile_flg then return _s._nxt_side_l_tile end

	_s:nxt_side_l_tile__()

	return _s._nxt_side_l_tile
end

function Sp.nxt_side_l_tile__(_s)

	_s._nxt_side_l_tile = _s:tile_6_pos(_s:nxt_side_l_pos())
	_s._nxt_side_l_tile_flg = _.t
end

function Sp.nxt_side_l_is_block(_s)

	local t_tile = _s:nxt_side_l_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

function Sp.nxt_side_l__clr(_s)
	_s._nxt_side_l_pos_flg  = _.f
	_s._nxt_side_l_tile_flg = _.f
end

function Sp.nxt_side_r_pos(_s)

	if _s._nxt_side_r_pos_flg then return _s._nxt_side_r_pos end

	_s:nxt_side_r_pos__()

	return _s._nxt_side_r_pos
end

function Sp.nxt_side_r_pos__(_s)

	vec.xy__vec(    _s._nxt_side_r_pos, _s:side_r_pos())
	vec.xy__pls_vec(_s._nxt_side_r_pos, _s:vec_total() )

	_s._nxt_side_r_pos_flg = _.t
end

function Sp.nxt_side_r_tile(_s)

	if _s._nxt_side_r_tile_flg then return _s._nxt_side_r_tile end

	_s:nxt_side_r_tile__()

	return _s._nxt_side_r_tile
end

function Sp.nxt_side_r_tile__(_s)

	_s._nxt_side_r_tile = _s:tile_6_pos(_s:nxt_side_r_pos())
	_s._nxt_side_r_tile_flg = _.t
end

function Sp.nxt_side_r_is_block(_s)

	local t_tile = _s:nxt_side_r_tile()
	local ret = Tile.is_block(t_tile)
	return ret
end

function Sp.nxt_side_r__clr(_s)
	_s._nxt_side_r_pos_flg  = _.f
	_s._nxt_side_r_tile_flg = _.f
end

--

function Sp.is_leapupabl(_s) -- alias

	return _s:is_jmpabl()
end

function Sp.is_jmpabl(_s)

	local ret = _.f

	local foot_o_tile = _s:foot_o_tile()
	
	if Tile.is_block(foot_o_tile)
	or Tile.is_clmb( foot_o_tile)
	or Tile.is_elv(  foot_o_tile)
	-- or _s:is_on_chara()
	-- or _s:is_on_obj_block()
	-- or _s:on_6_mapobj()
	then
		ret = _.t
	end

	return ret
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

	-- _s._pos = n.vec()

	-- pos
	_s._foot_i_pos = n.vec()
	_s._foot_o_pos = n.vec()

	_s._head_o_pos = n.vec()

	_s._side_l_pos = n.vec()
	_s._side_r_pos = n.vec()

	_s._tilepos    = n.vec()
	_s._tilepos_d  = n.vec()

	-- nxt pos
	_s._nxt_pos           = n.vec()

	_s._nxt_foot_i_pos    = n.vec()
	_s._nxt_foot_i_up_pos = n.vec()

	_s._nxt_head_o_pos    = n.vec()

	_s._nxt_side_l_pos = n.vec()
	_s._nxt_side_r_pos = n.vec()

	-- pos tmp -- use local
	_s._pos_tmp1 = n.vec()
	_s._pos_tmp2 = n.vec()

	_s:cflg__f()
end

function Sp.cflg__f(_s) -- upd cache

	-- pos
	_s._c_tile_flg = _.f

	_s._foot_i_pos_flg    = _.f
	_s._c_foot_i_tile_flg = _.f

	_s._foot_o_pos_flg    = _.f
	_s._c_foot_o_tile_flg = _.f

	-- _s._head_i_pos_flg    = _.f
	-- _s._c_head_i_tile_flg = _.f

	_s._head_o_pos_flg    = _.f
	_s._c_head_o_tile_flg = _.f

	_s._side_l_pos_flg  = _.f
	_s._side_l_tile_flg = _.f

	_s._side_r_pos_flg  = _.f
	_s._side_r_tile_flg = _.f

	_s._tilepos_flg   = _.f
	_s._tilepos_d_flg = _.f
end

function Sp.nxt_cflg__f(_s) -- upd cache

	-- _s._nxt_pos_flg  = _.f

	_s:nxt_foot_i__clr()
	_s:nxt_foot_i_up__clr()
	_s:nxt_head_o__clr()
	_s:nxt_side_l__clr()
	_s:nxt_side_r__clr()
end

