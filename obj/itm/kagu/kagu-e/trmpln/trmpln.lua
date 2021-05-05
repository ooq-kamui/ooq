log.scrpt("trmpln.lua")

Trmpln = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,

	jmp_lv    = 7,
	leapup_lv = 7,

	t_cls = {
		"plychara",
		"chara",
		"chara_clb_fe",
		"chara_clb_tohoku",
	},
}
Trmpln.cls = "trmpln"
Trmpln.fac = Obj.fac..Trmpln.cls
Cls.add(Trmpln)

-- static

function Trmpln.cre(p_pos, prm)
	local t_Cls = Trmpln
	prm = prm or {}
	if not prm._animHa then prm._animHa = ha._("trmpln001-stand") end
	-- if not prm._anim   then prm._anim   =      "trmpln001-stand"  end
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Trmpln.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Trmpln)
end

function Trmpln.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
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
	_s:on_msg_clsn(   msg_id, prm, sndr)

	if     ha.eq(msg_id, "leapup_anim")    then
		_s:leapup_anim()

	elseif ha.eq(msg_id, "animation_done") then

		if ha.eq(prm.id, "trmpln001-leapup") then
			_s:anim__("trmpln001-stand")
		end
	end
end

function Trmpln.on_msg_clsn(_s, msg_id, prm, sndr)
	
	-- log._("trmpln on_msg_clsn", msg_id, prm.group)

	if not ha.eq(msg_id, "contact_point_response") then return end
	
	if _s._hldd_id then return end

	local o_pos = prm.other_position
	local o_id  = prm.other_id

	-- log._("trmpln on_msg_clsn", prm.group)

	if ar.inHa(prm.group, Trmpln.t_cls) then

		local accl_speed = id.prp(o_id, "_accl_speed")
		if accl_speed.y < 0 then
			pst.scrpt(o_id, "leapup", {leapup_lv = Trmpln.leapup_lv})
			_s:leapup_anim()
		end
	end
end

function Trmpln.leapup_anim(_s)
	-- log._("trmpln leapup_anim")

	_s:anim__("trmpln001-leapup")
	Se.pst_ply("leapup")
end

function Trmpln.final(_s)
	Sp    .final(_s)
	Hldabl.final(_s)
end

