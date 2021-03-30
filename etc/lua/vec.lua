log.scrpt("vec.lua")

vec = {
	-- const
	_0 = vmath.vector3(0, 0, 0),
	_1 = vmath.vector3(1, 1, 0),
}

function n.vec(x, y, z, note) -- alias
	log._("n.vec", note)
	return vec.new(x, y, z)
end

function vec.new(x, y, z)

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

function vec.cp(p_vec, p_x, p_y)

	local t_vec = n.vec(p_vec.x, p_vec.y, p_vec.z)

	if p_x then t_vec.x = t_vec.x + p_x end
	if p_y then t_vec.y = t_vec.y + p_y end

	return t_vec
end

function vec.__clr(p_vec)

	p_vec.x = 0
	p_vec.y = 0
	p_vec.z = 0
end

function vec.xy__clr(p_vec)

	p_vec.x = 0
	p_vec.y = 0
end

function vec.xy__(p_vec, p_x, p_y)

	p_vec.x = p_x
	p_vec.y = p_y
end

function vec.xy__add(p_vec, p_x, p_y)

	p_vec.x = p_vec.x + p_x
	p_vec.y = p_vec.y + p_y
end

