log.scrpt("sky.lua")

Sky = {

	_sky_tile_base = {
		 1, -- [1] day
		21, -- [2] sunset
		41, -- [3] night
	},
	
	gradation_idx_max = 20,
	
	act_intrvl_max = 5, -- 2, -- 15, -- 60,
}
Sky.sky_idx_max = #Sky._sky_tile_base

Sky.clct = {"aerial", "hrzn"}

-- static

function Sky.cre(sky_idx)

	local url = "/mapClctFac#sky_fac"
	local pos = n.vec()
	pos.z = - 1
	local t_id = fac.cre(url, pos, nil, {_sky_idx = sky_idx})
	return t_id
end

-- method

function Sky.init(_s)

	Bg.init(_s)
	
	_s._rng = map.rng_tilepos(_s._id, "sky")
	
	_s:tile__init()
	
	_s._is_changing = _.f
	_s._x_once = 2 -- default
	
	_s._act_intrvl = 0

	_s._upd_style = "v" -- or raindrop

	_s._dsp = _.t
end

function Sky.tile__init(_s)

	if _s._sky_idx == 0 then _s._sky_idx = _s:sky_idx__rnd() end
	
	local tile_base = _s:sky_tile_base(_s._sky_idx)
	
	for y = _s._rng.min.y, _s._rng.max.y do
		for x = _s._rng.min.x, _s._rng.max.x do
			map.tile__by_tilepos(n.vec(x, y), tile_base, _s._id, "sky", "sky")
		end
	end
end

function Sky.sky_tile_base(_s, sky_idx)

	sky_idx = sky_idx or _s._sky_idx

	local tile_base = Sky._sky_tile_base[sky_idx]
	return tile_base
end

function Sky.sky_idx__rnd()

	local sky_idx = rnd.int(1, Sky.sky_idx_max)
	return sky_idx
end

function Sky.changing_obj()
	local obj = {
		_ = {}, -- entry -- child
		rng = {min = 0, max = 0},
		min = 0,
		max = 0,
		crnt = 0,
	}
	return obj
end

function Sky.upd(_s, dt)
	-- log._("sky upd")

	_s:act_intrvl__(dt)

	_s:pos__()
	
	_s:upd_tile__(dt)

	-- _s:upd_dsp__() -- not use now
end

function Sky.plychara_id(_s)
	local plychara_id = Game.plychara_id()
	return plychara_id
end

function Sky.plychara_pos(_s)
	local plychara_id = _s:plychara_id()
	local pos = id.pos(plychara_id)
	return pos
end

function Sky.upd_dsp__(_s) -- not use now

	if ha.is_emp(_s:plychara_id()) then return end
	
	local sky_y = -1000
	local plychara_pos_y = _s:plychara_pos().y
	if plychara_pos_y > sky_y then _s:dsp__o()
	else                           _s:dsp__x()
	end
end

function Sky.act_intrvl__(_s, dt)

	if _s._is_changing == _.t then return end
	
	if _s._act_intrvl < Sky.act_intrvl_max then
		_s._act_intrvl = _s._act_intrvl + dt 
		return
	end
	
	_s._act_intrvl = 0 -- reset

	-- changing init
	_s._is_changing = _.t
	_s:changing__start()
end

function Sky.changing__start(_s)
	-- log._("changing__start")

	if not _s._changing then 
		_s._changing = Sky.changing_obj()
	end

	_s._x_once = rnd.int(4, 6)

	local gradation_idx = 2
	_s._changing.crnt = gradation_idx
	_s._changing.min  = gradation_idx
	_s._changing.max  = gradation_idx
	_s._changing._[gradation_idx] = Sky.changing_obj()
	_s._changing.loop_cnt  = 0
	
	-- x init
	_s._changing._[gradation_idx].crnt = 1
	_s._changing._[gradation_idx].min  = 1
	_s._changing._[gradation_idx].max  = 1
	_s._changing._[gradation_idx]._[1] = _s._rng.max.y
end

function Sky.upd_tile__(_s, dt)

	if not _s._is_changing then return end

	if _.t then
		_s:upd_tile_v__(dt)
	else
		_s:upd_tile_raindrop__(dt)
	end
end

function Sky.upd_tile_v__(_s, dt)
	
	local gradation_idx = _s:upd_tile_v_gradation()

	if gradation_idx > Sky.gradation_idx_max + 1 then  
		_s._is_changing = _.f
		_s._sky_idx = u.inc_loop(_s._sky_idx, Sky.sky_idx_max)
		return
	end
	
	_s:upd_tile_v__by_gradation(gradation_idx)
end

function Sky.upd_tile_v_gradation(_s)
	local gradation_idx = _s._changing.crnt
	return gradation_idx
end

function Sky.upd_tile_v_gradation_x(_s, gradation_idx)
	-- log._("upd_tile_v_gradation_x", gradation_idx)
	
	local x = _s._changing._[gradation_idx].crnt
	return x
end

function Sky.upd_tile_v__by_gradation(_s, gradation_idx)
	local x = _s:upd_tile_v_gradation_x(gradation_idx)
	_s:upd_tile_v__by_gradation_x(gradation_idx, x)
end

function Sky.upd_tile_v__by_gradation_x(_s, gradation_idx, x)
	-- log._("upd_tile_v__by_gradation_x", gradation_idx, x)
	
	local y = _s._changing._[gradation_idx]._[x]
	if not y then log._("y is nil", gradation_idx, x) end
	local pos = n.vec(x, y)
	local tile = _s:upd_tile(gradation_idx)
	
	-- log._("upd_tile_v__by_gradation_x", tile, pos)
	_s:tile__by_pos(tile, pos)

	-- next
	y = y - 1
	if y >= _s._rng.min.y then
		_s._changing._[gradation_idx]._[x    ] = y
	else
		_s._changing._[gradation_idx]._[x    ] = nil

		if x + _s._x_once -1 >= _s._rng.max.x then
			_s._changing._[gradation_idx] = nil
			_s._changing.min = gradation_idx + 1
			_s._changing.crnt = _s._changing.min
			-- log._("x __ nil")
			return
		else
			_s._changing._[gradation_idx].min = x + _s._x_once
		end
	end

	x = x + _s._x_once
	if     x <= _s._changing._[gradation_idx].max then
		-- log._("a")
		_s._changing._[gradation_idx].crnt = x

	else
		-- log._("b1", _s._changing._[gradation_idx].crnt, _s._changing._[gradation_idx].min, _s._changing._[gradation_idx].max)

		if x <= _s._rng.max.x then
			if not _s._changing._[gradation_idx]._[x] then
				_s._changing._[gradation_idx]._[x] = _s._rng.max.y
			end
			_s._changing._[gradation_idx].max = x
		end
		
		_s._changing._[gradation_idx].crnt = _s._changing._[gradation_idx].min
		
		gradation_idx = gradation_idx + 1
		
		if gradation_idx > _s._changing.max then
			
			_s._changing.crnt = _s._changing.min
			_s._changing.loop_cnt = _s._changing.loop_cnt + 1
			-- log._("cnt", _s._changing.loop_cnt)
			
			if _s._changing.loop_cnt >= 3 then
				_s._changing.loop_cnt = 0
				-- log._("cnt over", _s._changing.loop_cnt)

				if gradation_idx <= Sky.gradation_idx_max + 1 and not _s._changing._[gradation_idx] then
					-- log._("cre changing_obj gradation_idx", gradation_idx)
					_s._changing._[gradation_idx] = Sky.changing_obj()
					_s._changing.max  = gradation_idx

					-- x init
					_s._changing._[gradation_idx].crnt = 1
					_s._changing._[gradation_idx].min  = 1
					_s._changing._[gradation_idx].max  = 1
					_s._changing._[gradation_idx]._[1] = _s._rng.max.y
				end
			end
		else
			_s._changing.crnt = gradation_idx
			-- log._("normal gradation.crnt", _s._changing.crnt)
		end
	end
end

function Sky.upd_tile(_s, gradation_idx)

	local tile = _s:sky_tile_base() + gradation_idx - 1

	local max = Sky.sky_idx_max * Sky.gradation_idx_max
	if tile > max then tile = tile - max end

	return tile
end

function Sky.tile__by_pos(_s, tile, p_pos)
	-- log._("tile__by_pos", tile, p_pos)
	local t_pos = n.vec(p_pos.x, p_pos.y)
	
	for i = 1, _s._x_once do
		map.tile__by_tilepos(t_pos                        , tile, _s._id, "sky", "sky")
		map.tile__by_tilepos(n.vec(- t_pos.x + 1, t_pos.y), tile, _s._id, "sky", "sky")
		t_pos = t_pos + n.vec(1, 0)
	end
end

--

function Sky.on_msg(_s, msg_id, prm, sender)
	
	if     ha.eq(msg_id, "dsp__o") then
		_s:dsp__o()
	elseif ha.eq(msg_id, "dsp__x") then
		_s:dsp__x()
	elseif ha.eq(msg_id, "del") then
		_s:del()
	end
end

function Sky.dsp__o(_s)
	_s:dsp__(_.t)
end

function Sky.dsp__x(_s)
	_s:dsp__(_.f)
end

function Sky.dsp__(_s, val)
	local a
	if not val and _s._dsp then
		a = 0
		tilemap.set_constant("#sky", "tint", vmath.vector4(1, 1, 1, a))
		_s._dsp = val
		-- log._("sky dsp__", val)
	elseif val and not _s._dsp then
		a = 1
		tilemap.set_constant("#sky", "tint", vmath.vector4(1, 1, 1, a))
		_s._dsp = val
		-- log._("sky dsp__", val)
	end
end

function Sky.del(_s)
	
	go.delete(_.t)
end

--

function Sky.upd_tile__raindrop(_s, dt)

end
