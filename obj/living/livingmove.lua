log.scrpt("livingmove.lua")

Livingmove = {}

-- script method

function Livingmove.init(_s)
	
	_s:dir_h__rnd()
	_s._dir_v = ""
	_s._is_moving = _.f
	_s._speed  = _s:Cls().speed
	_s.status = "live"
end

--- method

function Livingmove.upd_pos_movabl(_s, dt)
	
	-- move
	local vec_mv = _s:vec_mv(dt)

	-- tile
	local vec_tile = _s:vec_tile(dt)

	-- gravity
	local vec_grv = _s:vec_grv(dt)

	-- total
	local vec_total = vec_mv + vec_tile + vec_grv
	_s:pos__add(vec_total)
end

function Livingmove.vec_mv(_s, dt)
	
	local vec
	if     _s.status == "live"    then
		vec = _s:vec_mv_living(dt)
		
	elseif _s.status == "phantom" then
		vec = n.vec(0, 1)
	else
		vec = n.vec()
	end
	return vec
end

function Livingmove.moving__(_s, val)
	_s._is_moving = val
end

function Livingmove.moving__rnd(_s)
	local moving_rate = 1 / 2
	local val = rnd.by_f(moving_rate)
	_s:moving__(val)
end

function Livingmove.is_moving(_s)
	return _s._is_moving
end

function Livingmove.speed__(_s, speed)
	_s._speed = speed
end

function Livingmove.speed__rnd(_s)
	local speed = _s:Cls().speed * (rnd.int(0, 100) / 100)
	_s:speed__(speed)
end

function Livingmove.moving_prp__rnd(_s)
	_s:dir_h__rnd()
	_s:dir_v__rnd()
	_s:moving__rnd()
	_s:speed__rnd()
end

function Livingmove.vec_mv_living(_s, dt)

	local vec = n.vec()

	if not _s._is_moving
	or     _s._hld_id
	then return vec end

	if (_s._dir_h == "l" and _s:side_is_block("l"))
	or (_s._dir_h == "r" and _s:side_is_block("r")) then
		-- not move
	else
		local diffx = _s._speed * dt
		if ha.eq(_s._dir_h, "l") then diffx = - diffx end
		vec.x = vec.x + diffx
	end

	if _s._is_fly then
		local diffy = _s._speed * dt
		if     _s._dir_v == "u"   then
			vec.y = vec.y + diffy
		elseif _s._dir_v == "u/2" then
			vec.y = vec.y + diffy / 2
		elseif _s._dir_v == "d"   then
			vec.y = vec.y - diffy
		elseif _s._dir_v == "d/2" then
			vec.y = vec.y - diffy / 2
		end
		
		if _s:head_o_is_block() or _s:foot_o_is_block() then
			vec.y = 0
		end
	end
	
	return vec
end
