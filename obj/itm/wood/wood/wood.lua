log.scrpt("wood.lua")

Wood = {
	act_intrvl_time = 10,
	name_idx_max = 4,

}
Wood.cls = "wood"
Wood.fac = Obj.fac..Wood.cls
Cls.add(Wood)

function Wood.cre(p_pos)
	local t_Cls = Wood
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- scrpt method

function Wood.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Spwood)
	extnd._(_s, Wood)
end

function Wood.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Spwood.__init(_s)

	_s:upd__o()
end

function Wood.upd(_s, dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Wood.act_intrvl(_s, dt)

	if _s:per_trnsf__humus(1) then return end
end

function Wood.final(_s)

	Sp.final(_s)
end

