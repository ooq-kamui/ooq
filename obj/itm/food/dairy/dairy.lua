log.scrpt("dairy.lua")

Dairy = {
	Cls = "Dairy",
	act_intrvl_time = 10,
	name_idx_max = 8,
}
Dairy.cls = "dairy"
Dairy.fac = Obj.fac..Dairy.cls
Cls.add(Dairy)

-- ar.idx_2_ha(Dairy.gold, "dairy")

function Dairy.cre(p_pos, prm)
	local t_Cls = Dairy
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Dairy.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Food)
	extend._(_s, Dairy)
end

function Dairy.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Food  .__init(_s)
end

function Dairy.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Dairy.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end
