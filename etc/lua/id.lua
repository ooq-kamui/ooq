log.script("id.lua")

id = {}

function id.prp(p_id, key)
	-- log._("id.prp", p_id, key)

	-- if not p_id then return end
	if ha.is_emp(p_id) then return end
	
	local t_url = url._(p_id)
	-- log._("id.prp t_url", t_url, key)
	
	local val = go.get(t_url, key)

	return val
end

function id.prp_de(p_id, key)
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

function id.cls(p_id)
	return id.prp(p_id, "_cls")
end

function id.name(p_id)
	return id.prp(p_id, "_name")
end

function id.pos(id)
	
	if not id then return end
	
	local pos = go.get_position(id)
	return pos
end

function id.wpos(id)
	
	if not id then return end
	
	local pos = go.get_world_position(id)
	return pos
end

function id.pos__(p_id, pos)
	
	if not p_id then return end
	if not pos  then return end
	
	pos.z = id.pos(p_id).z
	go.set_position(pos, p_id)
end

function id.z__(p_id, z)
	
	if not p_id then return end
	
	z = z or 0
	
	local pos = id.pos(p_id)
	pos.z = z
	go.set_position(pos, p_id)
end

function id.pst(id, msg_id, prm)
	pst.script(id, msg_id, prm)
end

function id.del(p_id, val)
	if val then
		go.delete(p_id, val)
	else
		go.delete(p_id)
	end
end
