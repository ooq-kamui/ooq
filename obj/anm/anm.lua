log.scrpt("anm.lua")

anm = {}
anm.time = {}
anm.time.scl = 1
anm.time.pos = 0.2
anm.time.color = 1

-- scl

function anm.scl__0(p_id, time, fnc)

	time = time or anm.time.scl

	anm._(p_id, "scale", es.fwd, vec._0, es.sin_io, time, 0, fnc)
	-- anm._(p_id, "scale", es.fwd, n.vec(1, 1), es.sin_io, time, 0)
end

function anm.scl__1(p_id, time, fnc)

	time = time or anm.time.scl

	anm._(p_id, "scale", es.fwd, vec._1, es.sin_io, time, 0, fnc)
	-- anm._(p_id, "scale", es.fwd, n.vec(1, 1), es.sin_io, time, 0)
end

-- fade

function anm.fade_o(p_id, time, fnc)

	time = time or anm.time.color

	local w = 0
	anm.fade(p_id, w, time, fnc)
end

function anm.fade_i(p_id, time, fnc)

	time = time or anm.time.color

	local w = 1
	anm.fade(p_id, w, time, fnc)
end

function anm.fade(p_id, p_w, time, fnc) -- alias ?

	anm.scl__0(p_id, time, fnc)
	-- anm.w__(p_id, p_w, time, fnc)
end

function anm.w__(p_id, p_w, time, fnc) -- prp color non

	if not p_w then return end

	time = time or anm.time.color

	anm._(p_id, "color.w", es.fwd, p_w, es.sin_o, time, 0, fnc)
end

function anm._(p_id, prp, plymode, val, esing, time, delay, fnc) -- alias
	go.animate(p_id, prp, plymode, val, esing, time, delay, fnc)
end

-- pos

function anm.pos__(p_id, p_pos, time)

	p_pos = p_pos or n.vec()
	time  = time  or anm.time.pos

	p_pos.z = id.pos(p_id).z

	anm._(p_id, "position", es.fwd, p_pos, es.sin_o, time, 0)
end

