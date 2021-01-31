log.scrpt("ar.lua")

ar = {}

function ar.rnd(p_ar)
	return rnd.ar(p_ar)
end

function ar.idx_2_ha(p_ar, pre)
	for idx = 1, #p_ar do
		p_ar[ha._(pre..int.pad(idx))] = p_ar[idx]
		p_ar[idx] = nil
	end
end

function ar.in_(val, p_ar)
	local ret = _.f
	local i
	for i = 1, #p_ar do
		if val == p_ar[i] then
			ret = _.t
			break
		end
	end
	return ret
end

function ar.inHa(val, p_ar)
	local ret = _.f
	local i
	for i = 1, #p_ar do
		if val == ha._(p_ar[i]) then
			ret = _.t
			break
		end
	end
	return ret
end

function ar.del(p_ar)
	table.remove(p_ar)
end

function ar.pop(p_ar)
	table.remove(p_ar)
end

function ar.del_by_val(val, p_ar)
	
	local idx = ar.srch_idx(val, p_ar)
	
	if not idx        then return end
	if not (idx >= 1) then return end
	
	table.remove(p_ar, idx)
end

function ar.del_by_idx(p_ar, idx)
	table.remove(p_ar, idx)
end

--[[
function ar.del1(p_ar) -- old
	ar.del_1(p_ar)
end
--]]

function ar.del_1(p_ar)
	ar.del_by_idx(p_ar, 1)
end

function ar.srch_idx(val, p_ar)
	
	if not p_ar then return end

	local ret = nil
	for idx, arval in pairs(p_ar) do
		if val == arval then ret = idx break end
	end
	-- u.log(ret)
	return ret
end

function ar.cp(p_ar)
	local cp = {}
	for key, val in pairs(p_ar) do
		cp[key] = val
	end
	return cp
end

function ar.exclude(base, exclude)
	-- u.log("ar.exclude() bases", unpack(bases))
	-- u.log("ar.exclude() excludes", unpack(excludes))

	local cnt = 1
	local idx = 1
	while (idx <= #base) do
		rm = _.f
		for j, ex in pairs(exclude) do
			if base[idx] == ex then
				table.remove(base, idx)
				rm = _.t
				break
			end
		end
		-- u.log(cnt, #base, unpack(base))
		if not rm then idx = idx + 1 end
		cnt = cnt + 1
	end
end

function ar.exclude_cp(base, exclude)
	local cp = ar.cp(base)
	ar.exclude(cp, exclude)
	return cp
end

function ar.join(...)

	local args = {...}
	
	local ret = {}
	for idx, arg in pairs(args) do
		for idx2, val in pairs(arg) do
			ar.add(ret, val)
		end
	end
	return ret
end

function ar.clr(p_ar)
	for key, val in pairs(p_ar) do
		p_ar[key] = nil
	end
end

function ar.key(p_ar)
	local keys = {}
	for key, val in pairs(p_ar) do
		ar.add(keys, key)
	end
	return keys
end

function ar.srt(p_ar, cmp)
	table.sort(p_ar, cmp)
	return p_ar
end

function ar.keyHa_srt(p_ar)

	local keys = ar.key(p_ar)
	-- log.pp("keyHa_srt", keys)
	
	local cmp = function (val1, val2)
		-- log._("keyHa_srt cmp", val1, val2)
		return ha.de(val1) < ha.de(val2)
	end
	ar.srt(keys, cmp)
	-- log.pp("keyHa_srt", keys)
	return keys
end

function ar.key_mrg(ar_org, ar_add)
	for idHa, val in pairs(ar_add) do
		ar_org[idHa] = val
	end
	return ar_org
end

function ar.add_unq(val, p_ar)
	if ar.srch_idx(val, p_ar) then
		return
	end
	ar.add(p_ar, val)
end

function ar.add(p_ar, val)
	if not p_ar then return end
	table.insert(p_ar, val)
end

function ar.psh(p_ar, val)
	if not p_ar then return end
	table.insert(p_ar, val)
end

function ar.is_emp(p_ar)

	if not p_ar then return _.t end
	
	for idx, val in pairs(p_ar) do
		return _.f
	end
	return _.t
end

function ar.key___(p_ar)
	-- log.pp("ar.key in", p_ar)

	local keys = ar.key(p_ar)

	for idx, key in pairs(keys) do
		
		if type(key) == "string" and string.sub(key, 1, 1) ~= "_" then
			p_ar["_"..key] = p_ar[key]-- val
			p_ar[key] = nil
		else
			-- log._("ar.key", key, type(key))
		end
	end
	-- log.pp("ar.key ret", p_ar)
end

function ar.val_str_2_ha(p_ar)
	for key, val in pairs(p_ar) do
		if type(val) == "string" then
			p_ar[key] = ha._(val)
		end
	end
end
