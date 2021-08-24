log.scrpt("parasol.lua")

Parasol = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,
}
Parasol.cls = "parasol"
Parasol.fac = Obj.fac..Parasol.cls
Cls.add(Parasol)

-- static

function Parasol.cre(p_pos, prm)

	local t_Cls = Parasol

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Parasol.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Airride)
	extnd._(_s, Parasol)
end

function Parasol.__init(_s, prm)
	
	if not prm._anim then prm._anim = "stand" end

	Sp     .__init(_s, prm)
	Hldabl .__init(_s)
	Airride.__init(_s)

	_s:upd__dly()
end

function Parasol.upd(_s, dt)

	-- _s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Parasol.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end
	
	-- death
end

function Parasol.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Parasol.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

