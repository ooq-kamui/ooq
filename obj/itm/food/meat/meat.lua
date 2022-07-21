log.scrpt("meat.lua")

Meat = {
	act_intrvl_time = 10,
	name_idx_max = 5,

}
Meat.cls = "meat"
Meat.fac = Obj.fac..Meat.cls
Cls.add(Meat)

function Meat.cre(p_pos, prm)
	local t_Cls = Meat
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Meat.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Food)
	extnd._(_s, Meat)
end

function Meat.__init(_s, prm)
	
	Sp.__init(_s, prm)
	Hldabl.__init(_s)
	Food.__init(_s)

	_s:upd__o()
end

function Meat.upd(_s, dt)

	_s:upd_pos_sttc()

	_s:upd_final()
end

function Meat.act_intrvl(_s, dt)

	if _s:per_trnsf__humus(1 / 20 * 100) then return end
end

