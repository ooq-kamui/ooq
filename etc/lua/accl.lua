log.scrpt("accl.lua")

accl = {}

-- static

function n.accl() -- alias
	return accl.new()
end

function accl.new()
	local obj = {}
	extend.init(obj, accl)
	return obj
end

-- method

function accl.init(_s)

	_s._speed  = n.vec()
	_s._accl_h = 0
	_s._grv    = 0






end

function accl.speed(_s)
	return _s._speed
end









-- static

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

