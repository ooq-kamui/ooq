log.script("fac.lua")

fac = {}

function fac.cre(p_url, p_pos, p_rotation, p_prm)
	local id = factory.create(p_url, p_pos, p_rotation, p_prm)
	return id
end
