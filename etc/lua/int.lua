log.scrpt("int.lua")

int = {_ = {}}

function int.sub_loop(num, d, max)
	-- log._("int.sub_loop()", num, d, max)
	local ret = num - d
	if ret <= 0 then
		ret = ret + max
	end
	return ret
end

function int._2_str(p_int)
	return tostring(p_int)
end

function int.pad(i, digit, str)
	digit = digit or 3
	str   = str   or "0"
	return string.format("%"..str..digit.."d", i)
end

function int.is_rng(idx, p_ar) -- ar: {min, max}

	if not idx then return _.f end

	local ret = _.f
	if idx >= p_ar[1] and idx <= p_ar[2] then
		ret = _.t
	end
	return ret
end

function int.dlm(idx, dlm_idx)

	local page_idx = math.ceil(idx / dlm_idx)
	
	local dsp_idx = idx % dlm_idx
	if dsp_idx == 0 then dsp_idx = dlm_idx end
	
	return page_idx, dsp_idx
end

