log.scrpt("es.lua")

-- easing

es = {}
es.sin_o  = go.EASING_OUTSINE
es.sin_io = go.EASING_INOUTSINE
es.bnd_i  = go.EASING_INBOUNCE
es.bnd_o  = go.EASING_OUTBOUNCE

-- play mode

anm.plymode = {}
apm = anm.plymode -- alias
apm.pinpon = go.PLAYBACK_ONCE_PINGPONG
apm.fwd    = go.PLAYBACK_ONCE_FORWARD

-- old
es.pinpon = apm.pinpon
es.fwd    = apm.fwd
-- es.pinpon = go.PLAYBACK_ONCE_PINGPONG
-- es.fwd    = go.PLAYBACK_ONCE_FORWARD

