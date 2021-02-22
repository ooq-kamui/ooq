log.scrpt("u.lua")

u = { -- util
	lr    = {"l", "r"},
	ud    = {"u", "d"},
}
u.dir_h = u.lr
u.dir_v = u.ud
ha.add_by_ar(u.dir_h)

-- log.scrpt("util.script")

function u.is_emp(val)

	if not val then return _.t end

	local val_type = type(val)
	if val_type == "string" and val == "" then return _.t end
	if val_type == "table"  and ar.is_emp(val) then return _.t end
	
	return _.f
end

function u.inc_stop(val, max)
	local edge = _.f
	val = val + 1
	if val > max then
		val = max
		edge = _.t
	end
	return val, edge
end

function u.inc_loop(val, max, min)
	min = min or 1
	local loop = _.f
	val = val + 1
	-- u.log(val, max)
	if val > max then
		val = min
		loop = _.t
	end
	-- u.log(loop)
	return val, loop
end

function u.dec_stop(val, max, min)
	min = min or 1
	local edge = _.f
	val = val - 1
	if val < min then
		val = min
		edge = _.t
	end
	return val, edge
end

function u.dec_loop(val, max, min)
	min = min or 1
	local loop = _.f
	val = val - 1
	if val < min then
		val = max
		loop = _.t
	end
	return val, loop
end

function u.pls_loop(val1, val2, max, min)

	-- log._("u.pls_loop", val1, val2, max, min)

	min = min or 0
	local is_loop = _.f
	
	val1 = val1 + val2
	if val1 > max then
		val1 = min
		is_loop = _.t
	end
	return val1, is_loop
end

--[[
function u.is_rng(idx, p_ar) -- ar: {min, max} -- old
	return num.is_rng(idx, p_ar)
end
--]]

function u.x_by_itm_w(idx, max, w)
	
	local x = idx * w - (w / 2)
	local aw = w * max -- all w
	local awh = aw / 2 -- all w half
	x = x - awh
	return x
end

function u.x_by_all_w(idx, max, wa)
	local w1 = wa / (max - 1)
	local x1 = - wa / 2
	local x = x1 + w1 * (idx - 1)
	return x
end

function u.get_dcl_len(speed, accl)
	
	if accl >= 0 or speed <= 0 then return 0 end

	local len = speed
	while speed > 0 do
		speed = speed + accl
		if speed < 0 then speed = 0 end

		len = len + speed
	end
	return len
end

function u.vec_2_rad(vec)
	local rad = math.atan2(vec.y, vec.x)
	return rad
end

function u.rad_2_vec(rad)
	local ux = math.cos(rad)
	local uy = math.sin(rad)
	local u_vec = n.vec(ux, uy)
	return u_vec
end

function u.rad_diff(vec1, vec2)
	
	if (vec1.x == 0 and vec1.y == 0)
	or (vec2.x == 0 and vec2.y == 0) then return nil end
	
	local rad1 = u.vec_2_rad(vec1)
	local rad2 = u.vec_2_rad(vec2)
	local rad = rad1 - rad2
	if     rad >  math.pi then
		rad = rad - math.pi*2 
	elseif rad < -math.pi then
		rad = rad + math.pi*2
	end
	return rad
end

function u.eq(val1, val2)

	local ret = _.f

	if val1 == val2 then
		ret = _.t
	end
	return ret
end
