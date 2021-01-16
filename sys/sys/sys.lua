log.script("system.lua")

-- system

Sys = {
	id = nil,
}

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
	-- log._("Sys cmr_id", cmr_id)
	return cmr_id
end

function Sys.cmr_pos()
	local cmr_id = Sys.prp("_cmr_id")
	local cmr_pos = id.pos(Sys.cmr_id())
	return cmr_pos
end

function Sys.game_id()
	local game_id = Sys.prp("_game_id")
	return game_id
end

-- script method

function Sys.init(_s)

	extend._(_s, Sys)
	
	Sys.id = go.get_id()

	-- camera
	_s._cmr_id = Cmr.cre()

	-- gui
	Gui_inp.cre()

	-- title
	_s:title()
end

function Sys.on_msg(_s, msg_id, prm, sender)

	if     ha.eq(msg_id, "proxy_loaded") then -- camera ???
		pst._(sender, "init")
		pst._(sender, "enable")

	elseif ha.eq(msg_id, "title") then
		_s:title()
		
	elseif ha.eq(msg_id, "game_new") then
		_s:game_new(prm.ply_slt_idx)

	elseif ha.eq(msg_id, "game_continue") then
		_s:game_continue(prm.ply_slt_idx, prm.ply_data_file_idx)

	elseif ha.eq(msg_id, "msg_id__del") then
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
	pst.script(_s[key], "del")

	_s[key] = ha.emp()
	_s._crnt_lb = nil
	-- log._("sys crnt_del")
end

function Sys.msg_cre()
	log._("Sys.msg_cre")

	local msg_id = Msg.cre()
	return msg_id
end

function Sys.msg_id()
	
	local msg_id = Sys.prp("_msg_id")
	log._("Sys.msg_id", msg_id)

	if not ha.is_emp(msg_id) then return msg_id end

	-- msg_id = fac.cre("/sys#fac_msg_gui")
	-- msg_id = Msg.cre()
	msg_id = Sys.msg_cre()
	log._("Sys.msg_id cre", msg_id)
	Sys.prp__("_msg_id", msg_id)
	
	return msg_id
end

function Sys.msg_id__del(_s)

	_s._msg_id = ha.emp()
end
