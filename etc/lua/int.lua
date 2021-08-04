log.scrpt("int.lua")

int = {_ = {}}

function int.inc_stop(val, max)
	local edge = _.f
	val = val + 1
	if val > max then
		val = max
		edge = _.t
	end
	return val, edge
end

function int.inc_loop(val, max, min)
	min = min or 1
	local loop = _.f
	val = val + 1
	-- u.log(val, max)
	if val > max then
		val = min
		loop = _.t
	end
	-- u.log(loop)
	return val, loop
end

function int.dec_stop(val, max, min)
	min = min or 1
	local edge = _.f
	val = val - 1
	if val < min then
		val = min
		edge = _.t
	end
	return val, edge
end

function int.dec_loop(val, max, min)
	min = min or 1
	local loop = _.f
	val = val - 1
	if val < min then
		val = max
		loop = _.t
	end
	return val, loop
end

function int.__sub_loop(num, d, max)
	-- log._("int.__sub_loop()", num, d, max)
	local ret = num - d
	if ret <= 0 then
		ret = ret + max
	end
	return ret
end

function int.__pls_loop(val1, val2, max)

	return num.__pls_loop(val1, val2, max, 1)
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

function int.loop_df(fr_idx, to_idx, max)
	-- log._("int.loop_df", fr_idx, to_idx, max)

	local df

	if to_idx < fr_idx then
		to_idx = max + to_idx
	end
	df = to_idx - fr_idx

	-- log._("int.loop_df", df)
	return df
end

