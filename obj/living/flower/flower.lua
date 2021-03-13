log.scrpt("flower.lua")

Flower = {
	act_intrvl_time = 100,
	name_idx_max = 159,
}
Flower.cls = "flower"
Flower.fac = Obj.fac..Flower.cls
Cls.add(Flower)

-- ar.idx_2_ha(Flower.gold, "flower")

-- static

function Flower.cre(pos, prm)
	local Cls = Flower
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Flower.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Flower)
end

function Flower.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Flower.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 15 * 100, Humus) then return end
	
	if _s:per_trnsf(10, Seed) then return end

	if _s:per_trnsf(10, Fluff) then return end
end

function Flower.on_msg(_s, msg_id, prm, sender)
	Sp.on_msg(_s, msg_id, prm, sender)
	Hldabl.on_msg(_s, msg_id, prm, sender)
end

function Flower.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end
