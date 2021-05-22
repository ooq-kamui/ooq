log.scrpt("efct_sprite.lua")

Efct_sprite = {}

function Efct_sprite.init(_s)
	-- log._("efct sprite init")

	_s._cmp = "sprite"

	extnd._(_s, Efct)
	extnd._(_s, Efct_sprite)

	_s:id__()

	_s:w__0()
	_s:fade__i()

	_s:life__() -- del

	_s:z__()
	-- log._("efct init z", _s:z())
end

function Efct_sprite.on_msg(_s, msg_id, prm, sndr_url)

	Efct.on_msg(_s, msg_id, prm, sndr_url)
end

