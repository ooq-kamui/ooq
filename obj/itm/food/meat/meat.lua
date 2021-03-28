log.scrpt("meat.lua")

Meat = {
	act_intrvl_time = 10,
	name_idx_max = 5,

}
Meat.cls = "meat"
Meat.fac = Obj.fac..Meat.cls
Cls.add(Meat)

-- ar.idx_2_ha(Meat.gold, "meat")

function Meat.cre(p_pos, prm)
	local Cls = Meat
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Meat.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Food)
	extend._(_s, Meat)
end

function Meat.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Meat.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end
