log.scrpt("balloon.lua")

Balloon = {
	act_intrvl_time = 10,
	name_idx_max    =  1,
}
Balloon.cls = "balloon"
Balloon.fac = Obj.fac..Balloon.cls
Cls.add(Balloon)

-- static

function Balloon.cre(p_pos, prm)
	local t_Cls = Balloon
	prm = prm or {}
	if not prm._animHa then prm._animHa = ha._("stand") end
	-- if not prm._anim   then prm._anim   =      "stand"  end
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Balloon.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Balloon)
end

function Balloon.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Balloon.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Balloon.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death

end

function Balloon.on_msg(_s, msg_id, prm, sndr)
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Balloon.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

