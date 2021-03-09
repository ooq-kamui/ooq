log.scrpt("veget.lua")

Veget = {
	act_intrvl_time = 10,
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
	extend.init(_s, Hldabl)
	extend.init(_s, Food)
	extend._(_s, Veget)
end

function Veget.upd(_s, dt)
	
	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Veget.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf(1 / 40 * 100, Humus) then return end

	dice100.throw()
	if dice100.chk(7) then
		_s:trnsf(Seed)
	end
end
