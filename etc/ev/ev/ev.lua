log.scrpt("ev.lua")

Ev = {
	id = nil,
	scnro = nil, -- current exe scnro
}

-- static

function Ev._(name)
	Ev.scnro = Scnro[name]
	pst.scrpt(Ev.id, "start")
end

function Ev.cre()
	local url = "/sys#ev"
	local t_id = fac.cre(url)
	Ev.id = t_id
	return t_id
end

function Ev.fin()
end

-- script method

function Ev.init(_s)
	extend._(_s, Ev)
	_s.idx = 0
end

function Ev.on_msg(_s, msg_id, prm, sndr)
	if     ha.eq(msg_id, "start") then
		_s:_start()
	
	elseif ha.eq(msg_id, "do") then
		_s:_do(prm.idx)

	elseif ha.eq(msg_id, "wa_inp") then
		_s:_wa_inp()
	
	elseif ha.eq(msg_id, "wa_inp_fin") then
		_s:_wa_inp_fin()

	elseif ha.eq(msg_id, "wa_sec") then
		_s:_wa_sec()
	
	elseif ha.eq(msg_id, "wa_sec_fin") then
		_s:_wa_sec_fin()
	end
end

-- method

function Ev._start(_s)
	_s.idx = 1
	_s:_do()
end

function Ev._do(_s)
	
	if not Ev.scnro[_s.idx] then return end
	
	Ev.scnro[_s.idx]()
	
	_s.idx = _s.idx + 1
end

function Ev._wa_inp(_s)
end

function Ev._wa_inp_fin(_s)
	_s:_do()
end

function Ev._wa_sec(_s)
end

function Ev._wa_sec_fin(_s)
	_s:_do()
end

