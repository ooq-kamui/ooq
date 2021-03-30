log.scrpt("door.lua")

Door = {
	act_intrvl_time = 60,
	name_idx_max = 1,
	z = 0.1,
}
Door.cls = "door"
Door.fac = Obj.fac..Door.cls
Cls.add(Door)

-- static

function Door.cre(p_pos, prm)
	local Cls = Door
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Door.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Door)
end

function Door.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Door.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	
end

function Door.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
	
	if ha.eq(msg_id, "opn") then
		_s:opn()
	end
end

function Door.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

-- method

function Door.opn(_s)
	-- Door_gui.cre_open()
	fac.cre("#fac_door_gui")
end

