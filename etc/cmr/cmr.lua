log.scrpt("cmr.lua")

Cmr = {
	act_intrvl_time = 20,
	name_idx_max = 1,
	
	z_lst = {
		Disp.xh + Disp.xh/4*(-2),
		Disp.xh + Disp.xh/4*(-1),
		Disp.xh + Disp.xh/2*0,
		Disp.xh + Disp.xh/2*1,
		Disp.xh + Disp.xh/2*2,
		Disp.xh + Disp.xh/2*3,
	},
}
Cmr.dflt       = {}
Cmr.dflt.z_idx = 3
Cmr.dflt.z     = Cmr.z_lst[Cmr.dflt.z_idx]
Cmr.dflt.pos   = n.vec(0, 0, Cmr.dflt.z)

Cmr.far        = {}
Cmr.far.z_idx  = #Cmr.z_lst
Cmr.far.z      = Cmr.z_lst[Cmr.far.z_idx]
Cmr.far.pos    = n.vec(0, 0, Cmr.far.z)

Cmr.cls = "cmr"
Cls.add(Cmr)

function Cmr.cre(p_pos)
	
	p_pos = p_pos or Cmr.dflt.pos

	local name = "cmr"
	local t_url = "/sys#fac_cmr"
	if not prm then prm = {} end
	prm._clsHa  = ha._(Cmr.cls)
	prm._nameHa = ha._(name)

	local t_id = fac.cre(t_url, p_pos, nil, prm)
	return t_id
end

-- script method

function Cmr.init(_s)
	
	extend._(_s, Cmr)

	_s._id = id._()
	
	local prm = {
		aspect_ratio = Disp.x / Disp.y,
		fov    = math.pi * (45 / 180),
		near_z = 1,
		far_z  = Cmr.far.z + 1
	}
	pst._("#cmr", "set_camera", prm)
	pst._("#cmr", "acquire_camera_focus")

	_s:pos__dflt()
	_s._z_idx = Cmr.dflt.z_idx
	
	if not ha.is_emp(_s:plychara_id()) then
		_s._target_pos = _s:plychara_pos()
	end
	
	_s._speed = 0
	_s._speed_max = 6.5
	_s._accl   = 0
	_s._v      = 0.2
	_s._vec    = n.vec()
	_s._tu_vec = nil
end

function Cmr.upd(_s, dt)

	if ha.is_emp(_s:game_id()    ) then return end
	if ha.is_emp(_s:plychara_id()) then return end

	_s._pos = _s:pos()
	
	_s:upd_target_pos__()
	
	_s:upd_vec(dt)
	
	_s:upd_pos(dt)
end

function Cmr.upd_pos(_s, dt)
	
	local t_pos = _s._pos + _s._vec
	_s:pos__(t_pos)
end

function Cmr.upd_vec(_s, dt)
	
	_s._log = ""
	
	-- t_vec, u_vec
	_s._t_vec  = _s._target_pos - _s._pos
	_s._tu_vec = vec.unit(_s._t_vec)
	_s._t_len  = vec.len(_s._t_vec)
	
	_s.rad_d = math.abs(u.rad_diff(_s._vec, _s._t_vec) or 0)
	
	-- accl
	local slw_len = accl.dcl_len(_s._speed, - _s._v) + Map.sq
	if _s._t_len < slw_len then
		_s:upd_vec_near(dt)
	else
		_s:upd_vec_far(dt)
	end
end

function Cmr.upd_vec_far(_s, dt)
	
	if _s._speed < 1.0 or _s.rad_d < 0.3 then
		_s:upd_vec_far_frnt(dt)
	else
		_s:upd_vec_far_out(dt)
	end
end

function Cmr.upd_vec_far_frnt(_s, dt)

	_s._log_func = "far_frnt"
	
	-- accl
	_s._accl = _s._accl + _s._v
	if _s._accl > _s._v then _s._accl = _s._v end

	-- speed
	_s._speed = _s._speed + _s._accl
	if _s._speed > _s._speed_max then _s._speed = _s._speed_max end

	-- vec
	_s._vec = _s._tu_vec * _s._speed
end

function Cmr.upd_vec_far_out(_s, dt)

	_s._log_func = "far_out"
	
	-- accl
	_s._accl = _s._accl - _s._v
	if _s._accl < - _s._v then _s._accl = - _s._v end

	-- speed
	_s._speed = _s._speed + _s._accl
	if _s._speed < 0 then _s._speed = 0 end

	-- vec
	_s._vec = vec.unit(_s._vec) * _s._speed
end

function Cmr.upd_vec_near(_s, dt)

	_s._log_func = "near"
	
	-- accl
	_s._accl = _s._accl - _s._v
	if _s._accl < - _s._v then _s._accl = - _s._v end

	_s._speed = _s._speed + _s._accl
	if _s._speed < 0 then _s._speed = 0 end
	
	-- vec
	if _s.rad_d < 0.3 then
		_s._vec = _s._tu_vec * _s._speed
	else
		_s._vec = vec.unit(_s._vec) * _s._speed
	end
end

function Cmr.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)

	if     ha.eq(msg_id, "zoom__dflt"   ) then
		_s:zoom__dflt()
	
	elseif ha.eq(msg_id, "zoom__i"      ) then
		_s:zoom__i()
		
	elseif ha.eq(msg_id, "zoom__o"      ) then
		_s:zoom__o()

	elseif ha.eq(msg_id, "zoom__far"    ) then
		_s:zoom__far()

	elseif ha.eq(msg_id, "pos__dflt"    ) then
		_s:pos__dlft()
		
	elseif ha.eq(msg_id, "pos__plychara") then
		_s:pos__plychara()

	elseif ha.eq(msg_id, "pos__chara_rnd"   ) then
		_s:pos__chara_rnd()

	elseif ha.eq(msg_id, "z__far"       ) then
		_s:z__far()

	elseif ha.eq(msg_id, "target_pos__" ) then
		_s:target_pos__(prm.pos)

	elseif ha.eq(msg_id, "__game_start" ) then
		_s:__game_start()

	elseif ha.eq(msg_id, "__dstrct_ch"  ) then
		_s:__dstrct_ch()
	end
end

function Cmr.final(_s)
	pst._("#cmr", "release_camera_focus")
end

-- method

-- target

function Cmr.target_pos(_s)

	return _s._target_pos
end

function Cmr.target_pos__(_s, pos)

	_s._target_pos = pos
end

function Cmr.target_z(_s)

	local target_z = Cmr.z_lst[_s._z_idx]
	return target_z
end

-- upd_target

function Cmr.upd_target_pos__(_s)

	_s._target_pos = _s:plychara_pos()
	_s._target_pos.x = _s._target_pos.x + _s:upd_target_pos_x_df(dt, z)
end

function Cmr.upd_target_pos_x_df(_s, dt, z)

	-- target pos
	local x_df = Map.sq * 5.5
	if _s._z_idx == 1 then x_df = x_df / 3 end

	if id.prp(_s:plychara_id(), "_turn_time") < 4 then return 0 end

	if id.prp(_s:plychara_id(), "_face_dir_h_Ha") == ha._("l") then
		x_df = - x_df
	end
	return x_df
end

-- pos

function Cmr.pos__dflt(_s)

	_s:pos__(Cmr.dflt.pos)
end

function Cmr.pos__plychara(_s)
	
	if ha.is_emp(_s:plychara_id()) then return end
	
	local t_pos = _s:plychara_pos()
	_s:pos__(t_pos)
end

function Cmr.pos__chara_rnd(_s)
	
	local t_pos = _s:chara_rnd_pos()

	if ha.is_emp(t_pos) then return end

	_s:pos__(t_pos)
end

function Cmr.pos_crct(_s, pos)

	local z = _s:pos().z

	local df = _s:pos_crct_x_df(z)

	local map_rng_pos = _s:map_rng_pos()
	local xl_lim = (map_rng_pos.min.x + z) -- + df
	local xr_lim = (map_rng_pos.max.x - z) -- - df
	
	if     pos.x < xl_lim then
		pos.x = xl_lim
	elseif pos.x > xr_lim then
		pos.x = xr_lim
	end
	return pos
end

function Cmr.map_rng_pos(_s)
	
	local map_rng_pos = Game.map_rng_pos()
	return map_rng_pos
end

function Cmr.pos_crct_x_df(_s, z)

	local x_crct = {
		min = {z =  325, x = 6/10},
		max = {z = 1625, x = 3   },
	}

	local d  = (x_crct.max.x - x_crct.min.x) / (x_crct.max.z - x_crct.min.z)
	local df = ((z - x_crct.min.z) * d + (x_crct.min.x)) * Map.sq
	return df
end

function Cmr.pos(_s)

	return Sp.pos(_s)
end

function Cmr.pos__(_s, pos)

	Sp.pos__(_s, pos)
end

function Cmr.pos__far(_s)

	_s:pos__(Cmr.far.pos)
end

-- zoom

function Cmr.zoom__i(_s)
	
	_s._z_idx = int.dec_stop(_s._z_idx, #Cmr.z_lst)
	_s:zoom__anm()
end

function Cmr.zoom__o(_s)
	
	_s._z_idx = int.inc_stop(_s._z_idx, #Cmr.z_lst)
	_s:zoom__anm()
end

function Cmr.zoom__far(_s, time)
	
	_s._z_idx = #Cmr.z_lst
	_s:zoom__anm()
end

function Cmr.zoom__dflt(_s)
	
	_s._z_idx = Cmr.dflt.z_idx
	_s:zoom__anm()
end

function Cmr.zoom__anm(_s, time)

	time = time or 2
	go.animate(_s._id, "position.z", es.fwd, _s:target_z(), es.sin_o, time, 0)
end

-- plychara

function Cmr.plychara_id(_s)

	local plychara_id = Game.plychara_id()
	return plychara_id
end

function Cmr.plychara_pos(_s)

	local plychara_id = _s:plychara_id()
	local r_pos = id.pos(plychara_id)
	return r_pos
end

function Cmr.__game_start(_s)

	_s:pos__plychara()
	_s:z__far()
	_s:zoom__dflt()
end

function Cmr.__dstrct_ch(_s)

	_s:accl__(0)
	_s:pos__plychara()
end

function Cmr.__stp(_s)

	_s:accl__(0)
	_s:speed__(0)
end

function Cmr.accl__(_s, accl)
	_s._accl = accl
end

function Cmr.speed__(_s, speed)
	_s._speed = speed
end

-- game

function Cmr.game_id(_s)
	return Sys.game_id()
end

-- z

function Cmr.z(_s)
	return Sp.z(_s)
end

function Cmr.z__(_s, z)
	Sp.z__(_s, z)
end

function Cmr.z__far(_s)
	_s._z_idx = Cmr.far.z_idx
	_s:z__(Cmr.far.z)
end

