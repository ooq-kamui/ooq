log.scrpt("title.lua")

Title = {
}

-- static method

function Title.cre()
	local t_url = "/sys#title"
	local id = fac.cre(t_url)
	return id
end

-- script method

function Title.init(_s)

	_s._id = id._()
	-- _s._id = go.get_id()
	-- log._("title init", _s._id)
	
	extend._(_s, Title)
	
	local title_gui_id = fac.cre("#fac_title_gui")
	-- log._("title init title_gui_id", title_gui_id)

	Bgm.ply_rnd()
end

function Title.on_msg(_s, msg_id, prm, sender)
	
	if ha.eq(msg_id, "del") then
		_s:del()
	end
end

function Title.upd(_s, dt)
	-- log._("title", _s._id)
end

-- method

function Title.del(_s)
	go.delete(_s._id, _.t)
	-- log._("title del")
end
