log.scrpt("shelf.lua")

Shelf = {

	act_interval_time = 10,
	name_idx_max = 1,
	z = 0.1,

	weight = 2,
}
Shelf.cls = "shelf"
Shelf.fac = "kaguFac"
Cls.add(Shelf)

-- static

function Shelf.cre(pos, prm)
	local Cls = Shelf
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Shelf.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Shelf)
end

function Shelf.upd(_s, dt)

	_s:act_interval(dt)
	
	_s:upd_pos_static(dt)
end

function Shelf.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- log._("shelf z", _s:z())

end

function Shelf.on_msg(_s, msg_id, prm, sender)
	
	Sp.on_msg(_s, msg_id, prm, sender)
	Hldabl.on_msg(_s, msg_id, prm, sender)
	
	if ha.eq(msg_id, "opn") then
		_s:opn()
	end
end

function Shelf.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

-- method

function Shelf.opn(_s)
	fac.cre("#fac_shelf_gui")
end

