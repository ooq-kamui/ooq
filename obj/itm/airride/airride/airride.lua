log.scrpt("airride.lua")

 Airride = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,
}

-- script method

function Airride.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(   _s, Airride)
end

function Airride.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Airride.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	
end

function Airride.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Airride.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

