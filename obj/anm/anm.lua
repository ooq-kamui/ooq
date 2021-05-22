log.scrpt("anm.lua")

anm = {}
anm.time = {}
anm.time.scl  = 1
anm.time.pos  = 0.2
anm.time.tint = 1
-- anm.time.color = anm.time.tint -- old

-- scl

function anm.scl__0(p_id, time, fnc)

	time = time or anm.time.scl

	anm.scl__(p_id, vec._0, time, fnc)
end

function anm.scl__1(p_id, time, fnc)

	time = time or anm.time.scl

	anm.scl__(p_id, vec._1, time, fnc)
end

function anm.scl__(p_id, p_vec, time, fnc)

	time = time or anm.time.scl

	anm._(p_id, "scale", apm.fwd, p_vec, es.sin_io, time, 0, fnc)
end

-- fade

function anm.fade__o(p_id, p_cmp, time, delay, fnc)

	time = time or anm.time.tint

	local w = 0
	anm.fade__(p_id, p_cmp, w, time, delay, fnc)
end

function anm.fade__i(p_id, p_cmp, time, delay, fnc)

	time = time or anm.time.tint

	local w = 1
	anm.fade__(p_id, p_cmp, w, time, delay, fnc)
end

function anm.fade__(p_id, p_cmp, p_w, time, delay, fnc)

	anm.w__(p_id, p_cmp, p_w, time, delay, fnc)
end

function anm.w__(p_id, p_cmp, p_w, time, delay, fnc)

	if not p_id  then return end
	if not p_cmp then return end
	if not p_w   then return end

	time  = time  or anm.time.tint
	delay = delay or 0

	local t_url = url._(p_id, p_cmp)
	anm._(t_url, "tint.w", apm.fwd, p_w, es.sin_o, time, delay, fnc)
end

function anm.drk__o(p_id, p_cmp, time, delay, fnc)

	time = time or anm.time.tint

	local v = 1
	local vec4 = vmath.vector4(v, v, v, 1)
	anm.drk__(p_id, p_cmp, vec4, time, delay, fnc)
end

function anm.drk__i(p_id, p_cmp, time, delay, fnc)

	time = time or anm.time.tint

	local v = 0.6
	local vec4 = vmath.vector4(v, v, v, 1)
	anm.drk__(p_id, p_cmp, vec4, time, delay, fnc)
end

function anm.drk__(p_id, p_cmp, p_vec4, time, delay, fnc)

	if not p_id   then return end
	if not p_cmp  then return end
	if not p_vec4 then return end

	time  = time  or anm.time.tint
	delay = delay or 0

	local t_url = url._(p_id, p_cmp)
	anm._(t_url, "tint", apm.fwd, p_vec4, es.sin_o, time, delay, fnc)
end

-- pos

function anm.pos__(p_id, p_pos, time, delay)
	-- log._("anm.pos__")

	p_pos = p_pos or n.vec()
	time  = time  or anm.time.pos
	delay = delay or 0

	p_pos.z = id.pos(p_id).z

	anm._(p_id, "position", apm.fwd, p_pos, es.sin_o, time, delay)
end

function anm.pos_y__anm(p_id, p_y, time)
	-- log._("anm.pos_y__anm")

	anm._(p_id, "position.y", apm.fwd, p_y, es.sin_o, time, 0)
end

function anm._(t_url, prp, plymode, val, esing, time, delay, fnc) -- alias

	delay = delay or 0

	go.animate(t_url, prp, plymode, val, esing, time, delay, fnc)
end

