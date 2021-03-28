log.scrpt("fac.lua")

fac = {}

function fac.cre(p_url, p_pos, p_rotation, p_prm, p_scl)

	local t_id = factory.create(p_url, p_pos, p_rotation, p_prm, p_scl)
	return t_id
end

