log.script("p.zu_flower.lua")

p.Zu_flower = {}

-- static

function p.Zu_flower.cre(parent_gui)
	local p_Prt = p.Zu_flower
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Zu_flower.init(_s, parent_gui)

	_s._lb = "zu_flower"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Zu_flower)

	_s._itm_pitch = 51
	_s._dsp_idx_max = 8
	
	-- for i = 1, Flower.name_idx_max do
	_s:itm__by_idx("flower", 10)
	
	local node
	for idx, name in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("txt")], int.pad(idx))
	end
end

-- method

function p.Zu_flower.opn(_s, prm)
	
	_s:itm_icn__()
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Zu_flower.itm_icn__(_s)

	local icn, nameHa
	for idx, name in pairs(_s._itm) do
		icn = _s._nd.itm[idx][_s:lb("icn")]
		nameHa = ha._(name)
		if Ply_data._zu.flower[nameHa] then
			nd.txtr__(icn, "flower")
			nd.anm__(icn, nameHa)
		else
			nd.txtr__(icn, "noimg")
			nd.anm__(icn, "noimg")
		end
	end
end

function p.Zu_flower.decide(_s)
end
