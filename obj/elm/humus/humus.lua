log.scrpt("humus.lua")

Humus = {
	act_interval_time = 15,
	name_idx_max = 1,
}
Humus.cls = "humus"
Humus.fac = Humus.cls.."Fac"
Humus.Fac = Obj.fac..Humus.cls
Cls.add(Humus)

-- static

function Humus.cre(pos)
	local Cls = Humus
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Humus.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Humus)
end

function Humus.upd(_s, dt)
	
	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Humus.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- death
	if _s:per_del(1 / 5 * 100) then return end




	
end

function Humus.final(_s)
	Sp.final(_s)
end
