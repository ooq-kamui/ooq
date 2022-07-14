log.scrpt("ts.lua")

ts = {}

function ts.now()
	local ts = os.time()
	return ts
end

function ts.str(p_ts)
	p_ts = p_ts or ts.now()
	local ts_str = os.date("%Y-%m-%d %H:%M:%S", p_ts)
	return ts_str
end

function ts.ar(p_ts)
	p_ts = p_ts or ts.now()
	local ts_ar = os.date("*t", p_ts)
	return ts_ar
end

