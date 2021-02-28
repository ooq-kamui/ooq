log.scrpt("cls.lua")

Cls = {
	Cls = {},
}

function Cls.add(p_Cls, ha_add_by)
	
	Cls.Cls[ha._(p_Cls.cls)] = p_Cls

	if not ha_add_by then
		ha.add_by_Cls(p_Cls)
	else
		ha.add_by_ar(ha_add_by)
	end
end

function Cls._(p_cls) -- get

	local clsHa = ha._2_ha(p_cls)
	-- local clsHa = ha._2_ha(p_cls)

	return Cls.Cls[clsHa]
end

--[[
function Cls.prp(p_clsHa, p_prp) -- old

	local t_Cls = Cls._(p_clsHa)
	
	if not t_Cls then return end
	
	local ret = t_Cls[p_prp]

	if not ret then return end

	return ret
end
--]]

