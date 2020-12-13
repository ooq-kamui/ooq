log.script("vec.lua")

vec = {}

function n.vec(x, y, z)   -- alias <- use now
	return vec.new(x, y, z)
end

function vec.new(x, y, z) -- alias
	return vec.n(x, y, z)
end

function vec.n(x, y, z)
	x = x or 0
	y = y or 0
	z = z or 0
	return vmath.vector3(x, y, z)
end

function vec.unit(p_vec)
	local t_rad = u.vec_2_rad(p_vec)
	return u.rad_2_vec(t_rad)
end

function vec.len(vec1, vec2)
	
	vec2 = vec2 or n.vec()

	local d = n.vec(vec1.x, vec1.y) - n.vec(vec2.x, vec2.y)
	local len = math.sqrt(d.x^2 + d.y^2)
	return len
end

function vec.clone(p_vec)
	local t_vec = n.vec(p_vec.x, p_vec.y, p_vec.z)
	return t_vec
end
