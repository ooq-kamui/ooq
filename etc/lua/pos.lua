log.script("pos.lua")

pos = {}

function n.pos(x, y, z)
	return pos.new()
end

function pos.new(x, y, z)
	return vec.new(x, y, z)
end

function pos._(id)
	return id.pos(id)
end

function pos.by_id(id)
	return id.pos(id)
end

function pos.len(pos1, pos2)
	
	pos2 = pos2 or n.vec()
	
	local d = n.vec(pos1.x, pos1.y) - n.vec(pos2.x, pos2.y)
	local len = math.sqrt(d.x^2 + d.y^2)
	return len
end
