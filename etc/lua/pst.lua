log.scrpt("pst.lua")

pst = {}
post = pst -- old

function pst._(url, msg_id, prm)
	if prm then
		msg.post(url, msg_id, prm)
	else
		msg.post(url, msg_id)
	end
end

function pst.scrpt(id, msg_id, prm)
	local url = msg.url(nil, id, "script")
	pst._(url, msg_id, prm)
end

function pst.gui(id, msg_id, prm)
	local t_url = url._(id, "gui")
	pst._(t_url, msg_id, prm)
end

function pst.sprite(id, msg_id, prm)
	local t_url = url._(id, "sprite")
	pst._(t_url, msg_id, prm)
end

function pst.parent__(t_id, p_id, z, p_pos)

	if ha.is_emp(t_id) then return end

	pst.scrpt(t_id, "set_parent", {parent_id = p_id, keep_world_transform = 1})

	z = z or - 0.01
	pst.z__(t_id, z)

	id.prp__(t_id, "_parent_id", p_id)

	-- pos
	if p_pos then pst.pos__(t_id, p_pos) end
end

function pst.parent__map(t_id, z)

	if ha.is_emp(t_id) then return end

	local map_id = Game.map_id()
	pst.parent__(t_id, map_id, z)
end

function pst.pos__(p_id, p_pos)
	
	p_pos = p_pos or n.vec()
	
	pst.scrpt(p_id, "pos__", {pos = p_pos})
end

function pst.z__(p_id, z)
	z = z or 0
	pst.scrpt(p_id, "z__", {z = z})
end
