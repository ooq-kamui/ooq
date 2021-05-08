log.scrpt("title.lua")

Title = {
}

-- static method

function Title.cre()
	local t_url = "/sys#title"
	local t_id = fac.cre(t_url)
	return t_id
end

-- script method

function Title.init(_s)

	_s._id = id._()
	
	extend._(_s, Title)
	
	local t_id = fac.cre("#fac_title_gui")

	Bgm.ply_rnd()
end

function Title.on_msg(_s, msg_id, prm, sndr_url)
	
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

