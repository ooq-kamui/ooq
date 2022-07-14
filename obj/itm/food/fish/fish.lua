log.scrpt("fish.lua")

Fish = {
	act_intrvl_time = 10,
	name_idx_max = 153,
}
Fish.cls = "fish"
Fish.fac = Obj.fac..Fish.cls
Cls.add(Fish)

function Fish.cre(p_pos, prm)
	local t_Cls = Fish
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

function Fish.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Food)
	extnd._(_s, Fish)
end

function Fish.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Food  .__init(_s)

	_s:upd__o()
end

function Fish.upd(_s, dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Fish.act_intrvl(_s, dt)

	if _s:per_trnsf__humus(1 / 15 * 100) then return end
end

