log.scrpt("arw.lua")

Arw = {
	act_interval_time = 5,
	name_idx_max = 1,
}

function Arw.init(_s)

	extend.init(Sp, _s)
	extend._(Arw, _s)

	_s._speed = 200
end

function Arw.upd(_s, dt)
	
	_s:act_interval(dt)

	local move_diff = n.vec(_s._dir_h, 0) * _s._speed * dt
end

function Arw.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	_s:del()
end

function Arw.on_msg(_s, msg_id, prm, sender)
end
