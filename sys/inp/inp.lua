log.scrpt("inp.lua")

Inp = {}

-- static

function Inp.cre()

	local t_url = url._("/sys", "fac_inp")
	local id = fac.cre(t_url)
	return id
end

-- script method

function Inp.init(_s)

	_s._id = id._()
	pst.scrpt(_s._id, "acquire_input_focus")

	extend._(_s, Inp)

	extend._(_s, Inp.gui)
	_s:init_gui()

	extend._(_s, Inp.plyr)
	_s:init_plyr()
end

function Inp.upd(_s, dt)

	if _s:is_focus_gui() then
		-- nothing
	else
		_s:upd_plyr(dt)
	end
end

function Inp.on_msg(_s, msg_id, prm, sender)
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

