log.script("wood.lua")

Wood = {
	act_interval_time = 10,
	name_idx_max = 4,

}
Wood.cls = "wood"
Wood.Fac = Obj.fac..Wood.cls
Cls.add(Wood)

-- ar.idx_2_ha(Wood.gold, "wood")

function Wood.cre(pos)
	local Cls = Wood
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Wood.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Spwood)
	extend._(_s, Wood)
end

function Wood.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Wood.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_trnsf(1, Humus) then return end
end

function Wood.final(_s)
	Sp.final(_s)
end
