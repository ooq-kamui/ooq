log.script("reizoko.lua")

Reizoko = {
	act_interval_time = 20,
	name_idx_max = 1,
	z = 0.1,
}
Reizoko.cls = "reizoko"
Reizoko.fac = "kaguFac"
Reizoko.Fac = Obj.fac..Reizoko.cls
Cls.add(Reizoko)

-- static

function Reizoko.cre(pos)
	local Cls = Reizoko
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Reizoko.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Holdable)
	extend._(_s, Reizoko)
end

function Reizoko.upd(_s, dt)

	_s:upd_pos_static(dt)

	_s:act_interval(dt)
end

function Reizoko.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	
end

function Reizoko.on_msg(_s, msg_id, prm, sender)
	
	Sp.on_msg(_s, msg_id, prm, sender)
	Holdable.on_msg(_s, msg_id, prm, sender)

	if     ha.eq(msg_id, "opn") then
		_s:opn()
		
	elseif ha.eq(msg_id, "clz") or ha.eq(msg_id, "colse") then
		_s:clz()
		
	elseif ha.eq(msg_id, "into_reizoko") then
		_s:into_reizoko(prm.food_id)

		--[[
	elseif ha.eq(msg_id, "take_reizoko") then
		_s:take_reizoko(prm.item_idx)
		--]]
	end
end

function Reizoko.final(_s)
	Sp.final(_s)
	Holdable.final(_s)
end

-- method

function Reizoko.opn(_s)
	fac.cre("#fac_reizoko_gui")
end

function Reizoko.into_reizoko(_s, food_id)

	local cls = id.cls(food_id)
	
	if not ar.inHa(cls, Food.cls) then return end
	
	Ply_data.reizoko__add({cls = cls, name = id.name(food_id)})
	
	pst.script(food_id, "into_reizoko")
end

--[[
function Reizoko.take_reizoko(_s, food_idx)
	pst.gui(Reizoko_gui.id, "del", {food_idx = food_idx})
end
--]]
