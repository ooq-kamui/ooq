log.scrpt("fairy.lua")

Fairy = {
	act_intrvl_time = 100,
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

-- function Fairy.del() -- use ?
-- end

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

	if ha.eq(msg_id, "magic") then
		_s:magic()

	else
		Sp.on_msg(_s, msg_id, prm, sender)
	end

end

function Fairy.magic(_s)
	-- log._("fairy magic")

	-- local tilepos = Magic.tilepos_by_inp_prm(_s._dir_h, prm)
	Magic.cre(_s:pos_w())
	-- Magic.cre(_s:pos())
	-- Magic.cre(_s:pos(), tilepos)
end

