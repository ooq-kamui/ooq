log.script("num.lua")

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
