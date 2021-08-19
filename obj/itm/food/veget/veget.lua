log.scrpt("veget.lua")

Veget = {
	act_intrvl_time = 10,
	name_idx_max = 98,

}
Veget.cls = "veget"
Veget.fac = Obj.fac..Veget.cls
Cls.add(Veget)

-- static

function Veget.cre(p_pos, prm)
	local t_Cls = Veget
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Veget.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Food)
	extnd._(_s, Veget)
end

function Veget.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Food  .__init(_s)
end

function Veget.upd(_s, dt)
	
	-- _s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Veget.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1 / 40 * 100) then return end

	dice100.throw()
	if dice100.chk(7) then
		_s:trnsf(Seed)
	end
end

