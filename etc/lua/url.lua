log.scrpt("url.lua")

url = {}

function url._(p_id, cmp)
	
	if not p_id then return end

	cmp = cmp or "script"

	local url = msg.url(nil, p_id, cmp)
	-- log._("url._", url)
	return url
end

function url.main(id, cmp)

	if not id then return end

	cmp = cmp or "script"

	local url = msg.url("main", id, cmp)
	return url
end
