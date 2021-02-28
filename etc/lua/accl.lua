log.scrpt("accl.lua")

accl = {}

function accl.dcl_len(speed, accl)
	
	if accl >= 0 or speed <= 0 then return 0 end

	local len = speed
	while speed > 0 do
		speed = speed + accl
		if speed < 0 then speed = 0 end

		len = len + speed
	end
	return len
end







