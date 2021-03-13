log.scrpt("gold.lua")

Gold = {
	act_intrvl_time = 0.4,
	name_idx_max = 1, -- 6,
}
Gold.cls = "gold"
Gold.fac = Obj.fac..Gold.cls
Cls.add(Gold)

-- static

function Gold.cre(pos, prm)
	local Cls = Gold
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Gold.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Gold)
	
	_s._id = id._()

	go.set("#label", "scale", n.vec(1.5, 1.5))
	label.set_text("#label", "x ".._s._price)

	local y = _s:pos().y
	local anim = {}
	anim[1] = function ()
		go.animate(_s._id, "position.y", es.fwd, y + Map.sq*3/4, es.sin_o, 0.35, 0, anim[2])
	end
	anim[2] = function ()
		go.animate(_s._id, "position.y", es.fwd, y             , es.bnd_o, 1.2 , 0, anim[3])
	end
	anim[3] = function ()
		_s:del()
	end
	anim[1]()
end

function Gold.upd(_s, dt)
end

function Gold.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
end

function Gold.final(_s)
	Sp.final(_s)
end

