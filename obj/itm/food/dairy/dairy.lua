log.script("dairy.lua")

Dairy = {
	Cls = "Dairy",
	act_interval_time = 10,
	name_idx_max = 8,
}
Dairy.cls = "dairy"
Dairy.fac = Dairy.cls.."Fac"
Dairy.Fac = Obj.fac..Dairy.cls
Cls.add(Dairy)

-- ar.idx_2_ha(Dairy.gold, "dairy")

function Dairy.cre(pos, prm)
	local Cls = Dairy
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Dairy.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Holdable)
	extend.init(_s, Food)
	extend._(_s, Dairy)
end

function Dairy.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Dairy.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end
