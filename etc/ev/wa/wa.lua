log.scrpt("wa.lua")

Wa = {}

-- static

function Wa._(sec)
	Wa.cre(sec)
end

function Wa.cre(sec)
	local url = "/sys#wa"
	-- local id = factory.create(url)
	local id = fac.cre(url)
	pst.scrpt(id, "wa", {sec = sec})
	return id
end

-- script method

function Wa.init(_s)
	extend._(_s, Wa)
	_s.sec = 0 -- wait sec
end

function Wa.upd(_s, dt)
	
	if _s.sec < 0 then return end
	
	_s.sec = _s.sec - dt
	if _s.sec < 0 then _s:wa_fin() end
end

function Wa.on_msg(_s, msg_id, prm, sndr)
	if     ha.eq(msg_id, "wa") then
		_s:wa(prm.sec)
	
	elseif ha.eq(msg_id, "wa_fin") then
		_s:wa_fin()
	end
end

-- method

function Wa.wa(_s, sec)
	-- log._("wa wa", sec)
	_s.sec = sec
end

function Wa.wa_fin(_s)
	-- log._("wa_fin")
	pst.scrpt(Ev.id, "wa_sec_fin")
	go.delete()
end

