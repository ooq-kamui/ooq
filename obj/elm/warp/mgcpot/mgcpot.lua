log.scrpt("mgcpot.lua")

Mgcpot = {
	act_intrvl_time = 50,
	name_idx_max = 1,
}
Mgcpot.cls = "mgcpot"
Mgcpot.fac = Obj.fac..Mgcpot.cls
Cls.add(Mgcpot)

function Mgcpot.cre(p_pos, prm)

	local t_Cls = Mgcpot

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Mgcpot.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Warp)
	extnd._(_s, Mgcpot)
end

function Mgcpot.__init(_s, prm)
	
	if not prm._anim then prm._anim = prm._cls.."001-stand" end

	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Warp  .__init(_s)
end

function Mgcpot.upd(_s, dt)

	-- _s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Mgcpot.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
end

function Mgcpot.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	_s:on_msg_clsn(   msg_id, prm, sndr_url) -- warp
end

function Mgcpot.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

