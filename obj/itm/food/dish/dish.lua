log.scrpt("dish.lua")

Dish = {
	act_intrvl_time = 10,
	name_idx_max = 188, -- 10,
}
Dish.cls = "dish"
Dish.fac = Dish.cls.."Fac"
Dish.Fac = Obj.fac..Dish.cls
Cls.add(Dish)

-- ar.idx_2_ha(Dish.gold, "dish")

function Dish.cre(pos, prm)
	local Cls = Dish
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Dish.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend.init(_s, Food)
	extend._(_s, Dish)
end

function Dish.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Dish.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 20 * 100, Humus) then return end
end
