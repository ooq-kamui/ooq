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

