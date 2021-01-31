log.scrpt("clct.lua")

clct = {}

function clct.cre(url, pos, prm)
	-- log._("clct cre url", url)
	-- log.pp("clct cre prp", prp)
	-- local id = collectionfactory.create(url, pos)
	local id = collectionfactory.create(url, pos, nil, prm)
	return id
end
