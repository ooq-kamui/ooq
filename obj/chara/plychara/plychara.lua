log.scrpt("plychara.lua")

Plychara = {
	
	speed     = 4.5,

	jmp_h_max   = Map.sq,
	jmp_h_mrgn  = 2, -- 1,

	jmp_lv_dflt = 1,
	-- jmp_lv_dflt = 2,

	act_intrvl_time = 5,
	w = 20,
	
	name_idx_max = 1,
	z = 0.3,

	dir_h_dflt = u.dir_h[1],

	hld_idx_max    = 2,
	hld_weight_max = 2,
}

Plychara.pos_game_new = n.vec( 500, 200)

Plychara.cls = "plychara"
Plychara.fac = Obj.fac..Plychara.cls
Cls.add(Plychara)

-- static

function Plychara.cre(p_pos, dir)
	
	p_pos = p_pos or Plychara.pos_game_new
	dir   = dir   or Plychara.dir_h_dflt
	
	local name = "sanae"
	local prm = {
		nameHa = ha._(name),
	}
	local t_id = Sp.cre(Plychara, p_pos, prm)
	-- log._("plychara cre id", t_id)

	pst.scrpt(t_id, "dir_h__", {dir_h = dir})
	
	Map.add_chara(name) -- todo > method
	return t_id
end

-- script method

function Plychara.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Plychara)

	_s._name = ha.de(_s._nameHa)
	_s:anim__("walk")
	
	_s._speed = Plychara.speed
	_s._dir_h_Ha = ha._("l")
	_s._dir_v = ""
	
	_s._is_moving_h = _.f
	_s._is_moving_v = _.f
	_s._is_clmb_d   = _.f
	_s._is_clmb_u   = _.f
	_s._is_cruch    = _.f

	_s._is_jmp_start  = _.f
	_s._is_dive_start = _.f
	
	_s._vec_mv_dir = n.vec()

	_s._vec_on_chara = n.vec()

	_s._itm_selected = "wand001" -- name

	_s._jmp_lv = Plychara.jmp_lv_dflt

	_s._hld  = {}
	_s._clsn = {
		hld     = {},
		hrvst   = {},
		kitchen = {},
		reizoko = {},
		chara   = {},
		animal  = {},
		flpy    = {},
		pc      = {},
		shelf   = {},
		door    = {},
		tree    = {},
		block   = {},
	}
	_s._clsn_hldabl = {}

	local fairy_id = _s:fairy_id()
	-- log._("plychara.init fairy_id", fairy_id)

	local z = 0.01
	local t_pos = n.vec(0, Map.sq)
	pst.parent__(fairy_id, _s._id, z, t_pos)
end

function Plychara.upd(_s, dt)
	-- log._("plychara upd start")
	
	_s:vec_mv__(dt)
	
	_s:vec_tile__(dt)

	_s:vec_grv__(dt)
	_s._vec_grv = _s:dir__crct_hyprspc(_s._vec_grv)

	local dmy
	dmy, _s._vec_on_chara = _s:vec_on_clsn(dt)

	_s._vec_total = _s._vec_mv + _s._vec_tile + _s._vec_grv + _s._vec_on_chara

	_s:pos__add(_s._vec_total)
	
	_s:ox_dstrct__mv()
	
	_s:turn_time__add(dt)
	
	-- upd final
	_s:act__clr()
	_s:clsn__clr()

	_s:upd_final()
	-- log._("plychara upd end")
end

function Plychara.vec_mv__(_s, dt)

	vec.xy__clr(_s._vec_mv_dir)
	
	-- move h
	if _s._is_moving_h then

		_s._vec_mv_dir.x = 1

		if ha.eq(_s._dir_h_Ha, "l") then
			_s._vec_mv_dir.x = - _s._vec_mv_dir.x
		end
		_s:anim__("walk")
	end
	
	-- move v
	if _s._is_moving_v then

		local foot_i_tile = _s:foot_i_tile()
		local foot_o_tile = _s:foot_o_tile()

		if     _s._dir_v == "u" then

			if ( Tile.is_clmb(foot_i_tile) and not _s:head_o_is_block() ) then

				_s._vec_mv_dir.y =   1
				_s._is_clmb_u    = _.t
				_s:anim__("back")
			end

		elseif _s._dir_v == "d" then

			if     ( Tile.is_clmb(foot_i_tile) or Tile.is_clmb(foot_o_tile) ) then

				_s._vec_mv_dir.y = - 1
				_s._is_clmb_d    = _.t
				_s:anim__("back")

			elseif Tile.is_block(foot_o_tile) then
				_s._is_cruch = _.t
				_s:anim__("cruch")
			end
		end
	end

	_s._vec_mv_dir = _s:dir__crct_hyprspc(_s._vec_mv_dir)

	_s._vec_mv = _s._vec_mv_dir * _s._speed
end

function Plychara.anim__(_s, p_anim)

	Chara.anim__(_s, p_anim)
end

function Plychara.vec_grv__(_s, dt)

	if _s._is_jmp_start then

		_s:vec_grv__grv()
		_s._is_jmp_start = _.f
	else

		local on_chara_id, dmy = _s:vec_on_clsn(dt)

		if on_chara_id then
			vec.xy__clr(_s._vec_grv)
		else
			Sp.vec_grv__(_s, dt)
		end
	end
end

-- jmp

function Plychara.is_jmpabl(_s)

	local ret = _.f

	local foot_o_tile = _s:foot_o_tile()
	local foot_i_tile = _s:foot_i_tile()
	local on_chara_id = _s:vec_on_clsn(dt)
	
	if Tile.is_block(foot_o_tile)
	or Tile.is_clmb( foot_o_tile)
	or Tile.is_elv(  foot_o_tile)
	or on_chara_id
	or _s:is_on_obj_block()
	-- or _s:on_by_mapobj()
	then
		ret = _.t
	end

	return ret
end

-- function Plychara.jmp(_s, high)
function Plychara.jmp(_s)

	if not _s:is_jmpabl() then return end

	local jmp_lv = _s._jmp_lv

	if _s._is_cruch then jmp_lv = jmp_lv + 1 end

	local dst_y = Plychara.jmp_h_max * jmp_lv
	dst_y = dst_y + Plychara.jmp_h_mrgn

	local speed = accl.speed_by_dst(dst_y)

	_s._accl:speed_y__(speed)
	_s._is_jmp_start = _.t

	Se.pst_ply("jmp001")
end

function Plychara.arw_d_f(_s)

	_s:cruch__f()
end

function Plychara.cruch__f(_s)

	if not _s._is_cruch then return end

	_s._is_cruch = _.f
	_s:anim__("walk")
end

function Plychara.dir__crct_hyprspc(_s, dir)
	
	local is_hyprspc, hyprspc_dir = _s:is_hyprspc()

	if not is_hyprspc then return dir end

	if     ar.in_(hyprspc_dir, u.lr) then
		dir.y = 0
		
	elseif ar.in_(hyprspc_dir, u.ud) then
		dir.x = 0
	end
	
	return dir
end

function Plychara.is_hyprspc(_s)

	local is_inside, dir = map.is_inside_cmpr(_s:pos(), _s:map_rng_pos())

	local is_hyprspc = not is_inside

	return is_hyprspc, dir
end

function Plychara.ox_dstrct__mv(_s)

	-- dstrct__mv
	local is_dstrct_mv, dstrct_mv_dir = _s:is_dstrct_mv()
	-- log._("is_dstrct_mv", is_dstrct_mv, dstrct_mv_dir)
	
	if not is_dstrct_mv then return is_dstrct_mv end
	
	pst.scrpt(_s._game_id, "map_dstrct__mv", {dir = dstrct_mv_dir, plychara_dir = _s._dir_h_Ha})
	
	return is_dstrct_mv
end

function Plychara.is_dstrct_mv(_s, p_pos)

	p_pos = p_pos or _s:pos()

	local ret, dir = _.f, nil

	local dstrct_mv_rng_pos = _s:dstrct_mv_rng_pos()

	if     p_pos.x < dstrct_mv_rng_pos.min.x then
		ret, dir = _.t, "l"

	elseif p_pos.x > dstrct_mv_rng_pos.max.x then
		ret, dir = _.t, "r"

	elseif p_pos.y < dstrct_mv_rng_pos.min.y then
		ret, dir = _.t, "d"

	elseif p_pos.y > dstrct_mv_rng_pos.max.y then
		ret, dir = _.t, "u"
	end

	return ret, dir
end

function Plychara.dstrct_mv_rng_pos(_s)

	if _s._dstrct_mv_rng_pos then return _s._dstrct_mv_rng_pos end

	_s._dstrct_mv_rng_pos = {
		min = id.prp(_s._map_id, "_dstrct_mv_rng_pos_min"),
		max = id.prp(_s._map_id, "_dstrct_mv_rng_pos_max"),
	}
	return _s._dstrct_mv_rng_pos
end

function Plychara.crct_inside_map(_s, p_vec)
	-- nothing
	return p_vec
end

function Plychara.vec_on_clsn(_s, dt)
	
	local vec_on_obj
	local on_pos
	local on_id, o_cls = _s:on_clsn()
	
	if on_id and not _s._is_dive_start then

		if o_cls == ha._("chara") then
			on_pos = id.pos(on_id) + n.vec(0, Map.sq)
		end
		vec_on_obj = on_pos - _s:pos()
	else
		vec_on_obj = n.vec()
	end
	return on_id, vec_on_obj
end

function Plychara.on_msg(_s, msg_id, prm, sndr)

	local st

	Sp.on_msg(_s, msg_id, prm, sndr)
	
	st = _s:on_msg_clsn(msg_id, prm, sndr)
	if st then return end

	st = _s:on_msg_mv(msg_id, prm, sndr)
	if st then return end

	_s:on_msg_act(msg_id, prm, sndr)
end

function Plychara.on_msg_clsn(_s, msg_id, prm, sndr)

	if ha.eq(msg_id, "collision_response") then return _.t end
		
	if not ha.eq(msg_id, "contact_point_response") then return end
	
	-- local o_pos = prm.other_position
	local t_id  = prm.other_id
		
	if     ha.eq(prm.group, "chara" ) then
		_s:clsn_add("chara", t_id)

	elseif ha.eq(prm.group, "hld"   ) then
		if not ar.in_(t_id, _s._hld) then
			_s:clsn_add("hld", t_id)
		end

	elseif ha.eq(prm.group, "animal") then
		_s:clsn_add("animal", t_id)

	elseif ha.eq(prm.group, "tree"  ) then
		_s:clsn_add("tree", t_id)
		
	elseif ha.eq(prm.group, "box"   ) then
		_s:on_msg_clsn_box(t_id)
		
	elseif ha.eq(prm.group, "door"  ) then
		_s:clsn_add("door", t_id)
		
	elseif ha.eq(prm.group, "block" ) then
		_s:clsn_add("block", t_id)
	end
	return _.t
end

function Plychara.on_msg_clsn_box(_s, t_id)

	local t_nameHa = id.prp(t_id, "_nameHa")

	if     ha.eq(t_nameHa, "hrvst001"  ) then _s:clsn_add("hrvst"  , t_id)
	elseif ha.eq(t_nameHa, "reizoko001") then _s:clsn_add("reizoko", t_id)
	elseif ha.eq(t_nameHa, "kitchen001") then _s:clsn_add("kitchen", t_id)
	elseif ha.eq(t_nameHa, "flpy001"   ) then _s:clsn_add("flpy",    t_id)
	elseif ha.eq(t_nameHa, "pc001"     ) then _s:clsn_add("pc",      t_id)
	elseif ha.eq(t_nameHa, "shelf001"  ) then _s:clsn_add("shelf",   t_id)
	end
end

function Plychara.on_msg_mv(_s, msg_id, prm, sndr)
	
	if not ha.eq(msg_id, "mv") then return end

	if     ar.in_(prm.dir, u.dir_h) then
		
		_s._is_moving_h = _.t
		
		-- turn
		if not ha.eq(_s._dir_h_Ha, prm.dir) then
			_s._turn_time = 0 
			_s:flip_h__dir(prm.dir)
		end
		
		-- dive
		if prm.dive then _s._is_dive_start = _.t end
		
		_s._dir_h_Ha = ha._(prm.dir)

	elseif ar.in_(prm.dir, u.dir_v) then

		_s._is_moving_v = _.t

		if     prm.dir == "u" then _s._dir_v = "u"
		elseif prm.dir == "d" then _s._dir_v = "d"
		end
	end

	return _.t
end

function Plychara.on_msg_act(_s, msg_id, prm, sndr)
	-- log._("plychara on_msg_act", msg_id)
	
	if     ha.eq(msg_id, "jmp")      then
		-- _s:jmp(prm.high)
		_s:jmp()
	
	elseif ha.eq(msg_id, "arw_d_f")  then
		_s:arw_d_f()

	elseif ha.eq(msg_id, "itm_use")  then
		_s:itm_use()
		
	elseif ha.eq(msg_id, "hld__ox")  then -- hld switch
		_s:hld__ox()
	
	elseif ha.eq(msg_id, "hld__del") then
		_s:hld__del(prm.id)
	
	elseif ha.eq(msg_id, "to_door")  then
		_s:to_door(prm.door_id)

	elseif ha.eq(msg_id, "itm_selected__") then
		_s:itm_selected__(prm.itm_selected)	

	elseif ha.eq(msg_id, "menu_opn") then
		_s:menu_opn()
	end
end

function Plychara.final(_s)
end

-- method

function Plychara.menu_opn(_s)

	local is_icn_opn

	local t_clss = {"reizoko", "pc", "shelf", "door"}

	for idx, t_cls in pairs(t_clss) do
		if     #_s._clsn[t_cls] >= 1 then
			pst.scrpt(_s._clsn[t_cls][1], "opn")
			is_icn_opn = _.t
			break
		end
	end

	if not is_icn_opn and #_s._clsn.flpy >= 1 then
		pst.scrpt(_s._clsn.flpy[1], "opn")
		is_icn_opn = _.t
	end
	if not is_icn_opn then
		pst.scrpt(Game.id(), "bag_opn")
	end
end

function Plychara.itm_use(_s)
	
	local itm = _s._itm_selected -- name
	-- log._("plychara itm_use", itm)
	
	if     itm == "wand001" then
		pst.scrpt(_s:fairy_id(), "magic")
		
	elseif itm == "wand002" then
		Wall.__(_s:tilepos(), Wand.wand002.tile_idx)

	elseif itm == "wand003" then
		if #_s._clsn.tree > 0 then
			pst.scrpt(_s._clsn.tree[1], "trnsf_wood")
		end
	elseif itm == "wand004" then
		Fire.cre(_s:pos_fw(2/3))
		
	elseif itm == "wand005" then
		-- Warp.cre(_s:pos_fw(2/3))
		-- Block.cre()
	else
		log._("not use itm")
	end
end

function Plychara.itm_selected__(_s, itm)
	_s._itm_selected = itm
end

function Plychara.fairy_id(_s)
	local fairy_id = id.prp(_s._map_id , "_fairy_id")
	return fairy_id
end

function Plychara.pos_fw(_s, mlt)
	
	local t_pos = _s:pos()
	local df  = n.vec(Map.sq * mlt, 0)

	if     ha.eq(_s._dir_h_Ha, "l") then
		t_pos = t_pos - df

	elseif ha.eq(_s._dir_h_Ha, "r") then
		t_pos = t_pos + df
	end
	return t_pos
end

function Plychara.turn_time__add(_s, dt)

	_s._turn_time = _s._turn_time + dt
end

function Plychara.act__clr(_s)

	_s._is_moving_h = _.f
	_s._is_moving_v = _.f
	_s._is_clmb_d   = _.f
	_s._is_clmb_u   = _.f
	_s._is_dive_start = _.f

	-- _s._is_cruch = _.f
end

-- clsn

function Plychara.clsn_add(_s, target, id)
	
	if ar.in_(id, _s._hld) then return end

	ar.add(_s._clsn[target], id)
end

function Plychara.clsn__clr(_s)
	for key, clsn in pairs(_s._clsn) do
		ar.clr(_s._clsn[key])
	end
end

-- clsn_hldabl

function Plychara.clsn_hldabl__(_s)

	local cls = {
		"hld", "kitchen", "reizoko", "hrvst", "flpy",
		"pc", "shelf", "door", "animal", "block",
	}
	
	ar.clr(_s._clsn_hldabl)

	for idx, cls in pairs(cls) do
		for idx, id in pairs(_s._clsn[cls]) do
			ar.add(_s._clsn_hldabl, id)
		end
	end
	ar.exclude(_s._clsn_hldabl , _s._hld)
end

function Plychara.is_clsn_hldabl(_s)

	local ret = _.f

	local cnt = #_s._clsn_hldabl

	if cnt <= 0 then return ret, nil end

	ret = _.t

	local clsn_hldabl_id = _s._clsn_hldabl[1]

	return ret, clsn_hldabl_id
end

function Plychara.clsn_hldabl(_s)
	
	if not _s:is_clsn_hldabl() then return end

	local clsn_hldabl_id = _s._clsn_hldabl[1]
	return clsn_hldabl_id
end

-- hld

function Plychara.is_hld(_s)

	local ret = _.f

	local cnt = _s:hld_cnt()

	if cnt > 0 then ret = _.t end

	local t_id = _s._hld[cnt]

	return ret, t_id
end

function Plychara.hld_cnt(_s)
	local cnt = #_s._hld
	return cnt
end

function Plychara.hld_id(_s)
	
	local cnt = _s:hld_cnt()

	if cnt <= 0 then return end
	
	local t_id = _s._hld[cnt]
	return t_id
end

function Plychara.hld__add(_s, id)
	
	if not _s:is_hld_addabl_cnt() then return end

	ar.add(_s._hld, id)
	return #_s._hld
end

function Plychara.hld__del(_s)

	local p_id = _s._hld[#_s._hld]

	ar.del_by_val(p_id, _s._hld)

	if ha.eq(id.cls(p_id), "block") then -- use ??
		ar.del_by_val(p_id, _s._clsn.block)
	end

	return p_id
end

function Plychara.is_hld_addabl_cnt(_s)

	local ret = _.t

	if _s:hld_cnt() >= Plychara.hld_idx_max then ret = _.f end

	return ret
end

function Plychara.hld_weight(_s)

	local r_weight = 0
	local c_weight

	for idx, hld_id in pairs(_s._hld) do

		c_weight = id.Cls_prp_weight(hld_id)
		r_weight = r_weight + c_weight
	end

	return r_weight
end

function Plychara.is_hld_addabl_weight(_s)

	local t_id = _s:clsn_hldabl()

	if not t_id then return _.f end

	local t_weight = id.Cls_prp_weight(t_id, "weight")

	local hld_weight = _s:hld_weight()

	local ret = _.t

	if hld_weight + t_weight > Plychara.hld_weight_max then ret = _.f end

	return ret
end

function Plychara.is_hld_addabl(_s)

	local ret

	ret = _s:is_hld_addabl_cnt()

	if not ret then return ret end

	ret = _s:is_hld_addabl_weight()

	return ret
end

function Plychara.hld__ox(_s)
	-- log._("plychara hld__ox")

	_s:clsn_hldabl__()

	local is_hld, hld_id = _s:is_hld()

	local clsn_is_psting = _s:clsn_is_psting_cls()

	if is_hld and clsn_is_psting then
		log._("clsn_is_psting")
		_s:hld__x()
		return
	end

	local is_clsn_hldabl = _s:is_clsn_hldabl()

	local is_hld_addabl  = _s:is_hld_addabl()

	if is_clsn_hldabl and is_hld_addabl then
		_s:hld__o()
	else
		_s:hld__x()
	end
end

function Plychara.clsn_is_psting_cls(_s)

	local psting_cls = {"chara", "animal", "hrvst", "kitchen", "reizoko", }

	local ret = _.f

	return ret
end

function Plychara.hld__o(_s)

	local t_id = _s:clsn_hldabl()

	if not t_id then return end

	local hld_idx = _s:hld__add(t_id)

	pst.scrpt(t_id, "hld__o", {hld_id = _s._id, hld_idx = hld_idx})

	Se.pst_ply("hld")
end

function Plychara.hld__x(_s)

	if not (#_s._hld > 0) then return end

	local t_id = _s:hld__del()

	pst.scrpt(t_id, "hld__x")

	--
	-- other effect
	--
	if     #_s._clsn.chara   >= 1 then
		pst.scrpt(_s._clsn.chara[1], "present", {id = t_id})

	elseif #_s._clsn.animal  >= 1 then
		pst.scrpt(_s._clsn.animal[1], "present", {id = t_id})

	elseif #_s._clsn.hrvst   >= 1 then
		pst.scrpt(_s._clsn.hrvst[1], "in", {id = t_id})

	elseif #_s._clsn.kitchen >= 1 then
		pst.scrpt(_s._clsn.kitchen[1], "kitchen_o", {id = t_id})

	elseif #_s._clsn.reizoko >= 1 then
		pst.scrpt(_s._clsn.reizoko[1], "into_reizoko", {food_id = t_id})
	end
end

function Plychara.hld_tile_side(_s)

	local dir_h = ha.de(_s._dir_h_Ha)

	local side_is_block, t_tile = _s:side_is_block(dir_h)
	-- log._("hld_tile_side ", side_is_block, t_tile)
	
	if not side_is_block               then return end
	if not Magic.is_magic_vnsh(t_tile) then return end
	
	-- cre block obj
	local t_id = Block.cre(nil, t_tile)
	local hld_idx = _s:hld__o(t_id)

	-- tile emp
	local side_pos = _s:side_pos(dir_h)
	if dir_h == "l" then vec.xy__add(side_pos, -1, 0) end
	_s:tile__(Tile.emp, side_pos)
end

-- to xxx

function Plychara.to_cloud(_s)
	Sp.to_cloud(_s)
	pst.scrpt(Sys.cmr_id(), "pos__plychara")
end

function Plychara.to_door(_s, door_id)
	local t_pos = id.pos(door_id)
	_s:pos__(t_pos)
	pst.scrpt(Sys.cmr_id(), "pos__plychara")
end

