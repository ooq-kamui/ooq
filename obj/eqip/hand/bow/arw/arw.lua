log.scrpt("arw.lua")

Arw = {
	act_intrvl_time = 5,
	name_idx_max = 1,
}

function Arw.init(_s)

	extnd.init(Sp, _s)
	extnd._(Arw, _s)

	_s._speed = 200
end

function Arw.upd(_s, dt)
	
	local move_diff = n.vec(_s._dir_h_Ha, 0) * _s._speed * dt

	_s:upd_final()
end

function Arw.act_intrvl(_s, dt)

	_s:del()
end

function Arw.on_msg(_s, msg_id, prm, sndr_url)
end

