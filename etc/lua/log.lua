log = {
	_flg = _.f
}

function log._(...)
	print(...)
end

function log.scrpt(file)
	local flg = _.f -- _.t
	if flg then log._(file) end
end

function log.pp(txt, ...) -- alias
	log.p(txt, ...)
end

function log.p(txt, ...)
	log._(txt)
	
	for idx, data in pairs({...}) do
		pprint(data)
	end
end

function log.if_(cnd, ...)

	if not cnd then return end

	log._(...)
end

function log.flg(...)

	if not log._flg then return end

	log._(...)
end

function log.flg__(val)

	log._flg = val
end

function log.f(txt, val, dgt)

	local str = num._2_str(val, dgt)
	log._(txt, str)
end

function log.asrt(txt, data)

	assert(data, txt)
end

