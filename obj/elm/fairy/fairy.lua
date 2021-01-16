log.script("fairy.lua")

Fairy = {
	act_interval_time = 100,
	name_idx_max = 1,
}
Fairy.cls = "fairy"
Fairy.Fac = Obj.fac..Fairy.cls
Cls.add(Fairy)

-- static

function Fairy.cre(pos, prm)
	-- log._("Fairy.cre")
	local Cls = Fairy
	local t_id = Sp.cre(Cls, pos, prm)
	return t_id
end

function Fairy.del()
end

-- script method

function Fairy.init(_s)

	extend.init(_s, Sp)
	extend._(_s, Fairy)

	local plychara_id = Game.plychara_id()
	_s:parent__(plychara_id, 0.1, n.vec(0, Map.sqh))
end

function Fairy.upd(_s, dt)
	
end

function Fairy.on_msg(_s, msg_id, prm, sender)
	-- log._("fairy on_msg", msg_id)
	-- log.pp("msg_id", prm)
	Sp.on_msg(_s, msg_id, prm, sender)
end
