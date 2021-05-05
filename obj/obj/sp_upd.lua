log.scrpt("sp_upd.lua")

function Sp.is_loop__act_intrvl__(_s, dt)
	
	if _s:is_pause() then return end

	local is_loop = _s:act_intrvl__(dt)

	-- log._("Sp.is_loop__act_intrvl__", _s._cls, _s._name, _s._anim)

	return is_loop
end

function Sp.act_intrvl__(_s, dt)

	local act_intrvl_time = _s:Cls().act_intrvl_time
	local is_loop
	_s._act_intrvl, is_loop = num.pls_loop(_s._act_intrvl, dt, act_intrvl_time)
	return is_loop
end

function Sp.upd_final(_s)
    _s:pos_flg__clr()
end

-- dir

function Sp.dir_h__(_s, dir_h)
	
	_s:  mv_dir_h__(dir_h)
	_s:face_dir_h__(dir_h)
end

function Sp.mv_dir_h__(_s, dir_h)
	-- log._("sp mv_dir_h__", dir_h)
	
	_s._mv_dir_h_Ha = ha._(dir_h)

	-- _s:flip_h__dir()
end

function Sp.face_dir_h__(_s, dir_h)
	-- log._("sp face_dir_h__", dir_h)
	
	_s._face_dir_h_Ha = ha._(dir_h)

	_s:flip_h__dir()
end

function Sp.flip_h__dir(_s)
	
	local val = _.f
	if     ha.eq(_s._face_dir_h_Ha, "l") then
		val = _.f
	elseif ha.eq(_s._face_dir_h_Ha, "r") then
		val = _.t
	end
	sprite.set_hflip("#sprite", val)
	-- _s:flip_h__(val)
end

--[[
function Sp.flip_h__(_s, val)
end
--]]

function Sp.dir_v__(_s, dir_v)
	
	_s._dir_v = dir_v
end

function Sp.upd_pos_static(_s, dt)
	
	_s:vec_tile__(dt)
	
	_s:vec_grv__(dt)

	_s._vec_total = _s._vec_tile + _s._vec_grv

	_s:pos__pls(_s._vec_total)

	-- mapobj
	if _s:cls_is_mapobj() then
		_s:mapobj__()
	end
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

function Sp.map_rng_pos(_s)

	if _s._map_rng_pos then return _s._map_rng_pos end

	if not _s._map_id then return end

	local tilesize = id.prp(_s._map_id, "_tilesize")
	_s._map_rng_pos = map.rng_pos(_s._map_id, "ground", tilesize)

	return _s._map_rng_pos
end

function Sp.accl_speed__(_s, p_x, p_y)

	_s._accl._speed.x = p_x
	_s._accl._speed.y = p_y
end

function Sp.accl_speed__clr(_s)

	_s._accl:speed__clr()
end

function Sp.mv__pos(_s, p_pos)
	_s:anm_pos__(p_pos)
end

function Sp.vec_tile__(_s, dt)
	
	if     _s:is_elv_u( _s:foot_i_pos() ) then
		vec.xy__(_s._vec_tile, 0, 1)

	elseif _s:is_airflw_u() then

		vec.xy__(_s._vec_tile, 0, Sp.airflw_u_vec_y)
	else
		vec.xy__(_s._vec_tile, 0, 0)
	end
end

function Sp.vec_grv__(_s, dt)
	-- log._("sp vec_grv__ speed", _s._accl._speed)

	if     _s:is_on_obj_block()   then
		_s:vec_grv__clr()

	elseif _s._is_flying          then -- only flyable
		_s:vec_grv__clr()
	
	elseif _s._hldd_id            then -- only holdable
		_s:vec_grv__clr()
	
	elseif _s._kitchen_id         then -- only food
		_s:vec_grv__clr()
	
	elseif _s._bear_tree_id       then -- only fruit
		_s:vec_grv__clr()
		
	elseif _s:is_tile_grounding() then

		if _s._accl._speed.y > 0 then
			_s:vec_grv__grv()
		else
			if _s._accl._speed.y <= Sp.sand_smoke_speed_y then
				-- log._("speed y", _s._accl._speed.y)
				Efct.cre_sand_smoke(nil, _s:foot_i_pos())
			end
			_s:vec_grv__clr()

		end
	else
		_s:vec_grv__grv()
	end
end

function Sp.vec_grv__grv(_s)

	_s._accl:speed__add_accl(_s._is_airride)
	_s._vec_grv = _s._accl:speed()
end

function Sp.vec_grv__clr(_s)

	vec.xy__clr(_s._vec_grv)
	_s:accl_speed__clr()
end

function Sp.on_clsn(_s)
	
	local on_id, on_cls = nil, nil
	local t_clss = {"chara"} -- {"chara", "block"}
	local clsn_pos
	-- local o_obj, o_pos
	
	for i, t_cls in pairs(t_clss) do
		for j, clsn_id in pairs(_s._clsn[t_cls]) do
			clsn_pos = id.pos(clsn_id)
			if t_cls == "block" and ar.inHa(clsn_id, _s._hld) then
				-- nothing
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

