log.scrpt("plant.lua")

Plant = {
	act_interval_time = 15,
	name_idx_max = 91,
}
Plant.cls = "plant"
Plant.fac = Plant.cls.."Fac"
Plant.Fac = Obj.fac..Plant.cls
Cls.add(Plant)

-- static

function Plant.cre(pos)
	local Cls = Plant
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Plant.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Plant)
end

function Plant.upd(_s, dt)
	
	_s:act_interval(dt)
	
	_s:upd_pos_static(dt)
end

function Plant.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

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
