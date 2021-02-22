log.scrpt("p.zu_animal.lua")

p.Zu_animal = {}

-- static

function p.Zu_animal.cre(parent_gui)
	local p_Prt = p.Zu_animal
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

function p.Zu_animal.is_favo(name, o_cls, o_name)
	local ret = _.f
	local favo = p.Zu_animal.favo[name]
	if not favo[o_cls] then return ret end
	ret = ar.in_(o_name, favo[o_cls])
	return ret
end

function p.Zu_animal.animal__o(name)
	Ply_data._zu.animal[name] = _.t
end

-- script method

function p.Zu_animal.init(_s, parent_gui)

	_s._lb = "zu_animal"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Zu_animal)
	
	_s._itm_pitch = 51
	_s._dsp_idx_max = 8
	
	_s:itm__by_ar(Anml.animal)
	
	local node
	for idx, name in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("txt")], int.pad(idx))
	end
end

-- method

function p.Zu_animal.opn(_s, prm)
	
	_s:itm_icn__()
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Zu_animal.itm_icn__(_s)
	
	local icn, nameHa
	for idx, name in pairs(_s._itm) do
		log._("p.Zu_animal.itm_icn__", name)
		icn = _s._nd.itm[idx][_s:lb("icn")]
		nameHa = ha._(name)
		if Ply_data._zu.animal[nameHa] then
			nd.txtr__(icn, nameHa)
			-- gui.play_flipbook(icn, "walk")
			nd.anm__( icn, "walk")
		else
			nd.txtr__(icn, "noimg")
			-- gui.play_flipbook(icn, "noimg")
			nd.anm__( icn, "noimg")
		end
	end
end

function p.Zu_animal.decide(_s)
end
