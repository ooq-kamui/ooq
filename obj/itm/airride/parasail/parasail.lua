log.scrpt("parasail.lua")

Parasail = {
	act_intrvl_time = 10,
	name_idx_max    =  1,

	weight = 2,
}
Parasail.cls = "parasail"
Parasail.fac = Obj.fac..Parasail.cls
Cls.add(Parasail)

-- static

function Parasail.cre(p_pos, prm)

	local t_Cls = Parasail

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Parasail.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Airride)
	extnd._(_s, Parasail)
end

function Parasail.__init(_s, prm)
	
	if not prm._anim then prm._anim = prm._cls.."001-stand" end

	Sp     .__init(_s, prm)
	Hldabl .__init(_s)
	Airride.__init(_s)

	_s:upd__o()
end

function Parasail.upd(_s, dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Parasail.act_intrvl(_s, dt)

	-- death

end

function Parasail.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Parasail.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

