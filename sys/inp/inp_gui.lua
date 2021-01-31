log.scrpt("inp_gui.lua")

Inp_gui = {

	id  = nil, -- 
	gui = nil, -- url

	focus_gui = nil, -- gui url
	focus_lb  = nil, -- gui lb

	v3 = {
		"bag", -- "bag_prt", "bag_itm", "bag_inf", "bag_block", "bag_wall",
		"confirm", "bg",
		"title", "logo", "ply_slt", "ply_data",
		"flpy",
		"pc", "cfg", "kzn",
		"snn_lst", "snn_dtl",
		"shop", "shop_flower", "shop_tree", "shop_kagu", "shop_kagu_itm", "shop_block",
		"shelf", "zu_animal", "zu_flower", "zu_dish",
		"door",
		"dia",
		"reizoko",
	}, -- lb
}

Inp_gui.arwHa_2_inp_dir = {}
Inp_gui.arwHa_2_inp_dir[ha._("arw_u")] = "u"
Inp_gui.arwHa_2_inp_dir[ha._("arw_d")] = "d"
Inp_gui.arwHa_2_inp_dir[ha._("arw_l")] = "l"
Inp_gui.arwHa_2_inp_dir[ha._("arw_r")] = "r"

Inp_gui.arwHa_2_dir = Inp_gui.arwHa_2_inp_dir -- old

Inp_gui.dir_2_arw = {}
Inp_gui.dir_2_arw["u"] = "arw_u"
Inp_gui.dir_2_arw["d"] = "arw_d"
Inp_gui.dir_2_arw["l"] = "arw_l"
Inp_gui.dir_2_arw["r"] = "arw_r"

-- static

function Inp_gui.cre()

	local t_url = url._("/sys", "fac_inp_gui")
	local id = fac.cre(t_url)
	return id
end

function Inp_gui.is_focus()
	local ret = Inp_gui.focus_gui and _.t or _.f
	return ret
end

-- script method

function Inp_gui.init(_s)
	
	extend._(_s, Inp_gui)
	
	_s.keyact = {}
	-- Inp_gui.v4_keyact = _s.keyact
end

function Inp_gui.on_msg(_s, msg_id, prm, sender)
	
	if     ha.eq(msg_id, "focus__t" ) then
		log._("Inp_gui on_msg focus__t", prm.focus_gui, prm.focus_lb)

		Inp_gui.focus_gui = prm.focus_gui
		Inp_gui.focus_lb  = prm.focus_lb
		
	elseif ha.eq(msg_id, "focus__f") then
		log._("Inp_gui on_msg focus__f")
		
		Inp_gui.focus_gui = nil
		Inp_gui.focus_lb  = nil
	end
	-- log._("gui inp on_msg", msg_id, Inp_gui.focus_gui, Inp_gui.focus_lb)
end

function Inp_gui.on_inp(_s, key, keyact)
	log._("Inp_gui on_inp", Inp_gui.focus_gui, Inp_gui.focus_lb)

	if ar.in_(Inp_gui.focus_lb, Inp_gui.v3) then
		_s:on_inp_v3(key, keyact)
	end
end

function Inp_gui.on_inp_v3(_s, key, keyact)

	_s:on_inp_keyact__(key, keyact)

	pst._(Inp_gui.focus_gui, "key", {key = key, keyact = _s.keyact[key]})

	if key == ha._("s") and _s.keyact[key] == "f" then
		_s.keyact[ha._("s")] = nil
	end
end

function Inp_gui.on_inp_keyact__(_s, key, keyact)
	-- log._("on_inp_set_keyact")
	
	if     keyact.pressed then
		_s.keyact[key] = "p"
	elseif keyact.released then
		_s.keyact[key] = "f"
	elseif _s.keyact[key] == "p" then
		_s.keyact[key] = "w"
	elseif _s.keyact[key] == "w" and keyact.repeated then
		_s.keyact[key] = "k"
	elseif _s.keyact[key] == "k" then
		-- nothing
	end
end

