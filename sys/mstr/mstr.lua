log.scrpt("mstr.lua")

Mstr = {
	gold_dflt = 10,
}

function Mstr.gold(p_clsHa, p_nameHa)

	local gold

	local p_cls  = ha.de(p_clsHa )
	local p_name = ha.de(p_nameHa)

	if  Mstr[p_cls]
	and Mstr[p_cls][p_name]
	and Mstr[p_cls][p_name].gold then
		gold = Mstr[p_cls][p_name].gold
		log._("mstr gold", p_cls, p_name, gold)
	else
		gold = Mstr.gold_dflt
		log._("mstr gold dflt", p_cls, p_name, gold)
	end
	--[[
	log._("mstr gold", p_cls, p_name, gold)
	log._("cls" , Mstr[p_cls])
	log._("name", Mstr[p_cls][p_name])
	log._("gold", Mstr[p_cls][p_name].gold)
	--]]

	return gold
end

