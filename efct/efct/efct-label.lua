log.scrpt("efct-label.lua")

Efct_label = {}

-- script method

function Efct_label.init(_s)

	_s._cmp = "label"

	extend._(_s, Efct)
	extend._(_s, Efct_label)

	_s:id__()
	_s:life__() -- del
	_s:z__()
	-- log._("efct init z", _s:z())
end

function Efct_label.on_msg(_s, msg_id, prm, sndr)

	-- log._("Efct_label.on_msg", msg_id, prm.txt)

	if ha.eq(msg_id, "__txt") then
		_s:__txt(prm.txt)
	end

	Efct.on_msg(_s, msg_id, prm, sndr)
end

-- method

function Efct_label.life__(_s)

	local fnc = function (slf, hndl, elpsd)
		-- _s:fade__o__del()
		_s:del()
	end
	local hndl = timer.delay(_s._lifetime, _.f, fnc)
end

function Efct_label.__txt(_s, txt)

	label.set_text("#label", txt)
end

