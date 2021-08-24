log.scrpt("shtngstr.lua")

Shtngstr = {
	act_intrvl_time = 10,
	name_idx_max    =  1,
}
Shtngstr.cls = "shtngstr"
Shtngstr.fac = Obj.fac..Shtngstr.cls
Cls.add(Shtngstr)

-- static

function Shtngstr.cre(p_pos, prm)

	local t_Cls = Shtngstr

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Shtngstr.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Shtngstr)
end

function Shtngstr.__init(_s, prm)
	
	if not prm._anim then prm._anim = "stand" end

	Sp    .__init(_s, prm)
	Hldabl.__init(_s)

	_s:upd__dly()
end

function Shtngstr.upd(_s, dt)

	-- _s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Shtngstr.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	
end

function Shtngstr.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Shtngstr.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

