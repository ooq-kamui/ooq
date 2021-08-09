log.scrpt("dish.lua")

Dish = {
	act_intrvl_time =  10,
	name_idx_max    = 188,
}
Dish.cls = "dish"
Dish.fac = Obj.fac..Dish.cls
Cls.add(Dish)

function Dish.cre(p_pos, prm)
	local t_Cls = Dish
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Dish.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Food)
	extnd._(_s, Dish)
end

function Dish.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Food  .__init(_s)
end

function Dish.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Dish.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1 / 20 * 100) then return end
end

