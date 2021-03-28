log.scrpt("fruit.lua")

Fruit = {
	act_intrvl_time = 10,
	name_idx_max = 52,
}
Fruit.cls = "fruit"
Fruit.fac = Obj.fac..Fruit.cls
Cls.add(Fruit)

-- ar.idx_2_ha(Fruit.gold, "fruit")

function Fruit.cre(p_pos, prm, scl)
	local Cls = Fruit
	local t_id = Sp.cre(Cls, p_pos, prm, scl)
	return t_id
end

-- script method

function Fruit.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Food)
	extend._(   _s, Fruit)
end

function Fruit.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Fruit.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt)  then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end

