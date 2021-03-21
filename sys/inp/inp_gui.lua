log.scrpt("inp_gui.lua")

Inp.gui = {

	id  = nil, -- 
	gui = nil, -- url

	-- focus_gui = nil, -- gui url
	-- focus_lb  = nil, -- gui lb

	v3 = {
		"bag", -- "bag_prt", "bag_itm", "bag_inf", "bag_block", "bag_wall",
		"confirm", "bg",
		"title", "logo", "ply_slt", "ply_data",
		"flpy",
		"pc", "cfg", "kzn",
		"snn_lst", "snn_dtl",
		"shop", "shop_flower", "shop_tree", "shop_kagu", "shop_kagu_itm", "shop_block",
		"shelf", "zu_anml", "zu_flower", "zu_dish",
		"door",
		"dia",
		"reizoko",
	}, -- lb
}

Inp.gui.arwHa_2_inp_dir = {} -- old
Inp.gui.arwHa_2_inp_dir[ha._("arw_u")] = "u"
Inp.gui.arwHa_2_inp_dir[ha._("arw_d")] = "d"
Inp.gui.arwHa_2_inp_dir[ha._("arw_l")] = "l"
Inp.gui.arwHa_2_inp_dir[ha._("arw_r")] = "r"

Inp.gui.dir_2_arw = {} -- old
Inp.gui.dir_2_arw["u"] = "arw_u"
Inp.gui.dir_2_arw["d"] = "arw_d"
Inp.gui.dir_2_arw["l"] = "arw_l"
Inp.gui.dir_2_arw["r"] = "arw_r"

-- script method

-- init

function Inp.gui.init_gui(_s)
	
	_s._gui_url = url._(_s._id, "gui")

	_s._focus_gui_url = ha.emp()
	_s._focus_gui_lb  = nil

	_s._gui = {}
	_s._gui._keyact = {}
end

-- on_inp

function Inp.gui.on_inp_gui(_s, key, keyact)
	-- log._("Inp on_inp_gui", _s._focus_gui_url, _s._focus_gui_lb)

	if ar.in_(_s._focus_gui_lb, Inp.gui.v3) then
		_s:on_inp_gui_v3(key, keyact)
	end
end

function Inp.gui.on_inp_gui_v3(_s, key, keyact)

	_s:on_inp_gui_keyact__(key, keyact)

	pst._(_s._focus_gui_url, "key", {key = key, keyact = _s._gui._keyact[key]})

	if key == ha._("s") and _s._gui._keyact[key] == "f" then
		_s._gui._keyact[ha._("s")] = nil
	end
end

function Inp.gui.on_inp_gui_keyact__(_s, key, keyact)
	-- log._("on_inp_set_keyact")
	
	if     keyact.pressed then
		_s._gui._keyact[key] = "p"
	elseif keyact.released then
		_s._gui._keyact[key] = "f"
	elseif _s._gui._keyact[key] == "p" then
		_s._gui._keyact[key] = "w"
	elseif _s._gui._keyact[key] == "w" and keyact.repeated then
		_s._gui._keyact[key] = "k"
	elseif _s._gui._keyact[key] == "k" then
		-- nothing
	end
end

-- Inp.gui.arwha_2_dir = Inp.gui.arwHa_2_dir -- old use?
-- Inp.gui.arwha_2_dir = Inp.gui.arwHa_2_inp_dir -- old use?

