log.scrpt("ar.lua")

ar = {}

function ar.rnd(p_ar)
	return rnd.ar(p_ar)
end

function ar.idx_2_ha(p_ar, pre) -- old
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

function ar.inHa(valHa, p_ar)
	local ret = _.f
	local idx
	for idx = 1, #p_ar do
		if valHa == ha._(p_ar[idx]) then
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

function ar.del_6_val(p_ar, val)
	
	local idx = ar.srch_idx(p_ar, val)
	
	if not idx        then return end
	if not (idx >= 1) then return end
	
	table.remove(p_ar, idx)
end

function ar.del_6_idx(p_ar, idx)
	table.remove(p_ar, idx)
end

function ar.del_1(p_ar)
	ar.del_6_idx(p_ar, 1)
end

function ar.srch_idx(p_ar, val)
	
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

function ar.exclude(base, exclude) -- old
	ar.excld(base, exclude)
end

function ar.excld(base, exclude)
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

function ar.exclude_cp(base, exclude) -- old

	return ar.excld_cp(base, exclude)
end

function ar.excld_cp(base, exclude)

	local cp = ar.cp(base)
	ar.exclude(cp, exclude)
	return cp
end

function ar.add_ar(p_ar1, p_ar2)

	for idx, val in pairs(p_ar2) do
		ar.add(p_ar1, val)
	end
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
	for key, val in pairs(ar_add) do
		ar_org[key] = val
	end
	return ar_org
end

function ar.add_unq(p_ar, val)

	if ar.srch_idx(p_ar, val) then return end

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

function ar.tail(p_ar)

	local ret = p_ar[#p_ar]
	return ret
end

function ar.chld_ar__init_if_nil(p_ar, key)
	
	if not p_ar[key] then
		p_ar[key] = {}
	end
end

