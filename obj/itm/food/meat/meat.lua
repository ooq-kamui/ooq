log.script("meat.lua")

Meat = {
	act_interval_time = 10,
	name_idx_max = 5,

}
Meat.cls = "meat"
Meat.fac = Meat.cls.."Fac"
Meat.Fac = Obj.fac..Meat.cls
Cls.add(Meat)

-- ar.idx_2_ha(Meat.gold, "meat")

function Meat.cre(pos, prm)
	local Cls = Meat
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Meat.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Food)
	extend._(_s, Meat)
end

function Meat.upd(_s, dt)

	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Meat.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end
