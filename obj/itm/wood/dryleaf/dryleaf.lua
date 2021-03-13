log.scrpt("dryleaf.lua")

Dryleaf = {
	act_intrvl_time = 10,
	name_idx_max = 4,
}
Dryleaf.cls = "dryleaf"
-- Dryleaf.fac = Dryleaf.cls.."Fac"
Dryleaf.Fac = Obj.fac..Dryleaf.cls
Cls.add(Dryleaf)

-- ar.idx_2_ha(Dryleaf.gold, "dryleaf")

-- static

function Dryleaf.cre(pos)
	local Cls = Dryleaf
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Dryleaf.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Spwood)
	extend._(_s, Dryleaf)
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
