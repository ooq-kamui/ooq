log.scrpt("accl.lua")

Accl = {

	grv_dflt = n.vec(0, - 0.15),
	-- grv_dflt = n.vec(0, - 0.2),
	-- grv_dflt = n.vec(0, - 0.1),

	grv_cnst = n.vec(0, - 1), -- old

	speed_max = 4,
	-- speed_max = 3,
}

-- static

function n.Accl() -- alias
	return Accl.new()
end

function Accl.new()
	local obj = {}
	extend.init(obj, Accl)
	return obj
end

-- method

function Accl.init(_s)

	_s._grv = vec.cp(Accl.grv_dflt)

	_s._speed = n.vec()
	_s._accl  = vec.cp(_s._grv)
end

-- _speed

function Accl.speed__add_accl(_s)

	_s._speed.x = num.__pls_abs_stop(_s._speed.x, _s._accl.x, Accl.speed_max)
	_s._speed.y = num.__pls_abs_stop(_s._speed.y, _s._accl.y, Accl.speed_max)

	-- _s._speed.x = _s._speed.x + _s._accl.x
	-- _s._speed.y = _s._speed.y + _s._accl.y
end

function Accl.speed(_s)

	return _s._speed
end

function Accl.speed__(_s, p_x, p_y)

	if not p_x then _s._speed.x = p_x end
	if not p_y then _s._speed.y = p_y end
end

function Accl.speed__clr(_s)

	_s._speed.x = 0
	_s._speed.y = 0
end

-- _accl

function Accl.accl(_s)

	return _s._accl
end

function Accl.accl__(_s, p_x, p_y)

	if not p_x then _s._accl.x = p_x end
	if not p_y then _s._accl.y = p_y end
end

function Accl.accl_x__(_s, p_x)

	_s._accl.x = p_x
end

function Accl.accl_y__(_s, p_y)

	_s._accl.y = p_y
end

-- _grv

function Accl.grv(_s)
	return _s._grv
end

function Accl.grv__(_s, p_x, p_y)

	if not p_x then _s._grv.x = p_x end
	if not p_y then _s._grv.y = p_y end
end

function Accl.grv_y__(_s, p_y)

	_s._grv.y = p_y
end

--
-- primitive
--

accl = {}

function accl.dst_by_speed(p_speed, p_accl, t_speed)

	if not p_speed then return end

	p_accl  = p_accl  or Accl.grv_dflt
	t_speed = t_speed or 0

	if p_speed <= 0 then return end
	if p_accl  <= 0 then return end

	local t_dst = 0

	t_dst = - ( t_speed ^ 2 - p_speed ^ 2 ) / ( 2 * p_accl )
	log._("accl.dst_by_speed", t_dst)

	return t_dst
end

function accl.speed_by_dst(p_dst, p_accl)

	if not p_dst then return end

	p_accl  = p_accl or Accl.grv_dflt

	local t_speed = 0

	t_speed = math.sqrt( 2 * p_dst * p_accl )
	log._("accl.speed_by_dst", t_speed)

	return t_speed
end

function accl.dcl_len(speed, p_accl)
	
	if p_accl >= 0 or speed <= 0 then return 0 end

	local len = speed
	while speed > 0 do
		speed = speed + p_accl
		if speed < 0 then speed = 0 end

		len = len + speed
	end
	return len
end

