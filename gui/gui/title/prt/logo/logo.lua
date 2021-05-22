log.scrpt("p.logo.lua")

p.Logo = {}

-- static

function p.Logo.cre(parent_gui)
	local t_Prt = p.Logo
	local gui_prt = p.Prt.cre(t_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Logo.init(_s, parent_gui)

	_s._lb = "logo"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd._(_s, p.Logo)
	
	_s._itm_pitch = 100
	
	_s:nd__("logo")
end

function p.Logo.key_2_act(_s, prm)
	-- log._("gp.logo key_2_act")
	
	local key    = prm.key
	local keyact = prm.keyact
	if not (keyact == "p") then return end

	if _s._wakeup then
		if     ar.inHa(key, {"x"}) then
			_s:decide()
		elseif ar.inHa(key, {"s", "z"}) then
			_s:wakeup__(_.f)
		end
	else
		if     ar.inHa(key, {"s", "z", "x"}) then
			_s:wakeup__(_.t)
		end
	end
end

-- method

function p.Logo.opn(_s)
	-- log._("gp.logo opn")
	_s:focus__(_.t)
	_s:wakeup__(_.t)
end

function p.Logo.wakeup__(_s, val)
	-- log._("gp logo wakeup__", val)
	_s._wakeup = val
	local time = 3
	_s:base_dsp__(val, nil, time)
end

function p.Logo.logo_dsp__(_s, val)
	-- log._("gp logo logo_dsp__", val)
	local time = 3
	nd.anm.dsp__(_s:nd("logo"), val, time)
end

function p.Logo.decide(_s)
	-- log._("gp logo decide")
	_s:behind()
	_s._parent_gui:opn("ply_slt")
end
