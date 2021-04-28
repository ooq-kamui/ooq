log.scrpt("ha.lua")

ha = {
	ha = {}, -- hash key list
	_emp = hash("")
}

function ha._(val)

	if not val then return hash("") end

	return hash(val)
end

function ha._2_ha(p_str)

	local t_type = type(p_str)
	if t_type == "userdata" then return p_str end

	local strHa = ha._(p_str)

	return strHa
end

function ha.de(keyHa)
	local val = ha.ha[keyHa]
	if not val then --[[ log._("ha.de() nil", keyHa) --]] end
	return val
end

function ha.add(val)
	ha.ha[ha._(val)] = val
end

function ha.add_by_ar(p_ar)
	local valHa
	for idx, val in pairs(p_ar) do
		valHa = ha._(val)
		ha.ha[valHa] = val
	end
end

function ha.add_by_key_num(key, num)
	local keyHa
	for idx = 1, num do
		val   = key .. int.pad(idx)
		keyHa = ha._(val)
		ha.ha[keyHa] = val
	end
end

function ha.add_by_Cls(p_Cls)
	
	ha.add(p_Cls.cls)
	
	if not p_Cls.name_idx_max then return end
	
	ha.add_by_key_num(p_Cls.cls, p_Cls.name_idx_max)
end

-- 

function ha.is_emp(val)

	local ret
	if not val or val == ha._emp then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

function ha.is_emp__(ref, p_val)

	if not ha.is_emp(ref) then return end

	if type(p_val) == "string" then
		p_val = ha._(p_val)
	end
	ref = p_val
end

function ha.eq(val, key)
	if val == ha._(key) then return _.t
	else                     return _.f
	end
end

function ha.emp()
	return ha._emp
end

