log.scrpt("inp.lua")

Inp = {
	keys_arw_h = {
		"arw_l", "arw_r",
	},
	keys_arw_v = {
		"arw_u", "arw_d",
	},
	keys_btn = {
		"a", "z", "x", "s",
		"q", "w",
	},
}
Inp.keys_arw = {}
ar.add_ar(Inp.keys_arw, Inp.keys_arw_h)
ar.add_ar(Inp.keys_arw, Inp.keys_arw_v)

Inp.arw_2_dir = {}
Inp.arw_2_dir["arw_u"] = "u"
Inp.arw_2_dir["arw_d"] = "d"
Inp.arw_2_dir["arw_l"] = "l"
Inp.arw_2_dir["arw_r"] = "r"

Inp.arwHa_2_dir = {}
Inp.arwHa_2_dir[ha._("arw_u")] = "u"
Inp.arwHa_2_dir[ha._("arw_d")] = "d"
Inp.arwHa_2_dir[ha._("arw_l")] = "l"
Inp.arwHa_2_dir[ha._("arw_r")] = "r"

Inp.dir_2_arw = {}
Inp.dir_2_arw["u"] = "arw_u"
Inp.dir_2_arw["d"] = "arw_d"
Inp.dir_2_arw["l"] = "arw_l"
Inp.dir_2_arw["r"] = "arw_r"

-- static

function Inp.cre()

	local t_url = url._("/sys", "fac_inp")
	local t_id = fac.cre(t_url)
	return t_id
end

-- scrpt method

function Inp.init(_s)

	_s._id = id._()
	pst.scrpt(_s._id, "acquire_input_focus")

	extnd._(_s, Inp)

	extnd._(_s, Inp.gui)
	_s:init_gui()

	extnd._(_s, Inp.plyr)
	_s:init_plyr()
end

function Inp.upd(_s, dt)

	if _s:is_focus_gui() then
		-- nothing
	else
		_s:upd_plyr(dt)
	end
end

function Inp.on_msg(_s, msg_id, prm, sndr_url)
	-- log._("Inp on_msg")

	if     ha.eq(msg_id, "focus__t" ) then
		-- log._("Inp on_msg focus__t", prm.focus_gui_url, prm.focus_gui_lb)

		_s._focus_gui_url = prm.focus_gui_url
		_s._focus_gui_lb  = prm.focus_gui_lb
		
	elseif ha.eq(msg_id, "focus__f") then
		-- log._("Inp on_msg focus__f")
		
		_s._focus_gui_url = ha.emp()
		_s._focus_gui_lb  = nil
	end
end

function Inp.is_focus_gui(_s)

	local ret
	if ha.is_emp(_s._focus_gui_url) then
		ret = _.f
	else
		ret = _.t
	end
	return ret
end

function Inp.on_inp(_s, key, keyact)
	-- log._("Inp on_inp")

	if _s:is_focus_gui() then
		_s:on_inp_gui(key, keyact)
	else
		_s:on_inp_plyr(key, keyact)
	end
end

function Inp.final(_s)
	pst.scrpt(_s._id, "release_input_focus")
end

