log.scrpt("sp.lua")

Sp = {
	thrwd_speed_x = 6,
	thrwd_speed_y = 4,
}

-- static

function Sp.cre(Cls, p_pos, prm, scl)
	
	p_pos = p_pos or pos.pos_w()
	prm   = prm   or {}

	local t_url = "/obj-fac/"..Cls.fac

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
	local t_id = fac.cre(t_url, p_pos, nil, prm, scl)

	-- local t_id = fac.cre(t_url, p_pos, nil, prm)
	-- local t_id = fac.cre(t_url, p_pos, nil, prm, nil)
	
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

	if not ar.inHa(_s._clsHa, {"plychara", "chara"}) then

		local animHa = _s._animHa or _s._nameHa
		_s:anim__(animHa)
	end

	_s._act_intrvl = 0

	_s:vec__init()
	_s:pos__init()
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

