log.scrpt("o_anim.lua")

O_anim = {}

O_es = {}
O_es.sin_o  = go.EASING_OUTSINE
O_es.sin_io = go.EASING_INOUTSINE
O_es.bnd_i  = go.EASING_INBOUNCE
O_es.bnd_o  = go.EASING_OUTBOUNCE

O_es.pinpon = go.PLAYBACK_ONCE_PINGPONG
O_es.fwd    = go.PLAYBACK_ONCE_FORWARD

function O_anim.scl__1(id, time)
	-- log._("o_anim scl__1", id)
	time = time or 1
	go.animate(id, "scale", O_es.fwd, n.vec(1, 1), O_es.sin_io, time, 0)
end
