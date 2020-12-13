log.script("cls.script")

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

function Cls._(cls)

	local t_type = type(cls)
	-- if t_type ~= "userdata" then log._("Cls _ type", t_type) end
	
	local clsHa
	if     t_type == "string"   then clsHa = ha._(cls)
	elseif t_type == "userdata" then clsHa = cls
	else                             clsHa = ha._(cls)
	end
	return Cls.Cls[clsHa]
end
