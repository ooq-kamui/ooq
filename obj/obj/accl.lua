log.scrpt("accl.lua")

Accl = {

	grv_dflt = n.vec(0, - 0.15), -- - 0.2, - 0.1

	speed_max_x = 8,
	speed_max_y = 4,
	speed_max_y_parasail = 1,
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

function Accl.speed__add_accl(_s, is_parasail)

	_s._speed.x = num.__pls_stop_abs(_s._speed.x, _s._accl.x,   Accl.speed_max_x)

	local speed_y
	if is_parasail then speed_y = Accl.speed_max_y_parasail
	else                speed_y = Accl.speed_max_y
	end
	_s._speed.y = num.__pls_stop_min(_s._speed.y, _s._accl.y, - speed_y)
end

function Accl.speed(_s)

	return _s._speed
end

function Accl.speed__(_s, p_x, p_y)

	_s:speed_x__(p_x)
	_s:speed_y__(p_y)
end

function Accl.speed_x__(_s, p_x)

	if not p_x then return end

	_s._speed.x = p_x
end

function Accl.speed_x__clr(_s)

	_s:speed_x__(0)
end

function Accl.speed_y__(_s, p_y)

	if not p_y then return end

	_s._speed.y = p_y
end

function Accl.speed_y__clr(_s)

	_s:speed_y__(0)
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

