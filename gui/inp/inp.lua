log.script("inp.lua")

Gui_inp = {
	id  = nil, -- 
	gui = nil, -- url

	focus_gui = nil, -- gui url
	focus_lb  = nil, -- gui lb

	-- v = 2, -- or 3
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

Gui_inp.arwHa_2_inp_dir = {}
Gui_inp.arwHa_2_inp_dir[ha._("arw_u")] = "u"
Gui_inp.arwHa_2_inp_dir[ha._("arw_d")] = "d"
Gui_inp.arwHa_2_inp_dir[ha._("arw_l")] = "l"
Gui_inp.arwHa_2_inp_dir[ha._("arw_r")] = "r"

Gui_inp.arwHa_2_dir = Gui_inp.arwHa_2_inp_dir -- old

Gui_inp.dir_2_arw = {}
Gui_inp.dir_2_arw["u"] = "arw_u"
Gui_inp.dir_2_arw["d"] = "arw_d"
Gui_inp.dir_2_arw["l"] = "arw_l"
Gui_inp.dir_2_arw["r"] = "arw_r"

-- static

function Gui_inp.cre()
	-- local t_url = url._("guiFac", "inp")
	local t_url = url._("/sys", "fac_gui_inp")
	local id = fac.cre(t_url)
	return id
end

function Gui_inp.is_focus()
	local ret = Gui_inp.focus_gui and _.t or _.f
	return ret
end

-- script method

function Gui_inp.init(_s)
	
	extend._(_s, Gui_inp)
	
	_s.keyact = {}
	-- Gui_inp.v4_keyact = _s.keyact
end

function Gui_inp.on_msg(_s, msg_id, prm, sender)
	
	if     ha.eq(msg_id, "focus__t" ) then
		if not Gui_inp.focus_gui then
			pst._(".", "acquire_input_focus")
		end
		Gui_inp.focus_gui = prm.focus_gui
		Gui_inp.focus_lb  = prm.focus_lb
		
	elseif ha.eq(msg_id, "focus__f") then
		pst._(".", "release_input_focus")
		Gui_inp.focus_gui = nil
		Gui_inp.focus_lb  = nil
	end
	-- log._("gui inp on_msg", msg_id, Gui_inp.focus_gui, Gui_inp.focus_lb)
end

function Gui_inp.on_inp(_s, key, keyact)
	-- log._("gui inp", Gui_inp.focus_gui, Gui_inp.focus_lb)

	if ar.in_(Gui_inp.focus_lb, Gui_inp.v3) then
		_s:on_inp_v3(key, keyact)
	end
end

function Gui_inp.on_inp_v3(_s, key, keyact)

	_s:on_inp_keyact__(key, keyact)

	pst._(Gui_inp.focus_gui, "key", {key = key, keyact = _s.keyact[key]})

	if key == ha._("s") and _s.keyact[key] == "f" then
		_s.keyact[ha._("s")] = nil
	end
end

function Gui_inp.on_inp_keyact__(_s, key, keyact)
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
