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

-- script method

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
end

function Wood.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Wood.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1) then return end
end

function Wood.final(_s)

	Sp.final(_s)
end

