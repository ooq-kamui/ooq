log.scrpt("fruit.lua")

Fruit = {
	act_interval_time = 10,
	name_idx_max = 52,
}
Fruit.cls = "fruit"
Fruit.fac = Fruit.cls.."Fac"
Fruit.Fac = Obj.fac..Fruit.cls
Cls.add(Fruit)

-- ar.idx_2_ha(Fruit.gold, "fruit")

function Fruit.cre(pos, prm, scl)
	local Cls = Fruit
	local id = Sp.cre(Cls, pos, prm, scl)
	return id
end

-- script method

function Fruit.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Food)
	extend._(_s, Fruit)
end

function Fruit.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Fruit.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end
