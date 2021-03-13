log.scrpt("leafFac.script")

Leaf = {
	act_intrvl_time = 10,
	name_idx_max = 4,

}
Leaf.cls = "leaf"
-- Leaf.fac = Leaf.cls.."Fac"
Leaf.Fac = Obj.fac..Leaf.cls
Cls.add(Leaf)

-- ar.idx_2_ha(Leaf.gold, "leaf")

function Leaf.cre(pos)
	local Cls = Leaf
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Leaf.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Spwood)
	extend._(_s, Leaf)
end

function Leaf.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Leaf.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
	
	if _s:per_trnsf(1 / 20 * 100, Dryleaf) then return end
end

function Leaf.final(_s)
	Sp.final(_s)
end
