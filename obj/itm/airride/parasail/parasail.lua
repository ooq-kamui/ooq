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
	local Cls = Parasail
	prm = prm or {}
	if not prm.animHa then prm.animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Parasail.init(_s)
	
	extend.init(_s, Airride)
	extend._(   _s, Parasail)
end

function Parasail.upd(_s, dt)

	Airride.upd(_s, dt)
end

function Parasail.on_msg(_s, msg_id, prm, sndr)

	Airride.on_msg(_s, msg_id, prm, sndr)
end

function Parasail.final(_s)

	Airride.final(_s)
end

