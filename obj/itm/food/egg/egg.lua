log.script("egg.lua")

Egg = {
	act_interval_time = 10,
	name_idx_max = 3,
}
Egg.cls = "egg"
Egg.Fac = Obj.fac..Egg.cls
Cls.add(Egg)

-- ar.idx_2_ha(Egg.gold, "egg")

function Egg.cre(pos, prm)
	local Cls = Egg
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Egg.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Holdable)
	extend.init(_s, Food)
	extend._(_s, Egg)
end

function Egg.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)

end

function Egg.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end

	_s:per_trnsf(1 / 25 * 100, Animal, {name = ha._(rnd.ar(Animal.bird))})
end
