log.scrpt("anm.lua")

anm = {}
anm.time = {}
anm.time.scl = 1
anm.time.pos = 0.2

-- obj_anm = anm -- old

function anm.scl__1(p_id, time)
	-- log._("anm scl__1", p_id)

	time = time or anm.time.scl

	go.animate(p_id, "scale", es.fwd, n.vec(1, 1), es.sin_io, time, 0)
end

function anm.pos__(p_id, p_pos, time)

	p_pos = p_pos or n.vec()
	time  = time  or anm.time.pos

	p_pos.z = id.pos(p_id).z

	go.animate(p_id, "position", es.fwd, p_pos, es.sin_o, time, 0)
end

