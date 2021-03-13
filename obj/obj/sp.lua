log.scrpt("sp.lua")

Sp = {}

-- static

function Sp.cre(Cls, p_pos, prm, scl)
	
	p_pos = p_pos or pos.pos_w()
	-- p_pos = p_pos or go.get_world_position()
	prm = prm or {}

	local t_url
	if Cls.Fac then
		-- log._("sp cre by Fac", Cls.cls)
		t_url = "/objFac/"..Cls.Fac
	else
		t_url = url._("/objFac/"..Cls.fac, Cls.cls)
	end

	-- name, anim
	prm.clsHa  = ha._(Cls.cls)
	if ha.is_emp(prm.nameHa) then
		prm.nameHa = ha._(Cls.cls..rnd.int_pad(Cls.name_idx_max))
	end
	if ha.is_emp(prm.animHa) then
		prm.animHa = prm.nameHa
	end

	-- game_id, map_id
	local map_id, game_id = Game.map_id()
	-- log._("sp cre game_id", game_id, "map_id", map_id)
	if ha.is_emp(map_id) then log._("Sp.cre map_id is_emp") return end
	
	prm.game_id   = game_id
	prm.map_id    = map_id
	prm.parent_id = map_id

	-- z
	prm.z   = Cls.z or 0.2
	p_pos.z = Cls.z or 0.2
	
	-- scl
	scl = scl or nil -- 1 -- 0.2
	if scl == 0 then scl = 0.2 end
	
	-- log._("scl", scl, Cls.cls)
	-- log._("sp cre t_url", t_url)
	ar.key___(prm)
	ar.val_str_2_ha(prm)
	local t_id = factory.create(t_url, p_pos, nil, prm, scl)
	-- local id = factory.create(t_url, p_pos, nil, prm)
	-- local id = factory.create(t_url, p_pos, nil, prm, nil)
	
	-- pst.scrpt(t_id, "scl_anm__1")
	return t_id
end

-- script method

function Sp.init(_s)
	
	_s._id = id._()
	
	_s._foot_dst_i = _s:Cls().foot_dst_i or Map.sqh

	_s._w = _s:Cls().w or Map.sq

	_s:parent__map(_s._parent)

	_s:map_obj__add()

	local anim = _s._animHa or _s._nameHa
	_s:anim__(anim)

	_s._act_intrvl = 0

	_s:vec__init()
	_s:pos__init()
end

function Sp.on_msg(_s, msg_id, prm, sender)
	
	if     ha.eq(msg_id, "pos__") then
		_s:pos__(prm.pos)
		
	elseif ha.eq(msg_id, "z__") then
		_s:z__(prm.z)
	
	elseif ha.eq(msg_id, "__") then
		for key, val in pairs(prm) do
			_s:__(key, val)
		end
		
	elseif ha.eq(msg_id, "anim__") then
		_s:anim__(prm.anim)

	elseif ha.eq(msg_id, "dir_h__") then
		_s:dir_h__(prm.dir_h)
		
	elseif ha.eq(msg_id, "dsp__x") then
		_s:dsp__x()
		
	elseif ha.eq(msg_id, "dsp__o") then
		_s:dsp__o()

	elseif ha.eq(msg_id, "parent__") then
		_s:parent__(prm.parent_id, prm.z, prm.pos)

	elseif ha.eq(msg_id, "parent__map") then
		_s:parent__map(prm.z)
	
	elseif ha.eq(msg_id, "to_cloud") then
		-- log._("to_cloud")
		_s:to_cloud()

	elseif ha.eq(msg_id, "mv__pos") then
		_s:mv__pos(prm.pos)

	elseif ha.eq(msg_id, "anm_scl__1") then
		_s:anm_scl__1()

	elseif ha.eq(msg_id, "anm_pos__") then
		_s:anm_pos__(prm.pos, prm.time)
	end
end

function Sp.final(_s)
	
	_s:map_obj__del()
	
	if _s:cls_is_mapobj() then
		_s:mapobj_del()
	end
end

-- method

function Sp.__(_s, key, val)
	_s[key] = val
end

function Sp.pos(_s)
	local t_pos = id.pos(_s._id)
	return t_pos
end

function Sp.pos__(_s, p_pos)
	id.pos__(_s._id, p_pos)
end

function Sp.dsp__o(_s)
	pst._("#sprite", "enable")
end

function Sp.dsp__x(_s)
	pst._("#sprite", "disable")
end

function Sp.scl(_s)
	local vec = go.get("#sprite", "scale")
	return vec
end

function Sp.scl__(_s, vec)
	go.set("#sprite", "scale", vec)
end

function Sp.scl__0(_s)
	_s:scl__(n.vec())
end

function Sp.scl__1(_s)
	_s:scl__(n.vec(1, 1))
end

function Sp.url(_s, cmp)
	local t_url = url._(_s._id, cmp)
	return t_url
end

function Sp.pos_w(_s)

	local pos = id.pos_w(_s._id)
	-- local pos = go.get_world_position(_s._id)

	return pos
end

function Sp.z(_s)
	local t_pos = _s:pos()
	return t_pos.z
end

function Sp.z__(_s, z)
	z = z or 0
	local t_pos = _s:pos()
	t_pos.z = z
	-- log._("sp z__", z)
	go.set_position(t_pos)
	_s._z = z
end

function Sp.log(_s, ...)
	log._(_s._clsHa, ...)
end

function Sp.log_cls(_s, cls, ...)
	if _s._clsHa == ha._(cls) then
		log._(cls, ...)
	end
end

function Sp.anim__(_s, anim) -- anim(hash())
	
	if not anim then return end

	-- log._("anim", anim, _s._clsHa, _s._nameHa)
	pst._("#sprite", "play_animation", {id = anim})
	_s._animHa = anim
end

function Sp.foot_i_tile(_s)
	
	local t_pos  = _s:foot_i_pos()
	local t_tile = _s:tile(t_pos)
	return t_tile
end

function Sp.foot_o_tile(_s)
	
	local t_pos  = _s:foot_o_pos()
	-- log._("sp foot_o_tile t_pos", t_pos)

	local t_tile = _s:tile(t_pos)
	return t_tile
end

function Sp.foot_dst_i(_s)
	
	local foot_dst_i

	if ar.inHa(_s._clsHa, {"kagu"}) then
		local h = go.get("#sprite", "size.y")
		foot_dst_i = num._2_int_d(h / 2)
	else
		foot_dst_i = _s._foot_dst_i
	end
	return foot_dst_i
end

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

-- upd pos

function Sp.upd_final(_s)
    _s:pos_flg__clr()
end

function Sp.upd_pos_static(_s, dt)
	
	_s:vec_tile__(dt)
	
	_s:vec_grv__(dt)

	_s._vec_total = _s._vec_tile + _s._vec_grv

	_s:pos__add(_s._vec_total)

	-- mapobj
	if _s:cls_is_mapobj() then
		_s:mapobj__()
	end
end

function Sp.cls_is_mapobj(_s)
	
	local ret = ar.inHa(_s._clsHa, Mapobj.cls)
	return ret
end

function Sp.pos__add(_s, p_vec)
	
	if _s:is_pause() then return end
	
	p_vec = _s:crct_vec(p_vec)
	
	local pos = _s:pos() + p_vec
	_s:pos__(pos)
end

function Sp.crct_vec(_s, p_vec)
	
	if not (_s._parent_id == _s._map_id) then return p_vec end
	
	p_vec = _s:crct_vec_block(p_vec) -- better -> crct_vec_tile_block
	
	-- crrct clmb
	p_vec = _s:crct_clmb(p_vec)
	
	-- crrct inside map
	p_vec = _s:crct_inside_map(p_vec)
	
	return p_vec
end

function Sp.crct_vec_block(_s, p_vec)
	
	if ha.eq(_s._clsHa, "fire") then return p_vec end
	
	-- crrct side block
	p_vec = _s:crct_side(p_vec)
	
	-- crrct foot block
	p_vec = _s:crct_foot(p_vec)
	
	-- crrct head block
	p_vec = _s:crct_head(p_vec)
	
	return p_vec
end

function Sp.crct_foot(_s, p_vec)
	
	local cf_pos_i    = _s:foot_i_pos()
	local nf_pos_i    = cf_pos_i + p_vec
	local nf_pos_i_up = nf_pos_i + n.vec(0, Map.sq)
	
	if not (_s:is_block(nf_pos_i) and not _s:is_block(nf_pos_i_up)) then return p_vec end

	p_vec.y = map.pos_by_pos(nf_pos_i).y + Map.sqh + _s:foot_dst_i() - _s:pos().y
	return p_vec
end

function Sp.crct_head(_s, p_vec)

	local head_o_pos_nxt = _s:head_o_pos() + p_vec
	
	if not _s:is_block(head_o_pos_nxt) then return p_vec end
	
	p_vec.y = map.pos_by_pos(head_o_pos_nxt).y - Map.sq - _s:pos().y
	return p_vec
end

function Sp.crct_side(_s, p_vec)
	
	local n_side_l_is_block = _s:side_is_block("l", p_vec)
	local n_side_r_is_block = _s:side_is_block("r", p_vec)
	
	if (not n_side_l_is_block) and (not n_side_r_is_block) then return p_vec end
	if (n_side_l_is_block) and (n_side_r_is_block) then return p_vec end

	local crct_pos_x
	local df_x = Map.sqh + _s._w / 2
	if     n_side_l_is_block then
		crct_pos_x = map.pos_by_pos(_s:side_pos("l", p_vec) + n.vec(-1,0)).x + df_x
		
	elseif n_side_r_is_block then
		crct_pos_x = map.pos_by_pos(_s:side_pos("r", p_vec)).x - df_x
	end
	p_vec.x = crct_pos_x - _s:pos().x
	return p_vec
end

function Sp.side_pos(_s, dir_h, p_vec)
	p_vec = p_vec or n.vec()
	local df_x = _s._w / 2
	if dir_h == "l" then df_x = - df_x end
	local side_pos = _s:pos() + p_vec + n.vec(df_x, 0)
	return side_pos
end

function Sp.crct_clmb(_s, p_vec)
	
	if not (_s._moving_v and _s._dir_v == "u") then return p_vec end

	local cf_pos_i = _s:foot_i_pos()
	local nf_pos_i = cf_pos_i + p_vec
	
	if not (_s:is_clmb(cf_pos_i) and not _s:is_clmb(nf_pos_i)) then return p_vec end
	
	p_vec.y = map.pos_by_pos(cf_pos_i).y + Map.sq - _s:pos().y
	return p_vec
end

function Sp.map_is_inside(_s, pos)

	pos = pos or _s:pos()
	
	local is_inside, dir = map.is_inside_cmpr(pos, _s:map_inside_rng_pos())
	return is_inside, dir
end

function Sp.map_inside_rng_pos(_s)

	if _s._map_inside_rng_pos then return _s._map_inside_rng_pos end

	local tilesize = id.prp(_s._map_id, "_tilesize")
	_s._map_inside_rng_pos = map.inside_rng_pos(_s._map_id, "ground", tilesize)
	
	return _s._map_inside_rng_pos
end

function Sp.crct_inside_map(_s, p_vec)
	
	local pos_nxt = _s:pos() + p_vec

	local is_inside, dir = _s:map_is_inside(pos_nxt)
	
	if is_inside then return p_vec end

	-- log._("crct_inside_map", dir)

	
	local inside_rng_pos = _s:map_inside_rng_pos()
	
	if     dir == "l" then
		pos_nxt.x = inside_rng_pos.min.x

	elseif dir == "r" then
		pos_nxt.x = inside_rng_pos.max.x

	elseif dir == "d" then
		pos_nxt.y = inside_rng_pos.min.y

	elseif dir == "u" then
		pos_nxt.y = inside_rng_pos.max.y
	end
	
	p_vec = pos_nxt - _s:pos()
	
	return p_vec
end

function Sp.map_rng_pos(_s)

	if _s._map_rng_pos then return _s._map_rng_pos end

	if not _s._map_id then return end

	local tilesize = id.prp(_s._map_id, "_tilesize")
	_s._map_rng_pos = map.rng_pos(_s._map_id, "ground", tilesize)

	return _s._map_rng_pos
end

function Sp.vec_tile__(_s, dt)
	
	-- local foot_i_tile = _s:foot_i_tile()

	if Tile.is_elv( _s:foot_i_tile() ) then
		vec.xy__(_s._vec_tile, 0, 1)
	else
		vec.xy__(_s._vec_tile, 0, 0)
	end
end

function Sp.vec_grv__(_s, dt)
	-- log._("sp vec_grv__ speed", _s._accl._speed)

	local foot_i_tile = _s:foot_i_tile()
	local foot_o_tile = _s:foot_o_tile()
	
	if     _s:is_on_obj_block() then
		_s:vec_grv__clr()

	elseif _s._is_fly then
		_s:vec_grv__clr()
	
	elseif _s._hld_id then
		_s:vec_grv__clr()
	
	elseif _s._kitchen_id then
		_s:vec_grv__clr()
	
	elseif _s._bear_tree_id then
		_s:vec_grv__clr()
		
	elseif Tile.is_elv(  foot_i_tile)
		or Tile.is_elv(  foot_o_tile)
		or Tile.is_clmb( foot_i_tile)
		or Tile.is_clmb( foot_o_tile)
		or Tile.is_block(foot_o_tile) then

		_s:vec_grv__clr()
	else
		_s._accl:speed__add_accl()
		_s._vec_grv = _s._accl:speed()
	end
end

function Sp.vec_grv__clr(_s)
	vec.xy__clr(_s._vec_grv)
end

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

function Sp.head_o_is_block(_s)
	local t_pos = _s:head_o_pos()
	local ret = _s:is_block(t_pos)
	return ret
end

function Sp.side_is_block(_s, dir_h, p_vec)
	
	p_vec = p_vec or n.vec()
	local t_pos = _s:side_pos(dir_h) + p_vec
	if dir_h == "l" then t_pos.x = t_pos.x - 1 end
	
	return _s:is_block(t_pos)
end

function Sp.is_block(_s, p_pos)

	local ret = _.f
	local t_tile = _s:tile(p_pos)

	if Tile.is_block(t_tile) then
		ret = _.t
	else
		t_tile = nil
	end
	return ret, t_tile
end

function Sp.is_clmb(_s, p_pos)
	
	local ret = _.f
	local t_tile = _s:tile(p_pos)
	
	if Tile.is_clmb(t_tile) then
		ret = _.t
	end
	return ret
end

function Sp.is_soil(_s, p_pos)
	
	local ret = _.f
	local t_tile = _s:tile(p_pos)
	
	if ar.in_(t_tile, Tile.soil) then
		ret = _.t
	end
	return ret
end

function Sp.foot_o_is_block(_s)
	local ret = _.f
	local foot_o_tile = _s:foot_o_tile()
	if Tile.is_block(foot_o_tile) then
		ret = _.t
	end
	return ret
end

function Sp.to_cloud(_s)
	local t_pos = _s:cloud_pos()
	_s:pos__(t_pos)
end

function Sp.map_obj__add(_s)
	
	if ha.is_emp(_s._clsHa) then return end
	
	local clsDe = ha.de(_s._clsHa)

	if not Map.st.obj(clsDe) then Map.st.obj__init(clsDe) end
	
	ar.add_unq(_s._id, Map.st.obj(clsDe))
end

function Sp.map_obj__del(_s)
	ar.del_by_val(_s._id, Map.st.obj_by_ha(_s._clsHa))
end

function Sp.mapobj_del(_s)
	Mapobj.del(_s:tilepos(), _s._clsHa, _s._id)
end

function Sp.is_loop__act_intrvl__(_s, dt)
	
	if _s:is_pause() then return end

	local is_loop = _s:act_intrvl__(dt)
	return is_loop
end

function Sp.act_intrvl__(_s, dt)
	local act_intrvl_time = _s:Cls().act_intrvl_time
	local is_loop
	_s._act_intrvl, is_loop = num.pls_loop(_s._act_intrvl, dt, act_intrvl_time)
	return is_loop
end

function Sp.say(_s, str)
	
	local idx, len
	if not str then
		idx = rnd.int(1, #Serifu._)
		-- log._("say", idx)
		str = Serifu._[idx].txt
		len = Serifu._[idx].len
	end
	
	local id = Fuki.cre(nil, {parent_id = _s._id})
	pst.scrpt(id, "s", {str = str, len = len})
end

function Sp.tilepos_arund(_s)
	
	local tilepos = _s:tilepos()
	local tilepos_arund = Map.tilepos_arund(tilepos)
	return tilepos_arund
end

function Sp.obj_arund(_s, clsHa)

	local obj = Mapobj.obj_arund(_s:tilepos(), clsHa)
	return obj
end

function Sp.tilepos_d(_s)
	local tilepos_d = _s:tilepos() + n.vec(0, -1)
	return tilepos_d
end

function Sp.obj_d(_s, clsHa)
	local obj = Mapobj.obj(_s:tilepos_d(), clsHa)
	return obj
end

function Sp.mapobj__(_s)
	-- log._("sp mapobj__")
	
	local tilepos = _s:tilepos()
	
	Mapobj.__(tilepos, _s._clsHa, _s._id)
	
	if _s.tilepos_pre
	and ((tilepos.x ~= _s.tilepos_pre.x) or (tilepos.y ~= _s.tilepos_pre.y)) then
		Mapobj.del(_s.tilepos_pre, _s._clsHa, _s._id)
	end
	
	_s.tilepos_pre = tilepos
end

function Sp.is_on_obj_block(_s)

	local ret = _.f
	
	local block = _s:obj_d(ha._("block"))

	local block_id
	for id, val in pairs(block) do
		block_id = id
		break
	end

	if not block_id then return ret, nil end

	local block_pos = id.pos(block_id)
	
	if num.is_rng(_s:foot_o_pos().y, {block_pos.y + Map.sqh*3/4, block_pos.y + Map.sqh}) then
		ret = _.t
	else
		return ret, nil
	end
	return ret, block_id
end

function Sp.tile(_s, p_pos)
	
	p_pos = p_pos or _s:pos()
	
	local t_tile = map.tile(p_pos, _s._map_id, "ground")
	return t_tile
end

function Sp.tile__(_s, p_tile, p_pos)

	p_pos = p_pos or _s:pos()

	map.tile__(p_pos, p_tile, _s._map_id, "ground")
end

function Sp.tilepos(_s)
	return map.pos_2_tilepos(_s:pos())
end

function Sp.on_clsn(_s)
	
	local on_id, on_cls = nil, nil
	local o_obj, o_pos
	local t_clss = {"chara"} -- {"chara", "block"}
	
	for i, t_cls in pairs(t_clss) do
		for j, clsn_id in pairs(_s._clsn[t_cls]) do
			clsn_pos = id.pos(clsn_id)
			if t_cls == "block" and ar.inHa(clsn_id, _s._hld) then
			else
				if _s:pos().y > clsn_pos.y + Map.sq*3/4 then
					on_id = clsn_id
					on_cls = id.prp(on_id, "_clsHa")
					break
				end
			end
		end
	end
	-- log._(on_id)
	return on_id, on_cls
end

function Sp.trnsf(_s, p_Cls, prm, scl)
	
	local t_pos = _s:pos_w()
	
	local t_id = p_Cls.cre(t_pos, prm, scl)
	
	_s:del()

	return t_id
end

function Sp.per_trnsf(_s, per, p_Cls, prm, scl)
	
	if not rnd.by_p(per) then return end
	
	return Sp:trnsf(p_Cls, prm, scl)
end

function Sp.del(_s)
	go.delete()
end

function Sp.per_del(_s, per)

	local flg = rnd.by_p(per)
	
	if flg then _s:del() end

	-- log._("per del", flg)
	return flg
end

function Sp.is_food(_s)
	return ar.inHa(_s._clsHa, Food.cls)
end

function Sp.is_pause(_s)
	-- local ret = Map.pause
	
	local ret = id.prp(_s:map_id(), "_pause")
	-- log._("sp.is_pause", ret)
	
	return ret
end

function Sp.id(_s)
	return _s._id
end

function Sp.game_id(_s)
	return _s._game_id
end

function Sp.map_id(_s)
	return _s._map_id
end

function Sp.plychara_id(_s)
	local plychara_id = id.prp(_s:map_id(), "_plychara_id")
	return plychara_id
end

function Sp.plychara_pos(_s)
	local t_pos = id.pos(_s:plychara_id())
	return t_pos
end

function Sp.cloud_id(_s)
	local cloud_id = id.prp(_s:map_id(), "_cloud_id")
	return cloud_id
end

function Sp.cloud_pos(_s)
	local t_pos = id.pos(_s:cloud_id())
	return t_pos
end

function Sp.parent__(_s, parent_id, z, p_pos)

	z = z or 0.2

	pst.parent__(_s._id, parent_id, z, p_pos)
end

function Sp.parent__map(_s)
	
	local z = _s:Cls().z or 0.2
	
	pst.parent__(_s._id, _s:map_id(), z)
end

function Sp.cls(_s)
	return _s._clsHa
end

function Sp.name(_s)
	return _s._nameHa
end

function Sp.Cls(_s, p_prp)

	if ha.is_emp(_s._clsHa) then log._("sp cls is_emp") return end

	local t_Cls = Cls._(_s._clsHa)
	
	if not t_Cls then log._("sp cls Cls[_s._clsHa] is nil") return end
	
	if not p_prp then
		return t_Cls
	else
		return t_Cls[p_prp]
	end
end

function Sp.ply_slt_idx(_s)
	local game_id = _s:game_id()
	local ply_slt_idx = id.prp(game_id, "_ply_slt_idx")
	return ply_slt_idx
end

-- dir

function Sp.dir_h__(_s, dir_h)
	-- log._("Sp.dir_h__", dir_h)
	
	_s._dir_h = ha._(dir_h)
	_s:flip_h__()
end

function Sp.dir_h__rnd(_s)
	
	local dir_h = rnd.ar(u.dir_h)
	_s:dir_h__(dir_h)
end

function Sp.dir_v__(_s, dir_v)
	
	_s._dir_v = dir_v
end

function Sp.dir_v__rnd(_s)
	
	local dir_v = ""
	if rnd.by_f(2/3) then
		dir_v = rnd.ar(u.dir_v)
		if rnd.by_f(1/2) then -- / 2
			dir_v = dir_v .. "/2"
		end
	end
	_s:dir_v__(dir_v)
end

function Sp.flip_h__(_s, dir_h)

	if dir_h then _s:dir_h__(dir_h) end
	
	local val = _.f
	if     ha.eq(_s._dir_h, "l") then
		val = _.f
	elseif ha.eq(_s._dir_h, "r") then
		val = _.t
	end
	sprite.set_hflip("#sprite", val)
end

-- mv

function Sp.mv__pos(_s, p_pos)
	_s:anm_pos__(p_pos)
end

-- anm

function Sp.anm_cancel_pos(_s)
	go.cancel_animations(_s._id, "position")
end

function Sp.anm_scl__1(_s)
	-- log._("sp anm_scl__1")
	anm.scl__1(_s._id)
end

function Sp.anm_pos__(_s, p_pos, time)

	anm.pos__(_s:id(), p_pos, time)
end

function Sp.vec__init(_s)

	_s._accl      = n.Accl()

	_s._vec_grv   = n.vec()
	_s._vec_mv    = n.vec()
	_s._vec_tile  = n.vec()

	_s._vec_total = n.vec()
end

function Sp.pos__init(_s)

	_s._foot_i_pos = n.vec()
	_s._foot_o_pos = n.vec()
	_s._head_o_pos = n.vec()

	_s:pos_flg__f()
end

function Sp.pos_flg__clr(_s)
	_s:pos_flg__f()
end

function Sp.pos_flg__f(_s)

	_s._foot_i_pos_flg = _.f
	_s._foot_o_pos_flg = _.f
	_s._head_o_pos_flg = _.f
end

--[[
function Sp.on_block(_s) -- old
	return _s:foot_o_is_block()
end
--]]

--[[
function Sp.map_cnt_del(_s) -- old
	_s:map_obj__del()
end
--]]

--[[
function Sp.wpos(_s) -- old
	return _s:pos_w()
end
--]]

--[[
function Sp.vec_grv(_s, dt) -- old - static
	
	local foot_i_tile = _s:foot_i_tile()
	local foot_o_tile = _s:foot_o_tile()
	local t_vec
	
	if     _s:is_on_obj_block() then
		-- log._("is_on_obj_block")
		t_vec = n.vec()

	elseif _s._is_fly then
		t_vec = n.vec()
	
	elseif _s._hld_id then
		-- log._("sp hld_id", _s._hld_id)
		t_vec = n.vec()
	
	elseif _s._kitchen_id then
		t_vec = n.vec()
	
	elseif _s._bear_tree_id then
		t_vec = n.vec()
		
	elseif Tile.is_elv(  foot_i_tile)
		or Tile.is_elv(  foot_o_tile)
		or Tile.is_clmb( foot_i_tile)
		or Tile.is_clmb( foot_o_tile)
		or Tile.is_block(foot_o_tile) then
		t_vec = n.vec()
	else
		t_vec = _s:vec_grv_cnst(dt)
	end
	return t_vec
end
--]]

--[[
function Sp.vec_grv_cnst(_s, dt) -- old
	
	local speed = 3 -- 1
	local t_vec = Accl.grv_cnst * speed
	return t_vec
end
--]]

