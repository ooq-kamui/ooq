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
	local Cls = Parasol
	prm = prm or {}
	if not prm.animHa then prm.animHa = ha._("stand") end
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Parasol.init(_s)
	
	extend.init(_s, Para)
	extend._(   _s, Parasol)
end

function Parasol.upd(_s, dt)

	Para.upd(_s, dt)
end

function Parasol.on_msg(_s, msg_id, prm, sndr)

	Para.on_msg(_s, msg_id, prm, sndr)
end

function Parasol.final(_s)

	Para.final(_s)
end

