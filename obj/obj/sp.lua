log.scrpt("sp.lua")

Sp = {
	thrwd_speed_x  = 6,
	thrwd_speed_y  = 4,

	airflw_u_vec_y = 3, -- 4,

	sand_smoke_speed_y = - 4
}

-- static

function Sp.cre(p_Cls, p_pos, prm, p_scl)
	
	p_pos = p_pos or pos.pos_w()
	prm   = prm   or {}

	local t_url
	if p_Cls.cls == "anml" then
		t_url = url._("/obj-fac/"..Anml.cls.."-fac", prm._nameHa)
	else
		t_url = "/obj-fac/"..p_Cls.fac
	end
	-- log._("Sp.cre 1", t_url, p_Cls.cls)

	prm._clsHa  = ha._(p_Cls.cls)

	if ha.is_emp(prm._nameHa) then
		prm._nameHa = ha._(p_Cls.cls..rnd.int_pad(p_Cls.name_idx_max))
	end

	if ha.is_emp(prm._animHa) then
		prm._animHa = prm._nameHa
	end

	local map_id, game_id = Game.map_id()
	-- log._("Sp.cre 2 game_id", game_id, "map_id", map_id)

	if ha.is_emp(map_id) then log._("Sp.cre map_id is_emp") return end
	
	prm._game_id   = game_id
	prm._map_id    = map_id
	prm._parent_id = map_id

	local z_dflt = 0.2
	prm._z  = p_Cls.z or z_dflt
	p_pos.z = p_Cls.z or z_dflt
	
	if p_scl == 0 then p_scl = 0.2 end -- 1 -- 0.2
	
	local t_id = fac.cre(t_url, p_pos, nil, prm, p_scl)

	prm._cls  = prm._cls  or ha.de(prm._clsHa )
	prm._name = prm._name or ha.de(prm._nameHa)
	prm._anim = prm._anim or ha.de(prm._animHa)

	prm._clsHa  = nil
	prm._nameHa = nil
	prm._animHa = nil
	-- log._("Sp.cre 3")

	pst.scrpt(t_id, "__init", prm)
	-- log._("Sp.cre 4")

	-- pst.scrpt(t_id, "scl_anm__1")
	return t_id
end

-- script method

function Sp.__init(_s, prm)
	-- log._("Sp.__init 1")

	for key, val in pairs(prm) do
		_s:prp__(key, val)
	end
	-- log._("Sp.__init 2")

	_s._id = id._()
	-- log._("Sp.__init 3", _s._id, _s._cls)
	
	_s._foot_dst_i = _s:Cls().foot_dst_i or Map.sqh
	_s._w = _s:Cls().w or Map.sq
	-- log._("Sp.__init 4")

	_s:parent__map()
	-- log._("Sp.__init 5")

	_s:map_obj__add()
	-- log._("Sp.__init 6")

	-- if ar.inHa(_s._clsHa, {"plychara", }) then
	if ar.in_(_s._cls, {"plychara", }) then
		-- excld
	else
		-- fr anim
		--[[
		local anim
		if _s._anim then anim = _s._anim
		else             anim = _s._name
		end
		_s:anim__(anim)
		--]]

		-- fr animHa -- old > del
		local animHa
		if not ha.is_emp(_s._animHa) then animHa = _s._animHa
		else                              animHa = _s._nameHa
		end
		_s:anim__(animHa)
	end
	-- log._("Sp.__init 7")

	_s._act_intrvl = 0

	_s:vec__init()
	-- log._("Sp.__init 8")

	_s:pos__init()
	-- log._("Sp.__init 9")
end

function Sp.final(_s)
	
	_s:map_obj__del()
	
	if _s:cls_is_mapobj() then
		_s:mapobj_del()
	end
end

-- method

function Sp.__(_s, key, val) -- alial
	_s:prp__(key, val)
end

function Sp.prp__(_s, key, val)
	-- log._("Sp.prp__", key, val)
	_s[key] = val
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

function Sp.is_pause(_s)
	-- local ret = Map.pause
	
	local ret = id.prp(_s:map_id(), "_pause")
	-- log._("sp.is_pause", ret)
	
	return ret
end

function Sp.parent__(_s, parent_id, z, p_pos)

	z = z or 0.2

	pst.parent__(_s._id, parent_id, z, p_pos)
end

function Sp.parent__map(_s)
	
	local z = _s:Cls().z or 0.2
	
	pst.parent__(_s._id, _s:map_id(), z)
end

-- id

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

function Sp.clsHa(_s)
	return _s._clsHa
end

function Sp.cls(_s)
	return _s._clsHa
end

function Sp.nameHa(_s)
	return _s._nameHa
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

function Sp.is_food(_s)
	return ar.inHa(_s._clsHa, Food.cls)
end

-- obj

function Sp.cls_is_mapobj(_s)
	
	local ret = ar.inHa(_s._clsHa, Mapobj.cls)
	return ret
end

function Sp.map_obj__add(_s)
	
	if ha.is_emp(_s._clsHa) then return end
	
	local t_cls = ha.de(_s._clsHa)
	-- log._("map_obj__add", t_cls)

	if not Map.st.obj(t_cls) then Map.st.obj__init(t_cls) end
	
	ar.add_unq(Map.st.obj(t_cls), _s._id)
end

function Sp.map_obj__del(_s)

	local t_cls = ha.de(_s._clsHa)
	-- log._("map_obj__del", t_cls)
	local t_ar  = Map.st.obj(t_cls)
	ar.del_by_val(t_ar, _s._id)
end

function Sp.mapobj_del(_s)
	Mapobj.del(_s:tilepos(), _s._clsHa, _s._id)
end

function Sp.obj_arund(_s, clsHa)

	local obj = Mapobj.obj_arund(_s:tilepos(), clsHa)
	return obj
end

function Sp.obj_d(_s, clsHa)
	local obj = Mapobj.obj(_s:tilepos_d(), clsHa)
	return obj
end

function Sp.mapobj__(_s)
	-- log._("sp mapobj__")
	
	local t_tilepos = _s:tilepos()
	
	Mapobj.__(t_tilepos, _s._clsHa, _s._id)
	
	if _s._tilepos_pre
	and ((t_tilepos.x ~= _s._tilepos_pre.x) or (t_tilepos.y ~= _s._tilepos_pre.y)) then
		Mapobj.del(_s._tilepos_pre, _s._clsHa, _s._id)
	end
	
	_s._tilepos_pre = t_tilepos
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

