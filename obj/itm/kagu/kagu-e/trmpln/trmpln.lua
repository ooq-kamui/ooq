log.scrpt("trmpln.lua")

Trmpln = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,

	jmp_lv = 7,
}
Trmpln.cls = "trmpln"
Trmpln.fac = Obj.fac..Trmpln.cls
Cls.add(Trmpln)

-- static

function Trmpln.cre(p_pos, prm)
	local Cls = Trmpln
	prm = prm or {}
	if not prm._animHa then prm._animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Trmpln.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(   _s, Trmpln)
end

function Trmpln.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Trmpln.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death

end

function Trmpln.on_msg(_s, msg_id, prm, sndr)

	Sp    .on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)

	if     ha.eq(msg_id, "leapup_anim") then
		_s:leapup_anim()

	elseif ha.eq(msg_id, "animation_done") then

		if ha.eq(prm.id, "leanup") then
			_s:anim__("stand")
		end
	end
end

function Trmpln.leapup_anim(_s)
	log._("trmpln leapup_anim")

	_s:anim__( "leanup")
	Se.pst_ply("leanup")
end

function Trmpln.final(_s)
	Sp    .final(_s)
	Hldabl.final(_s)
end

