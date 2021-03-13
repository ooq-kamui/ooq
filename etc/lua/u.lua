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
	if val_type == "string" and val == ""      then return _.t end
	if val_type == "table"  and ar.is_emp(val) then return _.t end
	
	return _.f
end

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

--[[
function u.pos() -- old
	return go.get_position()
end
--]]

