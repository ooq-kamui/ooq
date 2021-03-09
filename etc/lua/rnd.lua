log.scrpt("rnd.lua")

rnd = {}

function rnd.ar(ar)
	
	if #ar <= 0 then return nil end

	local idx = math.random(1, #ar)
	local val = ar[idx]
	return val
end

function rnd.int(min, max, excld)
	
	local val = math.random(min, max)
	local val_pre = val

	if excld and val == excld then val = int.inc_loop(val, max, min) end

	return val
end

function rnd.int_pad(p_max)
	return int.pad(rnd.int(1, p_max))
end

function rnd.by_p(i)
	local ret = _.f
	local rnd = math.random(1, 100)
	if rnd <= i then
		ret = _.t
	end
	return ret
end

function rnd.by_f(f) -- f: 0 - 1
	local i = math.floor(f * 100)
	ret = rnd.by_p(i)
	return ret
end
