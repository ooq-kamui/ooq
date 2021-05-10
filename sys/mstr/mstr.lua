log.scrpt("mstr.lua")

Mstr = {
	gold_dflt = 10,
}

function Mstr.gold(p_cls, p_name)

	local gold

	if  Mstr[p_cls]
	and Mstr[p_cls][p_name]
	and Mstr[p_cls][p_name].gold then
		gold = Mstr[p_cls][p_name].gold
		log._("mstr gold", p_cls, p_name, gold)
	else
		gold = Mstr.gold_dflt
		log._("mstr gold dflt", p_cls, p_name, gold)
	end
	return gold
end

