log.script("veget.lua")

Veget = {
	act_interval_time = 10,
	name_idx_max = 98,

}
Veget.cls = "veget"
Veget.Fac = Obj.fac..Veget.cls
Cls.add(Veget)

-- ar.idx_2_ha(Veget.gold, "veget")

-- static

function Veget.cre(pos, prm)
	local Cls = Veget
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Veget.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Holdable)
	extend.init(_s, Food)
	extend._(_s, Veget)
end

function Veget.upd(_s, dt)
	
	_s:act_interval(dt)

	_s:upd_pos_static(dt)
end

function Veget.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	if _s:per_trnsf(1 / 40 * 100, Humus) then return end

	dice100.throw()
	if dice100.chk(7) then
		_s:trnsf(Seed)
	end
end
