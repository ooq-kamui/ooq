log.scrpt("sp.lua")

Sp = {
	thrwd_speed_x  = 6,
	thrwd_speed_y  = 4,

	airflw_u_vec_y = 3,
	sand_smoke_speed_y = - 4,

	upd_sec = 0.034, -- 30 frm
	-- upd_sec = 0.05, -- 20 frm

	_st_ = {
		on   = "on"   ,
		fall = "fall" ,
	},
}

-- static

function Sp.cre(p_Cls, p_pos, p_prm, p_scl)
	
	p_pos = p_pos or pos.pos_w()
	p_prm = p_prm or {}

	if not p_prm._name then
		p_prm._name = p_Cls.cls..rnd.int_pad(p_Cls.name_idx_max)
	end

	local t_url
	if p_Cls.cls == "anml" then
		t_url = "/obj-fac/"..Anml.cls.."-fac#"..p_prm._name
	else
		t_url = "/obj-fac/"..p_Cls.fac
	end

	local map_id, game_id = Game.map_id()
	if ha.is_emp(map_id) then log._("Sp.cre map_id is_emp") return end
	
	local t_prm = {}
	t_prm._game_id   = game_id
	t_prm._map_id    = map_id
	t_prm._parent_id = map_id

	local z_dflt = 0.2
	p_pos.z  = p_Cls.z or z_dflt
	t_prm._z = p_Cls.z or z_dflt
	
	if p_scl == 0 then p_scl = 0.2 end
	
	-- log.if_(p_Cls.cls == "fruit", "Sp.cre", p_pos)

	local t_id = fac.cre(t_url, p_pos, nil, t_prm, p_scl)
	p_prm._cls  = p_Cls.cls
	pst.scrpt(t_id, "__init", p_prm)
	return t_id
end

-- scrpt method

function Sp.__init(_s, prm)

	for key, val in pairs(prm) do
		_s:prp__(key, val)
	end
	_s._clsHa = ha._(prm._cls)

	_s._id = id._()
	
	_s._foot_dst_i = _s:Cls().foot_dst_i or Map.sqh
	_s._w          = _s:Cls().w          or Map.sq
	_s._weight     = _s:Cls().weight     or 1

	_s:parent__map()

	if     ar.in_(_s._cls, {"plychara", }) then
		-- excld
	else
		prm._anim = prm._anim or prm._name
		_s:anim__(prm._anim)
	end

	_s:vec__init()
	_s:pos__init()
	_s:intrvl__init()
	_s:st__init()
	
	_s:map_obj__add()
	_s:gtile__init()
end

function Sp.final(_s)
	
	_s:map_obj__del()
	_s:map_gtile_obj__del()

	_s:intrvl__final()

	_s:upd__x()
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

function Sp.trnsf(_s, p_Cls, prm, p_scl)

	if _s._hldd_id then return end
	
	local t_pos = _s:pos_w()
	
	local t_id = p_Cls.cre(t_pos, prm, p_scl)
	
	_s:del()

	return t_id
end

function Sp.per_trnsf(_s, per, p_Cls, prm, scl)
	
	if not rnd.by_p(per) then return end
	
	return Sp:trnsf(p_Cls, prm, scl)
end

function Sp.per_trnsf__humus(_s, per)
	-- log._("Sp.per_trnsf__humus", per, _s._hldd_id)

	if _s._hldd_id then return end

	local t_id = _s:per_trnsf(per, Humus)
	-- log._("Sp.per_trnsf__humus", per, _s._hldd_id, t_id)
	return t_id
end

function Sp.del(_s)
	go.delete()
end

function Sp.per_del(_s, per)

	local flg = rnd.by_p(per)
	
	if flg then _s:del() end

	return flg
end

function Sp.is_pause(_s)
	
	local ret = id.prp(_s:map_id(), "_pause")
	return ret
end

function Sp.parent_id(_s)

	return _s._parent_id
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
	return _s._cls
end

function Sp.name(_s)

	return _s._name
end

function Sp.Cls(_s, p_prp)

	local t_Cls

	if     _s._cls then
		t_Cls = Cls.Cls(_s._cls)

	else
		log._("Sp.Cls _s._cls is nil") return
	end
	if not t_Cls then log._("Sp.Cls is nil") return end
	
	if not p_prp then
		return t_Cls
	else
		return t_Cls[p_prp]
	end
end

function Sp.is_food(_s)

	return ar.in_(_s._cls, Food.cls)
end

function Sp.pb__save_data(_s, map_url)

	if _s._bear_tree_id then return end

	local prm = {}

	prm._cls  = _s._cls
	prm._name = _s._name
	prm._pos  = _s:pos_w()

	pst._(map_url, "save_data_obj__", prm)
end

function Sp.intrvl__init(_s)

	local time = _s:Cls("act_intrvl_time")
	_s._intrvl_hndl = timer.delay(time, _.t, _s.act_intrvl)
end

function Sp.intrvl__final(_s)

	timer.cancel(_s._intrvl_hndl)
end

function Sp.upd__o(_s)
	-- log._("Sp.upd__o", _s._cls)

	if _s._upd_hndl then return end

	_s._upd_hndl = timer.delay(Sp.upd_sec, _.t, _s.upd)
end

function Sp.upd__x(_s)

	if not _s._upd_hndl then return end

	timer.cancel(_s._upd_hndl)

	-- log._("Sp.upd__x", _s._cls, _s._upd_hndl)

	_s._upd_hndl = nil
end

function Sp.act_intrvl(_s)
end

-- st

function Sp.st(_s)

	return _s._st
end

function Sp.st__init(_s)
	_s:st__fall()
end

function Sp.st__on(_s)
	_s._st = Sp._st_.on
end

function Sp.st__fall(_s)
	_s._st = Sp._st_.fall
end

function Sp.st__(_s, val)

	_s._st = val

	if     val == Sp._st_.on   then
		-- _s:upd__x()
	elseif val == Sp._st_.fall then
		-- _s:upd__o()
	end
end

-- old

--[[
function Sp.clsHa(_s) -- use not
	return _s._clsHa
end
--]]

