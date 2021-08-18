log.scrpt("dairy.lua")

Dairy = {
	Cls = "Dairy",
	act_intrvl_time = 10,
	name_idx_max = 8,
}
Dairy.cls = "dairy"
Dairy.fac = Obj.fac..Dairy.cls
Cls.add(Dairy)

function Dairy.cre(p_pos, prm)
	local t_Cls = Dairy
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Dairy.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Food)
	extnd._(_s, Dairy)
end

function Dairy.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Food  .__init(_s)
end

function Dairy.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Dairy.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1 / 20 * 100) then return end
end

