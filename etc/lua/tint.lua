log.scrpt("tint.lua")

tint = {}

function tint.int_2_dcml(p_int) -- 0 - 255 > 0 - 1

	local dcml = p_int / 255
	return dcml
end

