log.scrpt("obj_anm.lua")

obj_anm = {}
obj_anm.time = {}
obj_anm.time.scl = 1
obj_anm.time.pos = 0.2

function obj_anm.scl__1(p_id, time)
	-- log._("obj_anm scl__1", p_id)

	time = time or obj_anm.time.scl

	go.animate(p_id, "scale", es.fwd, n.vec(1, 1), es.sin_io, time, 0)
end

function obj_anm.pos__(p_id, p_pos, time)

	p_pos = p_pos or n.vec()
	time  = time  or obj_anm.time.pos

	p_pos.z = id.pos(p_id).z

	go.animate(p_id, "position", es.fwd, p_pos, es.sin_o, time, 0)
end

