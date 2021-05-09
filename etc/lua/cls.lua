log.scrpt("cls.lua")

Cls = {
	_Cls = {},
}

function Cls.add(p_Cls)
	
	Cls._Cls[ha._(p_Cls.cls)] = p_Cls
	Cls._Cls[     p_Cls.cls ] = p_Cls

	-- ha.add_by_Cls(p_Cls)
end

function Cls._(p_cls) -- alias old
	return Cls.Cls(p_cls)
end

function Cls.Cls(p_cls)

	local p_clsHa
	local r_Cls

	if type(p_cls) == "string" then
		r_Cls = Cls._Cls[p_cls]
	else
		p_clsHa = p_cls
		r_Cls = Cls._Cls[p_clsHa]
	end
	-- log._("Cls._", p_cls, p_clsHa)
	return r_Cls
end

function Cls.Cls_by_Ha(p_clsHa)

	local r_Cls = Cls._Cls[p_clsHa]
	return r_Cls
end

