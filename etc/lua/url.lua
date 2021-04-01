log.scrpt("url.lua")

url = {}

function url._(p_id, cmp)
	
	if not p_id then return end

	cmp = cmp or "script"

	local t_url = msg.url(nil, p_id, cmp)
	-- log._("url._", url)
	return t_url
end

function url.slf()
	return msg.url()
end

