log.scrpt("livingmove.lua")

Livingmove = {}

-- script method

function Livingmove.init(_s)
	
	_s:dir_h__rnd() -- init
	_s._dir_v = ""
	_s._is_moving = _.f
	_s._speed  = _s:Cls().speed

	_s._status = "live" -- use not ?
end

--- method

function Livingmove.upd_pos_movabl(_s, dt)
	
	_s:vec_mv__(dt)

	_s:vec_tile__(dt)

	_s:vec_grv__(dt)

	_s._vec_total = _s._vec_mv + _s._vec_tile + _s._vec_grv

	_s:pos__add(_s._vec_total)
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
	_s:dir_v__rnd()
	_s:moving__rnd()
	_s:speed__rnd()
end

function Livingmove.vec_mv__(_s, dt)

	if not u.eq(_s._status, "live") then _s:vec_mv__clr() return end

	if     _s._hldd_id    then _s:vec_mv__clr() return end

	if not _s._is_moving then _s:vec_mv__clr() return end

	_s:vec_mv_x__()

	_s:vec_mv_y__()
end

function Livingmove.vec_mv__clr(_s)
	vec.xy__(_s._vec_mv, 0, 0)
end

function Livingmove.vec_mv_x__(_s)

	if (_s._dir_h_Ha == "l" and _s:side_is_block("l"))
	or (_s._dir_h_Ha == "r" and _s:side_is_block("r"))
	then
		return
	end

	local df_x = _s._speed

	if ha.eq(_s._dir_h_Ha, "l") then df_x = - df_x end

	_s._vec_mv.x = df_x
end

function Livingmove.vec_mv_y__(_s)

	if not _s._is_fly then return end

	if     _s._dir_v == "u"   then
		_s._vec_mv.y = _s._speed

	elseif _s._dir_v == "u/2" then
		_s._vec_mv.y = _s._speed / 2

	elseif _s._dir_v == "d"   then
		_s._vec_mv.y = _s._speed

	elseif _s._dir_v == "d/2" then
		_s._vec_mv.y = _s._speed / 2
	end
	
	if _s:head_o_is_block() or _s:foot_o_is_block() then
		_s._vec_mv.y = 0
	end
end

