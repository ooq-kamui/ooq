log = {}

function log._(...)
	print(...)
end

function log.scrpt(file)
	local flg = _.f -- _.t
	if flg then log._(file) end
end

function log.pp(txt, data) -- alias
	log.p(txt, data)
end

function log.p(txt, data)
	log._(txt)
	pprint(data)
end

function log.if_(cnd, ...)

	if not cnd then return end

	log._(...)
end

function log.f(txt, val, dgt)

	local str = num._2_str(val, dgt)
	log._(txt, str)
end

function log.asrt(txt, data)

	assert(data, txt)
end

