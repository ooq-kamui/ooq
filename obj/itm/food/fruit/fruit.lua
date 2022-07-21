log.scrpt("fruit.lua")

Fruit = {
	act_intrvl_time = 10,
	name_idx_max    = 52,
}
Fruit.cls = "fruit"
Fruit.fac = Obj.fac..Fruit.cls
Cls.add(Fruit)

function Fruit.cre(p_pos, prm, scl)
	local t_Cls = Fruit
	local t_id = Sp.cre(t_Cls, p_pos, prm, scl)
	return t_id
end

-- scrpt method

function Fruit.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Food)
	extnd._(_s, Fruit)
end

function Fruit.__init(_s, prm)
	
	Sp.__init(_s, prm)
	Hldabl.__init(_s)
	Food.__init(_s)

	_s:upd__o()
end

function Fruit.upd(_s, dt)

	_s:upd_pos_sttc()

	_s:upd_final()
end

function Fruit.act_intrvl(_s, dt)

	if _s:per_trnsf__humus(1 / 20 * 100) then return end
end

