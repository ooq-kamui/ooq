log.scrpt("plant.lua")

Plant = {
	act_intrvl_time = 15,
	name_idx_max = 91,
}
Plant.cls = "plant"
Plant.fac = Obj.fac..Plant.cls
Cls.add(Plant)

-- static

function Plant.cre(p_pos)
	local t_Cls = Plant
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- script method

function Plant.init(_s)

	extend._(_s, Sp)
	extend._(_s, Plant)
end

function Plant.__init(_s, prm)
	
	Sp.__init(_s, prm)
end

function Plant.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Plant.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf(1 / 10 * 100, Humus) then return end

	dice100.throw()
	if     dice100.chk(15) then
		_s:trnsf(Veget)

	elseif dice100.chk(15) then
		_s:trnsf(Tree)

	elseif dice100.chk(15) then
		_s:trnsf(Bush)
	end
end

function Plant.final(_s)

	Sp.final(_s)
end

