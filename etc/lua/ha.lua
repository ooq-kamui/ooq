log.script("ha.lua")

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

function ha.idx2ha(idx_ar)
	local ha_ar = {}
	for idx, val in pairs(idx_ar) do
		-- ha_ar[hash(val)] = val
		ha_ar[ha._(val)] = val
	end
	return ha_ar
end

function ha.is_emp(val)
	local ret = _.f
	if not val or val == ha._emp then
		ret = _.t
	end
	return ret
end

function ha.eq(val, key)
	if val == ha._(key) then return _.t
	else                     return _.f
	end
end

function ha.emp()
	return ha._emp
end
