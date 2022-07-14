log.scrpt("mgccrcl.lua")

Mgccrcl = {
	act_intrvl_time = 50,
	name_idx_max = 1,
}
Mgccrcl.cls = "mgccrcl"
Mgccrcl.fac = Obj.fac..Mgccrcl.cls
Cls.add(Mgccrcl)

function Mgccrcl.cre(p_pos, prm)

	local t_Cls = Mgccrcl

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Mgccrcl.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Warp)
	extnd._(_s, Mgccrcl)
end

function Mgccrcl.__init(_s, prm)
	
	if not prm._anim then prm._anim = prm._cls.."001-stand" end

	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Warp  .__init(_s)

	_s:upd__o()
end

function Mgccrcl.upd(_s, dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Mgccrcl.act_intrvl(_s, dt)

	-- death

end

function Mgccrcl.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)

	_s:on_msg_clsn(   msg_id, prm, sndr_url) -- warp
end

function Mgccrcl.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

