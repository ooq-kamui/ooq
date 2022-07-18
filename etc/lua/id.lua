log.scrpt("id.lua")

id = {}

function id._()
	
	local t_id = go.get_id()
	return t_id
end

function id.prp(p_id, key)
	-- log._("id.prp", p_id, key)

	if ha.is_emp(p_id) then return end
	
	local t_url = url._(p_id)
	-- log._("id.prp t_url", t_url, key)
	
	local val = go.get(t_url, key)

	return val
end

function id.prp_de(p_id, key) -- use not

	local valHa = id.prp(p_id, key)

	if ha.is_emp(valHa) then return nil end

	local val = ha.de(valHa)
	return val
end

function id.prp__(p_id, key, val)

	if ha.is_emp(p_id) then return end

	local t_url = url._(p_id)

	go.set(t_url, key, val)
end

function id.clsHa(p_id) -- old rest

	return id.prp(p_id, "_clsHa")
end

function id.pos(p_id)
	
	if not p_id then log._("id.pos", p_id) return end
	
	local t_pos = go.get_position(p_id)
	return t_pos
end

function id.z(p_id)
	
	if not p_id then return end
	
	local t_pos = id.pos(p_id)
	local z = t_pos.z
	return z
end

function id.pos_w(p_id)
	
	if not p_id then return end
	
	local t_pos = go.get_world_position(p_id)
	return t_pos
end

function id.pos__(p_id, p_pos)
	
	if not p_id  then return end
	if not p_pos then return end
	
	p_pos.z = id.pos(p_id).z
	go.set_position(p_pos, p_id)
end

function id.z__(p_id, z)
	
	if not p_id then return end
	
	z = z or 0
	
	local t_pos = id.pos(p_id)
	t_pos.z = z
	go.set_position(t_pos, p_id)
end

function id.pst(id, msg_id, prm)
	pst.scrpt(id, msg_id, prm)
end

function id.del(p_id, val)

	if not p_id then go.delete() end

	if val then
		go.delete(p_id, val)
	else
		go.delete(p_id)
	end
end

