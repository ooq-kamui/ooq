log.scrpt("egg.lua")

Egg = {
	act_intrvl_time = 10,
	name_idx_max = 3,
}
Egg.cls = "egg"
Egg.fac = Obj.fac..Egg.cls
Cls.add(Egg)

function Egg.cre(p_pos, prm)
	local t_Cls = Egg
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Egg.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Food)
	extnd._(_s, Egg)
end

function Egg.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Food  .__init(_s)

	_s:upd__o()
end

function Egg.upd(_s, dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Egg.act_intrvl(_s, dt)

	if _s:per_trnsf__humus(1 / 20 * 100) then return end

	_s:per_trnsf(1 / 25 * 100, Anml, {name = ha._(rnd.ar(Anml.bird))})
end

