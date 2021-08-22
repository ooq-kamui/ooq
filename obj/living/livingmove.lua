log.scrpt("livingmove.lua")

Livingmove = {}

-- script method

function Livingmove.__init(_s)
	
	_s:dir_h__rnd() -- init

	_s._dir_v = ""
	_s._is_flying = _.f
	_s._is_moving = _.t

	_s._speed  = _s:Cls().speed
end

--- method

function Livingmove.upd_pos_movabl(_s, dt)
	
	_s:vec_mv__()

	_s:vec_tile__()

	_s:vec_grv__()

	_s:vec_total__()

	_s:pos__pls_vec_total()
end

function Livingmove.vec_total__(_s)

	-- _s._vec_total = _s._vec_mv + _s._vec_tile + _s._vec_grv
	vec.xy__vec(    _s._vec_total, _s._vec_mv)
	vec.xy__pls_vec(_s._vec_total, _s._vec_tile)
	vec.xy__pls_vec(_s._vec_total, _s._vec_grv)
end

function Livingmove.is_moving(_s)

	return _s._is_moving
end

function Livingmove.is_moving__(_s, val)

	_s._is_moving = val
end

function Livingmove.moving__rnd(_s)

	_s:is_moving__( rnd.by_f( 1 / 2) )
end

function Livingmove.speed__(_s, p_speed)

	_s._speed = p_speed
end

function Livingmove.speed__rnd(_s)

	local t_speed = _s:Cls().speed * ( rnd.int(0, 100) / 100 )

	_s:speed__(t_speed)
end

function Livingmove.moving_prp__rnd(_s)

	_s:dir_h__rnd()

	if _s:is_flyabl() then _s:is_flying__rnd() end
	_s:dir_v__rnd()

	_s:moving__rnd()
	_s:speed__rnd()
end

function Livingmove.is_flyabl(_s)

	return _s._is_flyabl
end

function Livingmove.is_flying(_s)

	return _s._is_flying
end

function Livingmove.is_flying__(_s, val)

	_s._is_flying = val

	if not val then _s:dir_v__("") end
end

function Livingmove.dir_h__rnd(_s)
	
	local dir_h = rnd.ar(u.dir_h)
	_s:dir_h__(dir_h)
end

function Livingmove.is_flying__rnd(_s)

	if not _s:is_flyabl() then return end
	
	local rate = 4 / 5
	local val = rnd.by_f(rate)
	_s:is_flying__(val)

	-- log._("Livingmove is_flying__rnd", _s._is_flying, _s:cls(), _s:name())
end

function Livingmove.dir_v__rnd(_s)
	
	if not _s:is_flyabl() or not _s:is_flying() then return end

	local dir_v

	if rnd.by_f(2/3) then

		dir_v = rnd.ar(u.dir_v)

		if rnd.by_f(1/2) then dir_v = dir_v .. "/2" end
	else
		dir_v = ""
	end
	-- log._("Livingmove dir_v__rnd", dir_v, _s:cls(), _s:name())
	_s:dir_v__(dir_v)
end

function Livingmove.vec_mv__(_s)

	if     _s._hldd_id   then _s:vec_mv__clr() return end

	if not _s._is_moving then _s:vec_mv__clr() return end

	_s:vec_mv_x__()

	_s:vec_mv_y__()
end

function Livingmove.vec_mv__clr(_s)
	vec.xy__(_s._vec_mv, 0, 0)
end

function Livingmove.vec_mv_x__(_s)

	if (_s._mv_dir_h_Ha == "l" and _s:side_is_block("l"))
	or (_s._mv_dir_h_Ha == "r" and _s:side_is_block("r"))
	then
		return
	end

	local df_x = _s._speed

	if ha.eq(_s._mv_dir_h_Ha, "l") then df_x = - df_x end

	_s._vec_mv.x = df_x
end

function Livingmove.vec_mv_y__(_s)

	-- log._("Livingmove vec_mv_y__ start", _s._vec_mv.y, _s:cls(), _s:name())

	if not _s:is_flying() then return end

	if     _s._dir_v == "u"   then

		if _s:head_o_is_block() then _s._vec_mv.y =   0
		else                         _s._vec_mv.y =   _s._speed
		end
	elseif _s._dir_v == "u/2" then

		if _s:head_o_is_block() then _s._vec_mv.y =   0
		else                         _s._vec_mv.y =   _s._speed / 2
		end
	elseif _s._dir_v == "d"   then

		if _s:foot_o_is_block() then _s._vec_mv.y =   0
		else                         _s._vec_mv.y = - _s._speed
		end
	elseif _s._dir_v == "d/2" then

		if _s:foot_o_is_block() then _s._vec_mv.y =   0
		else                         _s._vec_mv.y = - _s._speed / 2
		end
	elseif _s._dir_v == "" then
		_s._vec_mv.y = 0
	end
	-- log._("Livingmove vec_mv_y__ end", _s._vec_mv.y, _s:cls(), _s:name())
end

