log.scrpt("num.lua")

num = {
	_ = {},
}

function num._2_int_d(num)
	local ret = math.floor(num)
	return ret
end

function num._2_int_u(num)
	local ret = math.ceil(num)
	return ret
end

function num.is_rng(p_num, p_ar) -- {min, max}
	local ret = _.f
	if p_num >= p_ar[1] and p_num <= p_ar[2] then
		ret = _.t
	end
	return ret
end

function num._2_sign(p_num)
	local sign = ( p_num >= 0 ) and "+" or "-"
	return sign
end

function num.__pls_stop_abs(p_num, p_pls, p_max)

	p_num = p_num + p_pls

	if     p_num >   p_max then
		p_num =   p_max
	elseif p_num < - p_max then
		p_num = - p_max
	end

	return p_num
end

function num.__pls_stop_min(p_num, p_pls, p_min)

	p_num = p_num + p_pls

	if     p_num <   p_min then
		p_num =   p_min
	end

	return p_num
end

function num.pls_loop(val1, val2, max, min) -- old
	return num.__pls_loop(val1, val2, max, min)
end

function num.__pls_loop(val1, val2, max, min)

	min = min or 0
	local is_loop = _.f
	
	val1 = val1 + val2
	if val1 > max then
		val1 = min
		is_loop = _.t
	end
	return val1, is_loop
end

function num._2_str(val, dgt)

	dgt = dgt or "2"

	local str = string.format("%."..dgt.."f", val)
	return str
end

function num.is_nan(val)

	local ret = ( val ~= val )
	return ret
end

