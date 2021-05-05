log.scrpt("dryleaf.lua")

Dryleaf = {
	act_intrvl_time = 10,
	name_idx_max = 4,
}
Dryleaf.cls = "dryleaf"
Dryleaf.fac = Obj.fac..Dryleaf.cls
Cls.add(Dryleaf)

-- ar.idx_2_ha(Dryleaf.gold, "dryleaf")

-- static

function Dryleaf.cre(p_pos)
	local t_Cls = Dryleaf
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- script method

function Dryleaf.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Spwood)
	extend._(_s, Dryleaf)
end

function Dryleaf.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Spwood.__init(_s)
end

function Dryleaf.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Dryleaf.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	_s:per_trnsf(1 / 30 * 100, Humus)

end

function Dryleaf.final(_s)
	Sp.final(_s)
end

