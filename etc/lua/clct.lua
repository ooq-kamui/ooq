log.scrpt("clct.lua")

clct = {}

function clct.cre(url, pos, prm)
	local t_id = collectionfactory.create(url, pos, nil, prm)
	return t_id
end

