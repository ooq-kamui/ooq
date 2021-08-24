log.scrpt("sys.lua")

-- system

Sys = {
	id = nil,
}

-- static

function Sys.prp(key)
	local t_url = "/sys#script"
	local val = go.get(t_url, key)
	return val
end

function Sys.prp__(key, val)
	local t_url = "/sys#script"
	go.set(t_url, key, val)
end

function Sys.cmr_id()
	local cmr_id = Sys.prp("_cmr_id")
	return cmr_id
end

function Sys.cmr_pos()
	local cmr_id = Sys.prp("_cmr_id")
	local cmr_pos = id.pos(Sys.cmr_id())
	return cmr_pos
end

function Sys.game_id()
	local game_id = Sys.prp("_game_id")
	-- log._("Sys.game_id", game_id)
	return game_id
end

function Sys.inp_id()
	local inp_id = Sys.prp("_inp_id")
	return inp_id
end

function Sys.inp_focus_gui_url()

	local inp_id = Sys.inp_id()
	-- log._("inp_id", inp_id)
	local focus_gui_url = id.prp(inp_id, "_focus_gui_url")
	return focus_gui_url
end

function Sys.is_inp_focus_gui()

	local ret
	local focus_gui_url = Sys.inp_focus_gui_url()
	if ha.is_emp(focus_gui_url) then
		ret = _.f
	else
		ret = _.t
	end
	return ret
end

-- scrpt method

function Sys.init(_s)

	extnd._(_s, Sys)
	
	Sys.id = id._()
	-- log._("Sys.init 1")

	_s._cmr_id = Cmr.cre()
	-- log._("Sys.init 2")

	_s._inp_id = Inp.cre()
	-- log._("Sys.init 3")

	_s:title()
end

function Sys.on_msg(_s, msg_id, prm, sndr_url)

	if     ha.eq(msg_id, "proxy_loaded" ) then -- camera ???
		pst._(sndr_url, "init")
		pst._(sndr_url, "enable")

	elseif ha.eq(msg_id, "title"        ) then
		_s:title()
		
	elseif ha.eq(msg_id, "game_new"     ) then
		_s:game_new(prm.ply_slt_idx)

	elseif ha.eq(msg_id, "game_continue") then
		_s:game_continue(prm.ply_slt_idx, prm.ply_data_file_idx)

	elseif ha.eq(msg_id, "msg_id__del"  ) then
		_s:msg_id__del()
	end
end

-- method

function Sys.title(_s)

	if _s._crnt_lb then _s:crnt_del() end
	
	_s._title_id = Title.cre()
	_s._crnt_lb = "title"
end

function Sys.game_new(_s, ply_slt_idx)

	if _s._crnt_lb then _s:crnt_del() end

	_s._game_id = Game.cre_new(ply_slt_idx)
	_s._crnt_lb = "game"
end

function Sys.game_continue(_s, ply_slt_idx, ply_data_file_idx)

	if _s._crnt_lb then _s:crnt_del() end

	_s._game_id = Game.cre_continue(ply_slt_idx, ply_data_file_idx)
	_s._crnt_lb = "game"
end

function Sys.crnt_del(_s)

	if not _s._crnt_lb then return end

	local key = "_".._s._crnt_lb.."_id"
	pst.scrpt(_s[key], "del")

	_s[key] = ha.emp()
	_s._crnt_lb = nil
	-- log._("sys crnt_del")
end

-- msg

-- msg static

function Sys.msg_id()
	
	local msg_id = Sys.prp("_msg_id")
	return msg_id
end

function Sys.is_exst_msg()
	
	local ret = _.f

	local msg_id = Sys.prp("_msg_id")

	if not ha.is_emp(msg_id) then ret = _.t end

	return ret, msg_id
end

-- msg method

function Sys.msg_id__del(_s)

	_s._msg_id = ha.emp()
end

function Sys.msg_id__emp(_s)

	_s._msg_id = ha.emp()
end

