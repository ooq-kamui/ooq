log.scrpt("plychara.lua")

Play_chara = {}

Plychara = {
	
	speed     = 4.5,
	speed_jmp = 1.5, -- vec.y * ?
	jmp_h_max = Map.sq + 1,

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
Plychara.Fac = Obj.fac..Plychara.cls
Cls.add(Plychara)

-- static

function Plychara.cre(pos, dir)
	
	pos = pos or Plychara.pos_game_new
	dir = dir or Plychara.dir_h_dflt
	
	local name = "sanae"
	local prm = {
		nameHa = ha._(name),
	}
	local t_id = Sp.cre(Plychara, pos, prm)
	-- log._("plychara cre id", t_id)

	pst.scrpt(t_id, "dir_h__", {dir_h = dir})
	
	Map.add_chara(name) -- todo > method
	return t_id
end

-- script method

function Plychara.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Plychara)
	
	_s._speed = Plychara.speed
	_s._dir_h = ha._("l")
	_s._dir_v = ""
	
	_s._moving_h  = _.f
	_s._moving_v  = _.f
	_s._clmb_d   = _.f
	_s._clmb_u   = _.f
	_s._is_jmping = _.f
	_s._jmp_h_t   = 0

	_s._dive      = _.f
	
	_s._itm_selected = "wand001" -- name

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

	-- fairy
	local fairy_id = _s:fairy_id()
	-- log._("plychara.init fairy_id", fairy_id)

	local z = 0.01
	local t_pos = n.vec(0, Map.sq)
	pst.parent__(fairy_id, _s._id, z, t_pos)
end

function Plychara.upd(_s, dt)
	-- log._("plychara upd", _s._dir_h)
	
	local dir = n.vec()
	local foot_o_tile = _s:foot_o_tile()
	local foot_i_tile = _s:foot_i_tile()
	
	-- vec on_chara
	local is_on_chara, vec_on_chara = _s:vec_on_clsn(dt)
	
	if _s._moving_h then
		dir.x = 1
		if ha.eq(_s._dir_h, "l") then dir.x = - dir.x end
	end
	
	-- v move
	-- jmping
	if     _s._is_jmping then

		if     _s:head_o_is_block() then
			_s:jmp__off()

		elseif _s:is_jmp_h_t() then
			_s:jmp__off()
		else
			dir.y = 1
			-- dir.y = 1.5
		end

	elseif _s._moving_v then

		if     _s._dir_v == "u" 
		   and Tile.is_clmb(foot_i_tile) and not _s:head_o_is_block() then

			dir.y =  1
			_s._clmb_u = _.t

		elseif _s._dir_v == "d"
		   -- and not _s._is_jmping
		   and (Tile.is_clmb(foot_i_tile) or Tile.is_clmb(foot_o_tile)) then

			dir.y = -1
			_s._clmb_d = _.t
		end
	end
	dir = _s:dir__crct_hyprspc(dir)
	
	local vec_mv = dir * _s._speed
	if _s._is_jmping then vec_mv.y = vec_mv.y * Plychara.speed_jmp end
	
	-- vec tile
	local vec_tile = _s:vec_tile(dt)

	-- vec grv
	local vec_grv
	if is_on_chara then
		vec_grv = n.vec()
	else
		vec_grv = _s:vec_grv(dt)
	end
	vec_grv = _s:dir__crct_hyprspc(vec_grv)
	
	-- total vec
	local vec_total = vec_mv + vec_tile + vec_on_chara + vec_grv
	_s:pos__add(vec_total)
	
	-- dstrct__mv
	-- local is_dstrct_mv = _s:ox_dstrct__mv() -- ??
	_s:ox_dstrct__mv()
	
	_s._turn_time = _s._turn_time + dt
	
	-- act clr
	_s._moving_h = _.f
	_s._moving_v = _.f
	_s._clmb_d  = _.f
	_s._clmb_u  = _.f
	_s._dive     = _.f
	
	_s:clsn_clr()
end

-- jmp

function Plychara.is_jmpabl(_s)

	local ret = _.f

	local foot_o_tile = _s:foot_o_tile()
	local foot_i_tile = _s:foot_i_tile()
	local is_on_chara, vec_on_chara = _s:vec_on_clsn(dt)
	
	if Tile.is_block(foot_o_tile)
	or is_on_chara
	or Tile.is_clmb(foot_o_tile)
	or Tile.is_elv(  foot_o_tile)
	or _s:is_on_obj_block()
	-- or _s:on_by_mapobj()
	then
		ret = _.t
	end

	return ret
end

function Plychara.jmp__start(_s)

	if _s._is_jmping then return end

	if not _s:is_jmpabl() then return end

	_s._is_jmping = _.t
	_s._jmp_h_t   = _s:pos().y + Plychara.jmp_h_max

	Se.pst_ply("jmp001")
	
	-- Msg.s("jmp") -- msg debug
end

function Plychara.is_jmp_h_t(_s)

	local ret = _.f

	if _s:pos().y >= _s._jmp_h_t then
		ret = _.t
	end

	return ret
end

function Plychara.jmp__off(_s)

	_s._is_jmping = _.f
	_s._jmp_h_t   = 0
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
	
	pst.scrpt(_s._game_id, "map_dstrct__mv", {dir = dstrct_mv_dir, plychara_dir = _s._dir_h})
	
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

function Plychara.crct_inside_map(_s, vec)

	-- nothing ???
	
	return vec
end

function Plychara.vec_on_clsn(_s, dt)
	
	local vec_on_obj
	local on_pos
	local on_id, o_cls = _s:on_clsn()
	
	if on_id and not _s._is_jmping and not _s._dive then
		if o_cls == ha._("chara") then
			on_pos = id.pos(on_id) + n.vec(0, Map.sq)
		end
		vec_on_obj = on_pos - _s:pos()
	else
		vec_on_obj = n.vec()
	end
	return on_id, vec_on_obj
end

function Plychara.on_msg(_s, msg_id, prm, sender)

	local st

	Sp.on_msg(_s, msg_id, prm, sender)
	
	st = _s:on_msg_clsn(msg_id, prm, sender)
	if st then return end

	_s:on_msg_mv(msg_id, prm, sender)

	_s:on_msg_act(msg_id, prm, sender)
end

function Plychara.on_msg_clsn(_s, msg_id, prm, sender)

	if ha.eq(msg_id, "collision_response") then return _.t end
		
	if not ha.eq(msg_id, "contact_point_response") then return end
	
	local o_pos = prm.other_position
	local o_id  = prm.other_id
	local o_name = id.prp(o_id, "_nameHa")
		
	if     ha.eq(prm.group, "chara") then
		_s:clsn_add("chara", o_id)

	elseif ha.eq(prm.group, "hld") then
		if not ar.in_(o_id, _s._hld) then
			_s:clsn_add("hld", o_id)
		end

	elseif ha.eq(prm.group, "animal") then
		_s:clsn_add("animal", o_id)

	elseif ha.eq(prm.group, "tree") then
		_s:clsn_add("tree", o_id)
		
	elseif ha.eq(prm.group, "box") then
		
		if     ha.eq(o_name, "hrvst001") then
			_s:clsn_add("hrvst"  , o_id)
		
		elseif ha.eq(o_name, "reizoko001") then
			_s:clsn_add("reizoko", o_id)
		
		elseif ha.eq(o_name, "kitchen001") then
			_s:clsn_add("kitchen", o_id)
		
		elseif ha.eq(o_name, "flpy001") then
			_s:clsn_add("flpy", o_id)
		
		elseif ha.eq(o_name, "pc001") then
			_s:clsn_add("pc", o_id)
		
		elseif ha.eq(o_name, "shelf001") then
			_s:clsn_add("shelf", o_id)
		end
	elseif ha.eq(prm.group, "door") then
		_s:clsn_add("door", o_id)
		
	elseif ha.eq(prm.group, "block") then
		_s:clsn_add("block", o_id)
	end
	return _.t
end

function Plychara.on_msg_mv(_s, msg_id, prm, sender)
	
	if not ha.eq(msg_id, "mv") then return end

	if ar.in_(prm.dir, u.dir_h) then
		
		_s._moving_h = _.t
		
		-- turn
		if not ha.eq(_s._dir_h, prm.dir) then
			_s._turn_time = 0 

			local val
			if     prm.dir == "l" then val = _.f
			elseif prm.dir == "r" then val = _.t
			end
			sprite.set_hflip("#sprite", val)
		end
		
		-- dive
		if prm.dive then _s._dive = _.t end
		
		_s._dir_h = ha._(prm.dir) -- new

	elseif prm.dir == "u" then
		_s._moving_v = _.t
		_s._dir_v = "u"

	elseif prm.dir == "d" then
		_s._moving_v = _.t
		_s._dir_v = "d"
	end
end

function Plychara.on_msg_act(_s, msg_id, prm, sender)
	-- log._("plychara on_msg_act", msg_id)
	
	if     ha.eq(msg_id, "jmp") then
		_s:jmp__start()
	
	elseif ha.eq(msg_id, "itm_use") then -- wand(itm)
		_s:itm_use()
		
	elseif ha.eq(msg_id, "hld__ox") then -- input hld switch
		_s:hld__ox()
	
	elseif ha.eq(msg_id, "hld__del") then
		_s:hld__del(prm.id)
	
	elseif ha.eq(msg_id, "to_door") then
		_s:to_door(prm.door_id)

	elseif ha.eq(msg_id, "itm_selected__") then
		_s:itm_selected__(prm.itm_selected)	

	elseif ha.eq(msg_id, "menu_opn") then

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
end

function Plychara.final(_s)
end

-- method

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
	
	local pos = _s:pos()
	local df  = n.vec(Map.sq * mlt, 0)
	if     ha.eq(_s._dir_h, "l") then
		pos = pos - df
	elseif ha.eq(_s._dir_h, "r") then
		pos = pos + df
	end
	return pos
end

-- clsn

function Plychara.clsn_add(_s, target, id)
	
	if ar.in_(id, _s._hld) then return end

	ar.add(_s._clsn[target], id)
end

function Plychara.clsn_clr(_s)
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

	local r_id = _s._hld[cnt]

	return ret, r_id
end

function Plychara.hld_cnt(_s)
	local cnt = #_s._hld
	return cnt
end

function Plychara.hld_id(_s)
	
	local cnt = _s:hld_cnt()

	if cnt <= 0 then return end
	
	local r_id = _s._hld[cnt]
	return r_id
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

	local dir_h = ha.de(_s._dir_h)
	local side_is_block, tile
	side_is_block, tile = _s:side_is_block(dir_h)
	-- log._("hld_tile_side ", side_is_block, tile)
	
	if not side_is_block             then return end
	if not Magic.is_magic_vnsh(tile) then return end
	
	-- cre block obj
	local t_id = Block.cre(nil, tile)
	local hld_idx = _s:hld__o(t_id)

	-- tile emp
	local side_pos = _s:side_pos(dir_h)
	if dir_h == "l" then side_pos = side_pos + n.vec(-1, 0) end
	_s:tile__(Tile.emp, side_pos)
end

-- to xxx

function Plychara.to_cloud(_s)
	Sp.to_cloud(_s)
	pst.scrpt(Sys.cmr_id(), "pos__plychara")
end

function Plychara.to_door(_s, door_id)
	local pos = id.pos(door_id)
	_s:pos__(pos)
	pst.scrpt(Sys.cmr_id(), "pos__plychara")
end

