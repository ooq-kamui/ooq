log.scrpt("efct_sprite.lua")

Efct_sprite = {}

function Efct_sprite.init(_s)
	-- log._("efct sprite init")

	_s._cmp = "sprite"

	extend._(_s, Efct)
	extend._(_s, Efct_sprite)

	_s:id__()

	_s:w__0()
	_s:fade__i()

	-- del
	_s:life__()

	_s:z__()
	-- log._("efct init z", _s:z())
end

function Efct_sprite.on_msg(_s, msg_id, prm, sndr)

	Efct.on_msg(_s, msg_id, prm, sndr)
end

