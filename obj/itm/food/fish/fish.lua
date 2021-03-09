log.scrpt("fish.lua")

Fish = {
	act_intrvl_time = 10,
	name_idx_max = 153,
}
Fish.cls = "fish"
Fish.fac = Fish.cls.."Fac"
Fish.Fac = Obj.fac..Fish.cls
Cls.add(Fish)

-- ar.idx_2_ha(Fish.gold, "fish")

function Fish.cre(pos, prm)
	local Cls = Fish
	local id = Sp.cre(Cls, pos, prm)
	return id
end

function Fish.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Food)
	extend._(_s, Fish)
end

function Fish.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Fish.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 15 * 100, Humus) then return end
end
